package com.dondog.dbapp.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.BoardDao;
import com.dondog.dbapp.dto.CommuntyDto;
import com.dondog.dbapp.dto.CompanySerciceDto;
import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HostBoardDto;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.ReplyDto;
import com.dondog.dbapp.dto.ReviewDto;
import com.dondog.dbapp.util.Paging;

import lombok.extern.java.Log;

@Service
@Log
public class BoardService {

	@Autowired
	private BoardDao bDao;

	private ModelAndView mv;
	@Autowired
	private HttpSession session;

	// 게시글 등록 서비스 메소드
	@Transactional
	public String boardInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		log.info("boardInsert()");

		String view = null;

		String id = multi.getParameter("m_id");
		String title = multi.getParameter("b_title");
		String contents = multi.getParameter("b_contents");
		String check = multi.getParameter("fileCheck");

		contents = contents.trim();

		System.out.println("아이디" + id);
		System.out.println("제목" + title);
		System.out.println("내용" + contents);

		CommuntyDto board = new CommuntyDto();

		board.setM_id(id);
		board.setB_title(title);
		board.setB_contents(contents);

		try {
			bDao.boardInsert(board);

			//파일 업로드 메소드 호출
			if(check.equals("1")) {
				fileUp(multi, board.getB_num());
			}

			view = "redirect:list";
			rttr.addFlashAttribute("msg", "글 등록 성공");
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:boardWrite";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}

		return view;
	}

	// 게시글 파일 업로드 처리 메소드
	public boolean fileUp(MultipartHttpServletRequest multi, String b_num) throws Exception {
		// 저장공간에 대한 절대 경로 구하기
		String path = multi.getSession().getServletContext().getRealPath("/");

		path += "resources/upload/";
		log.info(path);

		File dir = new File(path);

		if (dir.isDirectory() == false) {
			dir.mkdir();// 폴더가 없을 경우 폴더 생성.
		}

		// 실제 파일명과 저장 파일명을 함께 관리
		Map<String, String> fmap = new HashMap<String, String>();

		fmap.put("b_num", String.valueOf(b_num));

		// 파일 전송시 기본 값을 파일다중 선택임.
		// 멀티파트 요청 객체에서 꺼내올 때는 List를 사용.
		List<MultipartFile> fList = multi.getFiles("files");

		for (int i = 0; i < fList.size(); i++) {
			MultipartFile mf = fList.get(i);
			String on = mf.getOriginalFilename();
			fmap.put("f_oriname", on);

			// 변경된 파일 이름 저장
			String sn = System.currentTimeMillis() + "." // 확장자 구분 점
					+ on.substring(on.lastIndexOf(".") + 1);
			fmap.put("f_sysname", sn);

			// 해당 폴더에 파일 저장하기
			mf.transferTo(new File(path + sn));

			bDao.fileInsert(fmap);
		}

		return true;
	}

	// 게시글 목록 가져오는 메소드
	public ModelAndView getBoardList(Integer pageNum) {

		mv = new ModelAndView();

		int num = (pageNum == null) ? 1 : pageNum;

		List<CommuntyDto> cList = bDao.getList(num);

		// DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("cList", cList);

		// 페이징 처리
		mv.addObject("paging", getPaging(num));

		// 세션에 페이지 번호 저장
		session.setAttribute("pageNum", num);

		mv.setViewName("boardList");

		return mv;

	}

	private String getPaging(int num) {
		// 전체 글 개수 구하기(from DB)
		int maxNum = bDao.getBoardCnt();

		// 설정값(페이지 당 글 개수, 그룹 당 페이지 개수, 게시판 이름)
		int listCnt = 10;
		int pageCnt = 2;
		String listName = "list";

		Paging paging = new Paging(maxNum, num, listCnt, pageCnt, listName);

		String pagingHtml = paging.makePaging();

		return pagingHtml;

	}

	// 게시글 보기
	public ModelAndView getContents(String b_num) {
		mv = new ModelAndView();

		// 조회수 1 증가
		bDao.viewUpdate(b_num);

		// 글 내용 가져오기
		CommuntyDto board = bDao.getContents(b_num);

		//파일목록 가져오기
		List<FileDto> bfList = bDao.getBfList(b_num);

		// 댓글목록 가져오기
		List<ReplyDto> rList = bDao.getReplyList(b_num);

		// 모델 데이터 담기
		mv.addObject("board", board);
		mv.addObject("bfList", bfList);
		mv.addObject("rList", rList);

		// 뷰 이름 지정하기
		mv.setViewName("boardContents");

		return mv;
	}

	public void fileDown(String f_sysname, 
			HttpServletRequest request, 
			HttpServletResponse response) {
		//서버의 파일 위치의 절대 경로 구하기
		String path = request.getSession().getServletContext()
				.getRealPath("/");

		path += "resources/upload/";
		log.info(path);

		String f_oriname = bDao.getOriName(f_sysname);
		path += f_sysname;//다운로드할 파일경로+파일명

		//서버 저장장치(디스크)에서 저장된 파일을 읽어오는 통로
		InputStream is = null;
		//사용자 컴퓨터에 파일을 보내는 통로
		OutputStream os = null;

		try {
			//파일명 인코딩(파일명이 한글일 때 깨짐을 방지)
			String dFileName = URLEncoder.encode(f_oriname, "UTF-8");

			//파일 객체 생성
			File file = new File(path);
			is = new FileInputStream(file);

			//응답 객체(response)의 헤더 설정
			//파일전송용 contentType 설정
			response.setContentType("application/octet-stream");
			response.setHeader("content-Disposition", "attachment; filename=\"" + dFileName + "\"");
			//attachment; filename="가나다라.jpg"

			//응답 객체와 보내는 통로 연결
			os = response.getOutputStream();

			//파일 전송(byte 단위로 전송)
			byte[] buffer = new byte[1024];
			int length;
			while((length = is.read(buffer)) != -1) {
				os.write(buffer, 0, length);
			}
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
			try {
				os.flush();//os에 남아 있을지 모르는 데이터를
				//강제로 전부 보내도록 처리.

				os.close();
				is.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
			}
		}
	}

	@Transactional
	public Map<String, List<ReplyDto>> replyInsert(ReplyDto reply){
		Map<String, List<ReplyDto>> rMap = null;

		try {
			//댓글을 DB에 입력
			bDao.replyInsert(reply);

			//댓글 목록을 다시 검색
			List<ReplyDto> rList = bDao.getReplyList(reply.getB_num());
			rMap = new HashMap<String, List<ReplyDto>>();
			rMap.put("rList", rList);
		}catch (Exception e) {
			//e.printStackTrace();
			rMap = null;
		}

		return rMap;
	}

	// 업체 서비스 등록
	public boolean serviceInsert(String s_contents, String s_price, String s_cnum) {
		log.info("boardInsert()");

		boolean view = false;

		CompanySerciceDto comser = new CompanySerciceDto();

		int s_price_trun =  Integer.parseInt(s_price);

		comser.setS_contents(s_contents);
		comser.setS_price(s_price_trun);
		comser.setS_cnum(s_cnum);

		try {
			bDao.serviceInsert(comser);

			view= true;

		} catch (Exception e) {
			e.printStackTrace();
			view= false;
		}

		return view;
	}


	public ModelAndView updateFrm(String b_num, RedirectAttributes rttr) {
		mv = new ModelAndView();

		CommuntyDto board = bDao.getContents(b_num);

		MemberDto member = (MemberDto)session.getAttribute("mb");

		mv.addObject("board", board);
		List<FileDto> bfList = bDao.getBfList(b_num);
		mv.addObject("bfList", bfList);
		mv.setViewName("updateFrm");

		return mv;
	}

	//게시글 수정하기.
	@Transactional
	public String boardUpdate(MultipartHttpServletRequest multi, RedirectAttributes rttr) {

		String view = null;

		String bnum = multi.getParameter("bnum");
		String title = multi.getParameter("btitle");
		String contents = multi.getParameter("bcontents");
		String id = multi.getParameter("bid");
		String check = multi.getParameter("fileCheck");

		contents = contents.trim();

		log.info("boardUpdate() t: " + title + ", c: " 
				+ contents + ", check: " + check);

		CommuntyDto board = new CommuntyDto();
		board.setB_num(bnum);
		board.setB_title(title);
		board.setB_contents(contents);
		board.setM_id(id);

		try {
			bDao.boardUpdate(board);

			//파일 업로드 메소드 호출
			if(check.equals("1")) {
				fileUp(multi, board.getB_num());
			}

			rttr.addFlashAttribute("msg", "수정 성공");
		} catch (Exception e) {
			//e.printStackTrace();
			rttr.addFlashAttribute("msg", "수정 실패.");
		}

		view = "redirect:contents?b_num=" + bnum;

		return view;
	}

	//수정시 파일 삭제
	@Transactional
	public Map<String, List<FileDto>> fileDelete(String f_sysname, String b_num) {

		Map<String, List<FileDto>> rMap = null;

		log.info("fileDelete() - f_sysName: " + f_sysname + ", b_num: " + b_num);

		//절대경로는 세션으로 구할 수도 있다.
		String path = session.getServletContext()
				.getRealPath("/");

		log.info(path);
		path += "resources/upload/" + f_sysname;

		try {
			bDao.fileDelete(f_sysname);

			File file = new File(path);

			if(file.exists()) {
				if(file.delete()) {
					List<FileDto> bfList = bDao.getBfList(b_num);
					rMap = new HashMap<String, List<FileDto>>();
					rMap.put("fList", bfList);
				}
				else {
					rMap = null;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			rMap = null;
		}

		return rMap;
	}

	//게시글 삭제
	@Transactional
	public String boardDelete(String b_num, RedirectAttributes rttr) {
		log.info("boardDelete() - b_num: " + b_num);

		String view = null;

		try {
			//댓글삭제
			bDao.replyDelete(b_num);
			//파일삭제
			bDao.filesListDelete(b_num);
			//게시글 삭제
			bDao.boardDelete(b_num);

			view = "redirect:list";
			rttr.addFlashAttribute("msg", "삭제되었습니다.");

		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:contents?b_num=" + b_num;
			rttr.addFlashAttribute("msg", "삭제실패하였습니다.");
		}

		return view;	
	}
	// 소비자가 업체 상세 보기
	public ModelAndView getHost(String bh_num) {

		mv = new ModelAndView(bh_num);

		// 파일목록 가져오기
		List<FileDto> cfList = bDao.getCfList(bh_num);

		// 조회수 1 증가
		bDao.viewUpdate2(bh_num);

		// 업체 내용 가져오기
		List<CompanySerciceDto> company = bDao.getService(bh_num);// 업체등록
		// CompanySerciceDto company2 = bDao.getService2(bh_num);//업체서비스

		// 모델 데이터 담기
		mv.addObject("company", company);
		// mv.addObject("company2", company);
		mv.addObject("cfList", cfList);

		// 뷰 이름 지정하기
		mv.setViewName("serviceContents");

		return mv;
	}
	// 게시글 추천 메소드
	public void likeBoard() {

	}

	// 업체 등록
		@Transactional
		public ModelAndView htReg(MultipartHttpServletRequest multi, RedirectAttributes rttr) {

			String view = null;

			mv = new ModelAndView();

			String id = multi.getParameter("h_id");
			String title = multi.getParameter("bh_title");
			String contents = multi.getParameter("bh_contents");
			String check = multi.getParameter("fileCheck");

			contents = contents.trim();

			HostBoardDto host = new HostBoardDto();

			host.setH_id(id);
			host.setBh_title(title);
			host.setBh_contents(contents);

			try {
				bDao.htReg(host);

				//파일 업로드 메소드 호출
				if(check.equals("1")) {
					fileUp2(multi, host.getBh_num());
				}

				view = "redirect:comService";
				rttr.addFlashAttribute("msg", "업체 등록 성공");
			}catch (Exception e) {
				e.printStackTrace();
				view = "redirect:hostregFrm";
				rttr.addFlashAttribute("msg", "업체 등록 실패");
			}

			log.info(host.getBh_num());
			mv.addObject("bh_num", host.getBh_num());

			mv.setViewName(view);

			return mv;
		}
	// 업체 파일 업로드 처리 메소드
	public boolean fileUp2(MultipartHttpServletRequest multi, String bh_num) throws Exception {
		// 저장공간에 대한 절대 경로 구하기
		String path = multi.getSession().getServletContext().getRealPath("/");

		path += "resources/upload/";
		log.info(path);

		File dir = new File(path);

		if (dir.isDirectory() == false) {
			dir.mkdir();// 폴더가 없을 경우 폴더 생성.
		}
		// 실제 파일명과 저장 파일명을 함께 관리
		Map<String, String> fmap = new HashMap<String, String>();

		fmap.put("bh_num", String.valueOf(bh_num));

		// 파일 전송시 기본 값을 파일다중 선택임.
		// 멀티파트 요청 객체에서 꺼내올 때는 List를 사용.
		List<MultipartFile> fList = multi.getFiles("files");

		for (int i = 0; i < fList.size(); i++) {
			MultipartFile mf = fList.get(i);
			String on = mf.getOriginalFilename();
			fmap.put("f_oriName", on);

			// 변경된 파일 이름 저장
			String sn = System.currentTimeMillis() + "." // 확장자 구분 점
					+ on.substring(on.lastIndexOf(".") + 1);
			fmap.put("f_sysName", sn);

			// 해당 폴더에 파일 저장하기
			mf.transferTo(new File(path + sn));

			bDao.fileInsert2(fmap);
		}
		return true;
	}

	//업체 목록가져오는 메소드
	public ModelAndView getCompList(Integer pageNum) {

		mv = new ModelAndView();

		int num = (pageNum == null) ? 1 : pageNum;

		List<HostBoardDto> hList = bDao.getHlist(num);

		mv.addObject("hList", hList);

		// 페이징 처리
		mv.addObject("paging", getCompaging(num));

		// 세션에 페이지 번호 저장
		session.setAttribute("pageNum", num);

		mv.setViewName("petsgoSerch");

		return mv;
	}
	private String getCompaging(int num) {
		// 전체 글 개수 구하기(from DB)
		int maxNum = bDao.getCompCnt();

		// 설정값(페이지 당 글 개수, 그룹 당 페이지 개수, 게시판 이름)
		int listCnt = 10;
		int pageCnt = 2;
		String listName = "petsgoSerch";

		Paging paging = new Paging(maxNum, num, listCnt, pageCnt, listName);

		String pagingHtml = paging.makePaging();

		return pagingHtml;

	}
	// 업체가 업체 상세 보기
		public ModelAndView getHost2(String bh_num) {

			mv = new ModelAndView();

			// 파일목록 가져오기
			List<FileDto> cfList = bDao.getCfList(bh_num);

			// 조회수 1 증가
			bDao.viewUpdate2(bh_num);

			// 업체 내용 가져오기
			List<CompanySerciceDto> company = bDao.getService(bh_num);// 업체등록
			// CompanySerciceDto company2 = bDao.getService2(bh_num);//업체서비스

			// 모델 데이터 담기
			mv.addObject("company", company);
			// mv.addObject("company2", company);
			mv.addObject("cfList", cfList);

			// 뷰 이름 지정하기
			mv.setViewName("serviceContents");

			return mv;
		}
	// 조회수순 게시글 목록 가져오는 메소드
	public ModelAndView getBoardview(Integer pageNum) {

		mv = new ModelAndView();

		int num = (pageNum == null) ? 1 : pageNum;

		List<CommuntyDto> bList = bDao.getBlist(num);

		mv.addObject("bList", bList);

		// 페이징 처리
		mv.addObject("paging", getCompaging3(num));

		// 세션에 페이지 번호 저장
		session.setAttribute("pageNum", num);

		mv.setViewName("viewBoard");

		return mv;
	}
	private String getCompaging2(int num) {
		// 전체 글 개수 구하기(from DB)
		int maxNum = bDao.getCompCnt();

		// 설정값(페이지 당 글 개수, 그룹 당 페이지 개수, 게시판 이름)
		int listCnt = 10;
		int pageCnt = 2;
		String listName = "viewSearch";

		Paging paging = new Paging(maxNum, num, listCnt, pageCnt, listName);

		String pagingHtml = paging.makePaging();

		return pagingHtml;

	}

	private String getCompaging3(int num) {
		// 전체 글 개수 구하기(from DB)
		int maxNum = bDao.getBoardCnt();

		// 설정값(페이지 당 글 개수, 그룹 당 페이지 개수, 게시판 이름)
		int listCnt = 10;
		int pageCnt = 2;
		String listName = "viewBoard";

		Paging paging = new Paging(maxNum, num, listCnt, pageCnt, listName);

		String pagingHtml = paging.makePaging();

		return pagingHtml;

	}
	// 조회수순 업체 목록 가져오는 메소드
	public ModelAndView getManyview(Integer pageNum) {

		mv = new ModelAndView();

		int num = (pageNum == null) ? 1 : pageNum;

		List<HostBoardDto> rList = bDao.getRlist(num);

		mv.addObject("rList", rList);

		// 페이징 처리
		mv.addObject("paging", getCompaging2(num));

		// 세션에 페이지 번호 저장
		session.setAttribute("pageNum", num);

		mv.setViewName("viewSearch");

		return mv;
	}

	// 조회수순 게시글 목록 가져오는 메소드
	public ModelAndView getBoardhead(Integer pageNum) {

		mv = new ModelAndView();

		int num = (pageNum == null) ? 1 : pageNum;

		List<CommuntyDto> bList = bDao.getBlist(num);

		mv.addObject("bList", bList);

		// 페이징 처리
		mv.addObject("paging", getCompaging3(num));

		// 세션에 페이지 번호 저장
		session.setAttribute("pageNum", num);

		mv.setViewName("headBoard");

		return mv;
	}
	private String getPaging4(int num) {
		// 전체 글 개수 구하기(from DB)
		int maxNum = bDao.getBoardCnt();

		// 설정값(페이지 당 글 개수, 그룹 당 페이지 개수, 게시판 이름)
		int listCnt = 10;
		int pageCnt = 2;
		String listName = "headBoard";

		Paging paging = new Paging(maxNum, num, listCnt, pageCnt, listName);

		String pagingHtml = paging.makePaging2();

		return pagingHtml;

	}
	// 말머리별 게시글 목록 가져오는 메소드
	public ModelAndView getHeadList(Integer head, Integer pageNum) {

		mv = new ModelAndView();

		int num = (pageNum == null) ? 1 : pageNum;

		Map<String, Integer> hmap = new HashMap<String, Integer>();

		hmap.put("head", head);
		hmap.put("pageNum", num);

		List<CommuntyDto> cList = bDao.getDlist(hmap);

		// DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("cList", cList);

		// 페이징 처리
		mv.addObject("paging", getPaging4(num));

		// 세션에 페이지 번호 저장
		session.setAttribute("pageNum", num);

		mv.setViewName("headBoard");

		return mv;

	}
	//리뷰 목록 가져오는 메소드
		public ModelAndView getReviewList(Integer pageNum) {

			mv = new ModelAndView();

			int num = (pageNum == null) ? 1 : pageNum;

			List<ReviewDto> vList = bDao.getvList(num);

			// DB에서 조회한 데이터 목록을 모델에 추가
			mv.addObject("vList", vList);

			// 페이징 처리
			mv.addObject("paging", getPaging2(num));

			// 세션에 페이지 번호 저장
			session.setAttribute("pageNum", num);

			mv.setViewName("reviewList");

			return mv;

		}
		
		// 리뷰 등록 서비스 메소드
				@Transactional
				public String reviewInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
					log.info("reviewInsert()");

					String view = null;

					String id = multi.getParameter("rv_name");
					String h_id = multi.getParameter("h_id");
					String s_num = multi.getParameter("s_num");
					String contents = multi.getParameter("rv_contents");
					String check = multi.getParameter("fileCheck");

					contents = contents.trim();
					
					System.out.println("닉네임" + id);
					System.out.println("업체아이디" + h_id);
					System.out.println("서비스 번호" + s_num);
					System.out.println("내용" + contents);
					
					ReviewDto review = new ReviewDto();

					review.setRv_name(id);
					review.setS_num(s_num);
					review.setRv_contents(contents);
					review.setH_id(h_id);

					try {
						bDao.reviewInsert(review);

						//파일 업로드 메소드 호출
						if(check.equals("1")) {
							fileUp3(multi, review.getRv_num());
						}

						view = "redirect:reviewList";
						rttr.addFlashAttribute("msg", "글 등록 성공");
					} catch (Exception e) {
						e.printStackTrace();
						view = "redirect:writeReview";
						rttr.addFlashAttribute("msg", "글 등록 실패");
					}

					return view;
				}
			
			// 리뷰 파일 업로드 처리 메소드
			public boolean fileUp3(MultipartHttpServletRequest multi, String rv_num) throws Exception {
				// 저장공간에 대한 절대 경로 구하기
				String path = multi.getSession().getServletContext().getRealPath("/");

				path += "resources/upload/";
				log.info(path);

				File dir = new File(path);

				if (dir.isDirectory() == false) {
					dir.mkdir();// 폴더가 없을 경우 폴더 생성.
				}

				// 실제 파일명과 저장 파일명을 함께 관리
				Map<String, String> fmap = new HashMap<String, String>();

				fmap.put("rv_num", String.valueOf(rv_num));

				// 파일 전송시 기본 값을 파일다중 선택임.
				// 멀티파트 요청 객체에서 꺼내올 때는 List를 사용.
				List<MultipartFile> fList = multi.getFiles("files");

				for (int i = 0; i < fList.size(); i++) {
					MultipartFile mf = fList.get(i);
					String on = mf.getOriginalFilename();
					fmap.put("f_oriname", on);

					// 변경된 파일 이름 저장
					String sn = System.currentTimeMillis() + "." // 확장자 구분 점
							+ on.substring(on.lastIndexOf(".") + 1);
					fmap.put("f_sysname", sn);

					// 해당 폴더에 파일 저장하기
					mf.transferTo(new File(path + sn));

					bDao.fileInsert3(fmap);
				}

				return true;
			}
			
			private String getPaging2(int num) {
				// 전체 글 개수 구하기(from DB)
				int maxNum = bDao.getBoardCnt();

				// 설정값(페이지 당 글 개수, 그룹 당 페이지 개수, 게시판 이름)
				int listCnt = 10;
				int pageCnt = 2;
				String listName = "reviewList";

				Paging paging = new Paging(maxNum, num, listCnt, pageCnt, listName);

				String pagingHtml = paging.makePaging();

				return pagingHtml;

			}
			
			// 리뷰 보기
			public ModelAndView rvcontents(String rv_num) {
				mv = new ModelAndView();

				// 글 내용 가져오기
				ReviewDto review = bDao.getrvContents(rv_num);

				//파일목록 가져오기
				List<FileDto> rfList = bDao.getRfList(rv_num);

				// 댓글목록 가져오기
				List<ReplyDto> rList = bDao.getrvReplyList(rv_num);

				// 모델 데이터 담기
				mv.addObject("review", review);
				mv.addObject("rfList", rfList);
				mv.addObject("rList", rList);

				// 뷰 이름 지정하기
				mv.setViewName("reviewContents");

				return mv;
			}
			
			@Transactional
			public Map<String, List<ReplyDto>> replyInsert2(ReplyDto reply){
				Map<String, List<ReplyDto>> rMap = null;

				try {
					//댓글을 DB에 입력
					bDao.replyInsert2(reply);

					//댓글 목록을 다시 검색
					List<ReplyDto> rList = bDao.getReplyList2(reply.getRv_num());
					rMap = new HashMap<String, List<ReplyDto>>();
					rMap.put("rList", rList);
				}catch (Exception e) {
					//e.printStackTrace();
					rMap = null;
				}

				return rMap;
			}
			
			public ModelAndView updateFrm2(String rv_num, RedirectAttributes rttr) {
				mv = new ModelAndView();

				ReviewDto review = bDao.getrvContents(rv_num);

				MemberDto member = (MemberDto)session.getAttribute("mb");

				mv.addObject("review", review);
				List<FileDto> rfList = bDao.getRfList(rv_num);
				mv.addObject("rfList", rfList);
				mv.setViewName("updateFrm2");

				return mv;
			}
			
			//리뷰 수정하기.
			@Transactional
			public String reviewUpdate(MultipartHttpServletRequest multi, RedirectAttributes rttr) {

				String view = null;

				String rv_num = multi.getParameter("rv_num");
				String contents = multi.getParameter("rv_contents");
				String id = multi.getParameter("rv_name");
				String check = multi.getParameter("fileCheck");
				String h_id = multi.getParameter("h_id");
				String s_num = multi.getParameter("s_num");
				
				contents = contents.trim();

				log.info("reviewUpdate() t: "  + ", c: " 
						+ contents + ", check: " + check);

				ReviewDto review = new ReviewDto();
				
				review.setRv_num(rv_num);
				review.setRv_contents(contents);
				review.setRv_name(id);
				review.setH_id(h_id);
				review.setS_num(s_num);
				
				
				try {
					bDao.reviewUpdate(review);

					//파일 업로드 메소드 호출
					if(check.equals("1")) {
						fileUp3(multi, review.getRv_num());
					}

					rttr.addFlashAttribute("msg", "수정 성공");
				} catch (Exception e) {
					//e.printStackTrace();
					rttr.addFlashAttribute("msg", "수정 실패.");
				}

				view = "redirect:rvcontents?rv_num=" + rv_num;

				return view;
			}
			
			//리뷰 삭제
			@Transactional
			public String boardDelete2(String rv_num, RedirectAttributes rttr) {
				log.info("boardDelete() - rv_num: " + rv_num);

				String view = null;

				try {
					//댓글삭제
					bDao.replyDelete2(rv_num);
					//파일삭제
					bDao.filesListDelete2(rv_num);
					//리뷰 삭제
					bDao.reviewDelete(rv_num);

					view = "redirect:reviewList";
					rttr.addFlashAttribute("msg", "삭제되었습니다.");

				} catch (Exception e) {
					e.printStackTrace();
					view = "redirect:rvcontents?rv_num=" + rv_num;
					rttr.addFlashAttribute("msg", "삭제실패하였습니다.");
				}

				return view;	
			}
			
			//리뷰 수정시 파일 삭제
			@Transactional
			public Map<String, List<FileDto>> fileDelete3(String f_sysname, String rv_num) {

				Map<String, List<FileDto>> rMap = null;

				log.info("fileDelete() - f_sysName: " + f_sysname + ", rv_num: " + rv_num);

				//절대경로는 세션으로 구할 수도 있다.
				String path = session.getServletContext().getRealPath("/");

				log.info(path);
				path += "resources/upload/" + f_sysname;

				try {
					bDao.fileDelete2(f_sysname);

					File file = new File(path);

					if(file.exists()) {
						if(file.delete()) {
							List<FileDto> bfList = bDao.getRfList(rv_num);
							rMap = new HashMap<String, List<FileDto>>();
							rMap.put("fList", bfList);
						}
						else {
							rMap = null;
						}
					}

				} catch (Exception e) {
					e.printStackTrace();
					rMap = null;
				}

				return rMap;
			}



}//class fin

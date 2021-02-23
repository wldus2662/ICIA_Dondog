package com.dondog.dbapp.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.HostBoardDao;
import com.dondog.dbapp.dao.HostMemberDao;
import com.dondog.dbapp.dao.MemberDao;
import com.dondog.dbapp.dto.BlackListDto;
import com.dondog.dbapp.dto.BtRegformDto;
import com.dondog.dbapp.dto.CommuntyDto;
import com.dondog.dbapp.dto.CompanySerciceDto;
import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HostBoardDto;
import com.dondog.dbapp.dto.HostMemberDto;
import com.dondog.dbapp.dto.HpRegformDto;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.UpimgFileDto;
import com.dondog.dbapp.util.Paging;

import lombok.extern.java.Log;

@Service
@Log
public class HostBoardService {

	//DAO 객체
	@Autowired
	private HostMemberDao hostDao;
	@Autowired
	private HostBoardDao bDao;
	@Autowired
	private MemberDao mDao;

	private ModelAndView mv;

	//세션객체
	@Autowired
	private HttpSession session;
	
	@Transactional
	public String hBoardInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		log.info("hBoardInsert()");
		String view = null;

		String h_id = multi.getParameter("h_id");
		String h_busin = multi.getParameter("h_busin");
		String bh_title = multi.getParameter("bh_title");
		String bh_contents = multi.getParameter("bh_contents");
		String check = multi.getParameter("fileCheck");
		String check2 = multi.getParameter("fileCheck2");
		String check3 = multi.getParameter("fileCheck3");
		
		String normal = multi.getParameter("hc_normal");
		String alltime = multi.getParameter("hc_alltime");
		String parking = multi.getParameter("hc_parking");
		String beauty = multi.getParameter("hc_beauty");
		String hotel = multi.getParameter("hc_hotel");
		String supplies = multi.getParameter("hc_supplies");
		String second = multi.getParameter("hc_second");
		
		int hc_normal = 0;
		int hc_alltime = 0;
		int hc_parking = 0;
		int hc_beauty = 0;
		int hc_hotel = 0;
		int hc_supplies = 0;
		int hc_second = 0;

		bh_contents = bh_contents.trim();
		
		if(normal != null) {hc_normal = 1;}
		if(alltime != null) {hc_alltime = 1;}
		if(parking != null) {hc_parking = 1;}
		if(beauty != null) {hc_beauty = 1;}
		if(hotel != null) {hc_hotel = 1;}
		if(supplies != null) {hc_supplies = 1;}
		if(second != null) {hc_second = 1;}
		
		HostBoardDto hBoard = new HostBoardDto();
		hBoard.setH_id(h_id);
		hBoard.setBh_title(bh_title);
		hBoard.setBh_contents(bh_contents);
		
		HpRegformDto hrForm = new HpRegformDto();
		hrForm.setHc_normal(hc_normal);
		hrForm.setHc_alltime(hc_alltime);
		hrForm.setHc_parking(hc_parking);
		hrForm.setHc_beauty(hc_beauty);
		hrForm.setHc_hotel(hc_hotel);
		hrForm.setHc_supplies(hc_supplies);
		hrForm.setHc_second(hc_second);	
		try {
			bDao.hBoardInsert(hBoard);
			hpRegform(multi, hBoard.getBh_num());
			if(check.equals("1")) {hfileup(multi, hBoard.getBh_num());}
			if(check2.equals("1")) {hfileup2(multi, hBoard.getBh_num());}
			if(check3.equals("1")) {hfileup3(multi, hBoard.getBh_num());}
			view = "redirect:ingHpReg";
			rttr.addFlashAttribute("msg", "글 등록 성공");
			} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:writeHostFrm";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}

		return view;
	}//hBoardInsert end
	
	public boolean hpRegform(
			MultipartHttpServletRequest multi,
			String bh_num) throws Exception {
		log.info("hpRegform()");
		String normal = multi.getParameter("hc_normal");
		String alltime = multi.getParameter("hc_alltime");
		String parking = multi.getParameter("hc_parking");
		String beauty = multi.getParameter("hc_beauty");
		String hotel = multi.getParameter("hc_hotel");
		String supplies = multi.getParameter("hc_supplies");
		String second = multi.getParameter("hc_second");
		
		int hc_normal = 0;
		int hc_alltime = 0;
		int hc_parking = 0;
		int hc_beauty = 0;
		int hc_hotel = 0;
		int hc_supplies = 0;
		int hc_second = 0;
		
		if(normal != null) {hc_normal = 1;}
		if(alltime != null) {hc_alltime = 1;}
		if(parking != null) {hc_parking = 1;}
		if(beauty != null) {hc_beauty = 1;}
		if(hotel != null) {hc_hotel = 1;}
		if(supplies != null) {hc_supplies = 1;}
		if(second != null) {hc_second = 1;}
		
		HpRegformDto hrForm = new HpRegformDto();
		hrForm.setHc_normal(hc_normal);
		hrForm.setHc_alltime(hc_alltime);
		hrForm.setHc_parking(hc_parking);
		hrForm.setHc_beauty(hc_beauty);
		hrForm.setHc_hotel(hc_hotel);
		hrForm.setHc_supplies(hc_supplies);
		hrForm.setHc_second(hc_second);
		hrForm.setBh_num(bh_num);
		
		bDao.hpRegformInsert(hrForm);
		
		return true;
	}

	//상단이미지
	public boolean hfileup(MultipartHttpServletRequest multi,
			String bh_num) throws Exception {		
		//저장공간에 대한 절대 경로 구하기
		String path = multi.getSession().getServletContext()
				.getRealPath("/");
		path += "resources/upload/";
		log.info(path);
		File dir = new File(path);

		if(dir.isDirectory() == false) {
			dir.mkdir();//폴더가 없을 경우 폴더 생성.
			}
		Map<String, String> fmap = 
				new HashMap<String, String>();
		fmap.put("bh_num", String.valueOf(bh_num));
		List<MultipartFile> fList = multi.getFiles("files");

		for(int i = 0; i < fList.size(); i++) {
			MultipartFile mf = fList.get(i);
			String on = mf.getOriginalFilename();
			fmap.put("uf_oriname", on);

			//변경된 파일 이름 저장(이미지슬라이더)
			String sn =System.currentTimeMillis()
					+ "." //확장자 구분 점
					+ on.substring(on.lastIndexOf(".") + 1);
			fmap.put("uf_sysname", sn);

			//해당 폴더에 파일 저장하기
			mf.transferTo(new File(path + sn));
			bDao.hfileInsert(fmap);
		}
		return true;
	}
	//본문이미지
	public boolean hfileup2(MultipartHttpServletRequest multi,
			String bh_num) throws Exception {
		//저장공간에 대한 절대 경로 구하기
		String path = multi.getSession().getServletContext()
				.getRealPath("/");
		path += "resources/upload/";
		log.info(path);
		File dir = new File(path);
		if(dir.isDirectory() == false) {
			dir.mkdir();}
		Map<String, String> fmap2 = new HashMap<String, String>();
		fmap2.put("bh_num", String.valueOf(bh_num));
		//본문내용
		List<MultipartFile> fList2 = multi.getFiles("files2");

		for(int i = 0; i < fList2.size(); i++) {
			MultipartFile mf = fList2.get(i);
			String on2 = mf.getOriginalFilename();
			fmap2.put("f_oriname", on2);

			//변경된 파일 이름 저장(본문내용)
			String sn2 =System.currentTimeMillis()
					+ "." //확장자 구분 점
					+ on2.substring(on2.lastIndexOf(".") + 1);
			fmap2.put("f_sysname", sn2);

			//해당 폴더에 파일 저장하기
			mf.transferTo(new File(path + sn2));
			bDao.hfileInsert2(fmap2);
		}
		return true;
	}
	//기타파일
	public boolean hfileup3(MultipartHttpServletRequest multi,String bh_num) throws Exception {
		//저장공간에 대한 절대 경로 구하기
		String path = multi.getSession().getServletContext()
				.getRealPath("/");

		path += "resources/upload/";
		log.info(path);

		File dir = new File(path);

		if(dir.isDirectory() == false) {
			dir.mkdir();//폴더가 없을 경우 폴더 생성.
		}

		Map<String, String> fmap = new HashMap<String, String>();
		fmap.put("bh_num", String.valueOf(bh_num));

		//기타 파일
		List<MultipartFile> fList3 = multi.getFiles("files2");

		for(int i = 0; i < fList3.size(); i++) {
			MultipartFile mf = fList3.get(i);
			String on3 = mf.getOriginalFilename();
			fmap.put("f_oriname", on3);

			//변경된 파일 이름 저장(본문내용)
			String sn3 = "HBE" 
					+System.currentTimeMillis()
					+ "." //확장자 구분 점
					+ on3.substring(on3.lastIndexOf(".") + 1);
			fmap.put("f_sysname", sn3);

			//해당 폴더에 파일 저장하기
			mf.transferTo(new File(path + sn3));

			bDao.hfileInsert(fmap);
		}
		return true;
	}
	public ModelAndView getHContents(String bh_num) {
	      mv = new ModelAndView();
	      HostBoardDto hBoard = bDao.getHContnents(bh_num);
	      //파일 가져오기
	      List<FileDto> HfList = bDao.getHfList(bh_num);
	      List<UpimgFileDto> UfList = bDao.getUfList(bh_num);//2/2
	      mv.addObject("hBoard",hBoard); 
	      mv.addObject("HfList", HfList);
	      mv.addObject("UfList", UfList);//2/2
	      
	      mv.setViewName("hostMain");      
	      return mv;
	   }

	public ModelAndView gethBoardList(Integer pageNum) {
		log.info("gethBoardList() - pageNum: " + pageNum);
		mv = new ModelAndView();
		int num = (pageNum == null) ? 1 : pageNum;
		
		List<HostBoardDto> hBList = bDao.gethBList(num);
		mv.addObject("hBList", hBList);
		
		mv.addObject("paging", gethPaging(num));
		
		session.setAttribute("pageNum", num);
		
		mv.setViewName("ingHpReg");
		
		return mv;
	}
	private String gethPaging(int num) {
		int maxNum = bDao.getHBoardCnt();
		int listCnt = 10;
		int pageCnt = 2;
		String listName = "hblist";
		Paging paging = new Paging(maxNum, num, listCnt,
				pageCnt, listName);
		String pagingHtml = paging.makePaging();
		return pagingHtml;
	}
	public ModelAndView gethpBoardList(Integer pageNum) {
		log.info("gethBoardList() - pageNum: " + pageNum);
		mv = new ModelAndView();
		int num = (pageNum == null) ? 1 : pageNum;
		
		List<HostBoardDto> hBList = bDao.gethBList(num);
		mv.addObject("hBList", hBList);
		
		mv.addObject("paging", gethPaging(num));
		
		session.setAttribute("pageNum", num);
		
		mv.setViewName("Hospital_List");
		
		return mv;
	}

	public ModelAndView HBupdateFrm(String bh_num, RedirectAttributes rttr) {
		mv = new ModelAndView();
		HostBoardDto hBoard = bDao.getHContnents(bh_num);
		
		HostMemberDto host = (HostMemberDto)session.getAttribute("mb");
		
		mv.addObject("hBoard", hBoard);
		List<UpimgFileDto> ufList = bDao.getUfList(bh_num);
		mv.addObject("ufList", ufList);
		List<FileDto> hfList = bDao.getHfList(bh_num);
		mv.addObject("hfList", hfList);
		mv.setViewName("HBupdateFrm");
				
		return mv;
	}

	public String HBupdate(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		String view = null;
		
		String bh_num = multi.getParameter("bh_num");
		String h_id = multi.getParameter("h_id");
		//String h_busin = multi.getParameter("h_busin");
		String bh_title = multi.getParameter("bh_title");
		String bh_contents = multi.getParameter("bh_contents");
		String check = multi.getParameter("fileCheck");
		String check2 = multi.getParameter("fileCheck2");
		bh_contents = bh_contents.trim();
		
		log.info("HBupdate() t: " + bh_title + ", c: " + bh_contents);
		HostBoardDto hBoard = new HostBoardDto();
		hBoard.setBh_num(bh_num);
		hBoard.setH_id(h_id);
		hBoard.setBh_title(bh_title);
		hBoard.setBh_contents(bh_contents);
		
		try {
			bDao.HBupdate(hBoard);			
			//파일 업로드 메소드 호출
			if(check.equals("1")) {
				hfileup(multi, hBoard.getBh_num());
			}
			if(check2.equals("1")) {
				hfileup2(multi, hBoard.getBh_num());
			}
			
			rttr.addFlashAttribute("msg", "수정 성공");
		} catch (Exception e) {
			// TODO: handle exception
			rttr.addFlashAttribute("msg", "수정 실패");
		}
		
		view = "redirect:hostMain?bnum=" + bh_num;
		
		return view;
	}

	public String HBdelete(String bh_num, RedirectAttributes rttr) {
		log.info("HBdelete()" + bh_num);	
		String view = null;
		try {
			//댓글 삭제
			//bDao.delReply(bh_num);
			//파일 삭제
			bDao.hFiledelete(bh_num);
			//게시글 삭제
			bDao.HBdelete(bh_num);
			view = "redirect:Hospital_List";
			rttr.addFlashAttribute("msg", "삭제 성공");
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:hostMain?bnum=" + bh_num;
			rttr.addFlashAttribute("msg", "삭제 실패");
		}
		return view;
	}

	//업체등록 현황목록 가져오는 메소드
			public ModelAndView gethostList() {
				log.info("gethostList");
				
				mv = new ModelAndView();
				
				HostMemberDto host = (HostMemberDto)session.getAttribute("mb");
				log.info(host.getH_id());
				
				//업체 등록리스트
				List<HostBoardDto> hList = bDao.gethostInfo(host.getH_id());
				mv.addObject("hList", hList);
				
				mv.setViewName("hostMypage");
				
				return mv;
			}
			
			//업체등록
			@Transactional
			public String hostregInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
				log.info("hostregInsert()" + multi);
				String view = null;

				String title = multi.getParameter("bh_title");
				String id = multi.getParameter("h_id");
				String bhcontents = multi.getParameter("bh_contents");
				String check = multi.getParameter("fileCheck");
				
				
				//textarea는 입력한 문자열 앞뒤로 공백이 발생.
				//문자열 앞뒤 공백 제거. trim()
				bhcontents = bhcontents.trim();
				
				HostBoardDto hBoard = new HostBoardDto();
				hBoard.setH_id(id);
				hBoard.setBh_title(title);
				hBoard.setBh_contents(bhcontents);
				

				try {
					bDao.hostBoardInsert(hBoard);

					//체크박스 등록하기
					btRegform(multi, hBoard.getBh_num());
					//파일 업로드 가져오기
					if(check.equals("1")) {
						btfileUp(multi, hBoard.getBh_num());
					}

					view = "redirect:hostMypage";
					rttr.addFlashAttribute("msg", "등록 성공");
				} catch (Exception e) {
					// TODO: handle exception
					view = "redirect:hostregForm";
					rttr.addFlashAttribute("msg", "등록 실패");
				}

				return view;
			}
			
			//체크박스 양식 가져오기
			public boolean btRegform(MultipartHttpServletRequest multi, String bh_num) throws Exception {
				log.info("btRegform(): " + bh_num);
				
				String visit = multi.getParameter("bt_visit");
				String pickup = multi.getParameter("bt_pickup");
				String parking = multi.getParameter("bt_parking");
				String supplies = multi.getParameter("bt_supplies");
				
				int bt_visit = 0;
				int bt_pickup = 0;
				int bt_parking = 0;
				int bt_supplies = 0;
				
				if(visit != null) {bt_visit = 1;}
				if(pickup != null) {bt_pickup = 1;}
				if(parking != null) {bt_parking = 1;}
				if(supplies != null) {bt_supplies = 1;}
				
				BtRegformDto btForm = new BtRegformDto();
				btForm.setBt_visit(bt_visit);
				btForm.setBt_pickup(bt_pickup);
				btForm.setBt_parking(bt_parking);
				btForm.setBt_supplies(bt_supplies);
				btForm.setBh_num(bh_num);
				
				
				bDao.btRegformInsert(btForm);
				
				return true;
				
			}
			
			//업체 등록시 파일 압로드 메소드
			public boolean btfileUp(MultipartHttpServletRequest multi, String bh_num) throws Exception {
				// 저장공간에 대한 절대 경로 구하기
				String path = multi.getSession().getServletContext().getRealPath("/");
				
				path += "resources/upload/";
				log.info(path);
				
				File dir = new File(path);
				
				if (dir.isDirectory() == false) {
					dir.mkdir(); // 폴더가 없을 경우 폴더 생성.
				}
				
				// 실제 파일명과 저장 파일명을 함께 관리
				Map<String, String> hbfMap = new HashMap<String, String>();
				
				hbfMap.put("bh_num", String.valueOf(bh_num));
				
				//파일 전송시 기본값을 파일다중 선택임
				// 멀티파트 요청 객체에서 꺼내올 때는 List를 사용.
				List<MultipartFile> hbfList = multi.getFiles("files");
				
				for(int i = 0; i < hbfList.size(); i++) {
					MultipartFile mf = hbfList.get(i);
					String on = mf.getOriginalFilename();
					hbfMap.put("f_oriname", on);
					
					//변경된 파일 이름 저장
					String sn = System.currentTimeMillis() + "." // 확장자 구분 점
							+ on.substring(on.lastIndexOf(".") + 1);
					hbfMap.put("f_sysname", sn);
					
					// 해당폴더에 파일 저장하기
					mf.transferTo(new File(path + sn));
					
					bDao.hbfileInsert(hbfMap);
				}
				
				return true;
				
			}
			
			//업체 서비스 등록
			public boolean htserviceInsert(String s_contents, String s_price, String s_cnum) {
				log.info("boardInsert()");

				boolean view = false;

				CompanySerciceDto comservice = new CompanySerciceDto();

				int s_price_trun =  Integer.parseInt(s_price);

				comservice.setS_contents(s_contents);
				comservice.setS_price(s_price_trun);
				comservice.setS_cnum(s_cnum);

				try {
					bDao.serviceInsert(comservice);

					view= true;

				} catch (Exception e) {
					e.printStackTrace();
					view= false;
				}

				return view;
			}
			
			//업체등록 상세내역 가져오는 메소드
				public ModelAndView getRegContents(String bh_num) {
					mv = new ModelAndView();
					
					log.info("getRegContents() - bh_num: " + bh_num);
					
					//글 내용 가져오기
					HostBoardDto hBoard = bDao.gethostContents(bh_num);
					
					//파일목록 가져오기
					List<FileDto> HfList = bDao.gethbfList(bh_num);
					
					//체크박스 가져오기
					//List<BtRegformDto> btFormList = bDao.getBtregForm(bh_num);
					
					//DB를 모델데이터에 담기
					mv.addObject("hBoard", hBoard);
					mv.addObject("HfList", HfList);
					//mv.addObject("btFormList", btFormList);
					
					//뷰 이름 지정하기
					mv.setViewName("hostContents");
					
					return mv;
					
				}
				
				//등록양식 게시글 삭제
				@Transactional
				public String regDelete(String bh_num, RedirectAttributes rttr) {
					log.info("regDelete() - bh_num" + bh_num);
					
					String view = null;
					
					try {
						//체크박스 삭제
						//bDao.btregDelete(bh_num);
						//파일삭제
						bDao.hFiledelete(bh_num);
						//게시글삭제 
						bDao.regBoardDelete(bh_num);
						
						view = "redirect:hostMypage";
						rttr.addFlashAttribute("msg", "등록취소 완료");
					} catch (Exception e) {
						view = "redirect:htcontents?bh_num=" + bh_num;
						rttr.addFlashAttribute("msg", "등록취소 실패");
					}
					
					return view;
				}

				//등록된 업체들 전체 게시글 리스트 가져오기(미용검색창에서)
				public ModelAndView getbeautyList() {
					
					mv = new ModelAndView();
					
					List<HostBoardDto> bList = bDao.beautyList();
					
					// DB에서 조회한 데이터 목록을 모델에 추가
					mv.addObject("bList", bList);
					
					mv.setViewName("beautySearch");
					
					return mv;
				}
				
				//업체등록 상세내역 가져오는 메소드(미용검색창에서)
				public ModelAndView getRegContents2(String bh_num) {
					mv = new ModelAndView();
					
					log.info("getRegContents2() - bh_num: " + bh_num);
					
					//글 내용 가져오기
					HostBoardDto hBoard = bDao.gethostContents(bh_num);
					
					//파일목록 가져오기
					List<FileDto> HfList = bDao.gethbfList(bh_num);
					
					//체크박스 가져오기
					//List<BtRegformDto> btFormList = bDao.getBtregForm(bh_num);
					
					//DB를 모델데이터에 담기
					mv.addObject("hBoard", hBoard);
					mv.addObject("HfList", HfList);
					//mv.addObject("btFormList", btFormList);
					
					//뷰 이름 지정하기
					mv.setViewName("hostContents_bt");
					
					return mv;
					
				}
}//end

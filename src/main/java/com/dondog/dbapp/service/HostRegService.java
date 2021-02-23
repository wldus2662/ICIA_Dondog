package com.dondog.dbapp.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.HostBoardDao;
import com.dondog.dbapp.dao.HostRegDao;
import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HospitalDto;
import com.dondog.dbapp.dto.HostBoardDto;


import com.dondog.dbapp.dto.HostMemberDto;
import com.dondog.dbapp.dto.PetDto;
import com.dondog.dbapp.dto.UpimgFileDto;

import lombok.extern.java.Log;

@Service
@Log
public class HostRegService {
	//DAO 객체
	@Autowired
	private HostRegDao hDao;
	@Autowired
	private HostBoardDao bDao;
	//세션 객체
	@Autowired
	private HttpSession session;

	//ModelAndView
	private ModelAndView mv;

	//등록한 업체 정보 리스트 가져오기 
	public ModelAndView gethList() {

		log.info("gethList");

		mv = new ModelAndView();
		
		//로그인한 아이디의 정보 꺼내오기
		HostMemberDto host = (HostMemberDto)session.getAttribute("mb");
		log.info("업체 아이디 : "+host.getH_id());
		
		List<HostBoardDto> hList = hDao.gethInfo(host.getH_id());
		mv.addObject("hList", hList);
		mv.setViewName("hostRegNow");

		return mv;
	}
	
	//내 업체 정보 보기 
	public ModelAndView hContents() {
		log.info("hContents()");
		mv = new ModelAndView();

		HostMemberDto host = (HostMemberDto)session.getAttribute("mb");
		String h_id = host.getH_id();
		
		//업체 정보 가져오기
		HostBoardDto h = hDao.hContents(h_id);
		//파일목록 가져오기
		List<FileDto> bhfList = hDao.getbhfList(h.getBh_num());
		List<UpimgFileDto> UfList = bDao.getUfList(h.getBh_num());
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("h", h);	
		mv.addObject("fList", bhfList);
		mv.addObject("UfList", UfList);
		
		mv.setViewName("hostInfo");

		return mv;
	}
	//수정할 내용 가져오기 
	public ModelAndView hostInfo_upFrm(String h_id, 
			RedirectAttributes rttr) {
		mv = new ModelAndView();
		
		HostBoardDto h = hDao.hContents(h_id);
		
		String bh_num = h.getBh_num();
		log.info("hostInfo_upFrm bh_num : "+bh_num);
		mv.addObject("h", h);
		List<FileDto> fList =hDao.getbhfList(bh_num);
		mv.addObject("fList", fList);
		mv.setViewName("hostInfo_upFrm");
				
		return mv;
	}
	//내 업체 정보 수정 처리 
	@Transactional
	public String hostInfoUpdate(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		log.info("hServ.hostInfoUpdate()");
		String view = null;
		
		String title = multi.getParameter("bh_title");
		String contents = multi.getParameter("bh_contents");
		String bhnum = multi.getParameter("bh_num");
		
		String check = multi.getParameter("fileCheck");
		
		String id = multi.getParameter("h_id");

		HostBoardDto h = new HostBoardDto();
		h.setBh_title(title);
		h.setBh_contents(contents);
		h.setH_id(id);
		h.setBh_num(bhnum);
		try {
			hDao.hostInfoUpdate(h);
			
			//파일 업로드 메소드 호출
			if(check.equals("1")) {
				log.info(bhnum);
				fileUp(multi, bhnum);//0130수정
			}
			
			rttr.addFlashAttribute("msg", "수정 성공");
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msg", "수정 실패");
		}
		
		view = "redirect:hostInfo";
		
		return view;
	}
	
	//파일 업로드 처리 메소드
	public boolean fileUp(MultipartHttpServletRequest multi, String bh_num)throws Exception {
		
		//저장공간에 대한 절대 경로 구하기
		String path = multi.getSession().getServletContext().getRealPath("/");

		path += "resources/upload/";
		log.info(path);
		log.info("fileUp() - bh_num:"+bh_num);
		
		File dir = new File(path);

		if(dir.isDirectory()==false) {
			dir.mkdir();//폴더가 없을 경우 폴더 생성.
		}
		//실제 파일명과 저장 파일명을 함께 관리
		Map<String, String> fmap = new HashMap<String, String>();

		fmap.put("bh_num", bh_num);  
		
		//파일 전송시 기본 값을 파일 다중 선택임.
		//멀티파트 요청 객체에서 꺼내올 때는 List를 사용.
		List<MultipartFile> fList = multi.getFiles("files");
		for(int i = 0; i<fList.size(); i++) {
			MultipartFile mf = fList.get(i);
			String on = mf.getOriginalFilename();
			fmap.put("f_oriname", on);
			log.info(on);
			//변경된 파일 이름 저장
			String sn = System.currentTimeMillis()
					+"."//확장자 구분 점
					+ on.substring(on.lastIndexOf(".")+1);
			fmap.put("f_sysname", sn);
			log.info(sn);
			//해당 폴더에 파일 저장하기 
			mf.transferTo(new File(path+sn));	   

			hDao.hostfileInsert(fmap);
		}
		return true;
	}
	
	@Transactional
	public Map<String, List<FileDto>> fileDelete(String sysname, String bh_num) {
		Map<String, List<FileDto>> rMap = null;
		log.info("fileDelete() - sysname: " + sysname + ", bh_num: " + bh_num);
		//절대 경로는 세션으로 구할 수도 있다.
		String path = session.getServletContext()
				.getRealPath("/");
		
		log.info(path);
		path += "resources/upload/" + sysname;
		
		try {
			hDao.fileDelete(sysname);
			
			File file = new File(path);
			
			if(file.exists()) {
				if(file.delete()) {
					List<FileDto> fList = hDao.getbhfList(bh_num);
					rMap = new HashMap<String, List<FileDto>>();
					rMap.put("fList", fList);
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
}

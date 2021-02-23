package com.dondog.dbapp.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.HpChartDao;
import com.dondog.dbapp.dao.myHistoryDao;
import com.dondog.dbapp.dto.CashDto;
import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HospitalDto;
import com.dondog.dbapp.dto.HostMemberDto;

import lombok.extern.java.Log;

@Service
@Log
public class HpChartService {
	@Autowired
	private HpChartDao hDao;
	
	//세션 객체
	@Autowired
	private HttpSession session;
	
	private ModelAndView mv;
	
	//해당 병원의 병원 예약 리스트 가져오기
	public ModelAndView gethosList() {
		
		mv = new ModelAndView();
		
		HostMemberDto host = (HostMemberDto)session.getAttribute("mb");
		log.info("hospital id : "+host.getH_id());
		
		//병원 예약목록
		List<HospitalDto> hoslist = hDao.gethosList(host.getH_id());
		mv.addObject("hList", hoslist);
		mv.setViewName("hpChart");
		
		return mv;
	}
	//예약 내용 상세보기
	public ModelAndView hpChartContents(String hp_num) {
		log.info("hpChartContents()- hp_num : " +hp_num);
		mv = new ModelAndView();
			
		HospitalDto h = hDao.hpChartContents(hp_num);
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("h", h);	
		List<FileDto> fList = hDao.getfList(h.getP_pid());
		mv.addObject("fList", fList);
		mv.setViewName("hpChartContents");

		return mv;
	}
	//진단서 업로드 폼
	public ModelAndView hpChart_upFrm(String hp_num) {
		log.info("hpChart_upFrm()- hp_num : " +hp_num);
		mv = new ModelAndView();
			
		HospitalDto h = hDao.hpChartContents(hp_num);
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("h", h);	
		List<FileDto> fList = hDao.getfList(h.getP_pid());
		mv.addObject("fList", fList);
		mv.setViewName("hpChart_upFrm");

		return mv;
	}
	//진단서 파일 업로드
	public String hpChartUpload(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		String view = null;
		
		String hpnum = multi.getParameter("hp_num");
		String pid = multi.getParameter("p_pid");
		String check = multi.getParameter("fileCheck");
		log.info("hpnum : "+hpnum);
		HospitalDto h = new HospitalDto();
		h.setP_pid(pid);
		h.setHp_num(hpnum);
		try {
			//파일 업로드 메소드 호출
			if(check.equals("1")) {
				fileUp(multi, pid);
			}
			rttr.addFlashAttribute("msg", "업로드 성공");
		} catch (Exception e) {
			rttr.addFlashAttribute("msg", "업로드 실패");
		} 
		
		view= "redirect:hpChartContents?hp_num="+h.getHp_num();
		return view;
	}
	
	//파일 업로드 처리 메소드
	public boolean fileUp(MultipartHttpServletRequest multi, String p_pid)throws Exception {
		
		//저장공간에 대한 절대 경로 구하기
		String path = multi.getSession().getServletContext().getRealPath("/");

		path += "resources/upload/";
		log.info(path);
		log.info(p_pid);
		
		File dir = new File(path);

		if(dir.isDirectory()==false) {
			dir.mkdir();//폴더가 없을 경우 폴더 생성.
		}
		//실제 파일명과 저장 파일명을 함께 관리
		Map<String, String> fmap = new HashMap<String, String>();

		fmap.put("p_pid", p_pid);  
		
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

			hDao.hpChartInsert(fmap);
		}
		return true;
	}
	
}

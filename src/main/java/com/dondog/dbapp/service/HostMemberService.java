package com.dondog.dbapp.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.HostBoardDao;
import com.dondog.dbapp.dao.HostMemberDao;
import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HostBoardDto;
import com.dondog.dbapp.dto.HostMemberDto;
import com.dondog.dbapp.dto.UpimgFileDto;

import lombok.extern.java.Log;

@Service
@Log
public class HostMemberService {
	//DAO 객체
	@Autowired
	private HostMemberDao hostDao;

	
	//세션객체
	@Autowired
	private HttpSession session;
	
	//ModelAndView
	private ModelAndView mv;
	
	@Transactional
	public String hostInsert(HostMemberDto host, RedirectAttributes rttr) {
		String view = null;
		
		BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder();
		
		String encPass = passEncoder.encode(host.getH_pass());
		host.setH_pass(encPass);
		
		try {
			hostDao.hostInsert(host);
			
			view = "redirect:/";
			rttr.addFlashAttribute("msg", "가입성공");
		}catch (Exception e) {
			//e.printStackTrace();
			view = "redirect:HostJoin";
			rttr.addFlashAttribute("msg", "가입 실패");
		}
		
		return view;
	}//hostInsert end
	
	public String hidCheck(String hid) {
		log.info("hidCheck() hid:" + hid);
		
		String result = null;
		
		int cnt = hostDao.hidCheck(hid);
		
		if(cnt == 0) {
			result = "success";
		}
		else {
			result = "fail";
		}
		return result;
	}//hidCheck end
	
	public String hbusinCheck(String hbusin) {
		log.info("hbusinCheck() hbusin: "+ hbusin);
		String result = null;
		
		int cnt = hostDao.hbusinCheck(hbusin);
		if(cnt == 0) {
			//사용 가능 
			result = "success";
		}
		else {
			//중복
			result = "fail";
		}
		return result;
	}
	public String hemailCheck(String hemail) {
		log.info("hemailCheck() email: "+hemail);
		String result = null;
		
		int cnt = hostDao.hemailCheck(hemail);
		if(cnt == 0) {
			//사용 가능 
			result = "success";
		}
		else {
			//중복
			result = "fail";
		}
		return result;
	}

	public String hloginProc(HostMemberDto host, RedirectAttributes rttr) {
		String view = null;
		//DB에서 암호화된 비밀번호 구하기
		String encPass = hostDao.getEncHPass(host.getH_id());
		
		//암호화된 비밀번호와 입력된 비밀번호의 비교를 위한 인코더 생성		
		BCryptPasswordEncoder passEncode = new BCryptPasswordEncoder();
		
		if(encPass != null) {
			if(passEncode.matches(host.getH_pass(), encPass)) {
			//if(host.getH_pass().equals(encPass)) {
				host = hostDao.getHostInfo(host.getH_id());
				session.setAttribute("mb", host);
				
				view = "redirect:hMain";
			}//matches if end
			else {
				view = "redirect:hloginFrm";
				rttr.addFlashAttribute("msg", "비밀번호 오류");
			}
		}//if end
		else {
			//아이디 없음.
			view = "redirect:hloginFrm";
			rttr.addFlashAttribute("msg", "아이디 없음");
		}
			
		return view;
	}

	public ModelAndView getHMInfo(String h_id) {
		mv = new ModelAndView();
		HostMemberDto host = hostDao.getHostInfo(h_id);
		mv.addObject("mb", host);
		mv.setViewName("HMInfo");
		return mv;
	}

	public ModelAndView HMInfo_updateFrm(String h_id, RedirectAttributes rttr) {
		mv = new ModelAndView();
		HostMemberDto host = hostDao.getHostInfo(h_id);
		mv.addObject("mb", host);
		mv.setViewName("HMInfo_upFrm");
		return mv;

	}

	public String HMInfoUpdate(HostMemberDto host, RedirectAttributes rttr) {
		String view = null;
		String h_id = host.getH_id();
		try {
			hostDao.HMInfoUpdate(host);
			
			rttr.addFlashAttribute("msg", "수정 완료");
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msg", "수정 실패");
		}
		view = "redirect:hmInfoData?h_id="+h_id;
		return view;
	}


	

}//class end

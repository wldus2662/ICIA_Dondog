package com.dondog.dbapp;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.MemberDao;
import com.dondog.dbapp.service.mgMemberService;

import lombok.extern.java.Log;


@Controller
@Log
public class mgMemberController {

	private static final Logger logger = LoggerFactory.getLogger(mgMemberController.class);
	
	//서비스 객체 변수
		@Autowired
		private mgMemberService mgmServ;
		
		//ModelAndView 객체
			private ModelAndView mv;
	
			//회원 정보 페이지 이동 및 정보 가져오기
			@GetMapping("mgMember")
			public ModelAndView mgMemberList() {
				log.info("mgMember()");
				
				mv = mgmServ.mgMemberList();
				
				return mv;
			}
			//회원 상세 내역보기
			@GetMapping("mgMemContents")
			public ModelAndView mgMemContents(String m_id) {
				log.info("mgMemContents()-m_id : " +m_id);
				mv = mgmServ.mgMemContents(m_id);
				return mv;
			}	
					
			//회원 레벨 9로 바꾸기 (회원강제탈퇴)
			@GetMapping("blackdel")
			public String blackdel(String m_id,RedirectAttributes rttr) {
				log.info("blackdel()-m_id : " +m_id);
				String view= mgmServ.blackdel(m_id, rttr);
			
				return view;
			}
			
			//회원 레벨 1로 바꾸기 (관리자계정으로 승인)
			@GetMapping("mgSignup")
			public String mgSignup(String m_id,RedirectAttributes rttr) {
				log.info("mgSignup()-m_id : " +m_id);
				String view= mgmServ.mgSignup(m_id, rttr);
			
				return view;
			}
}

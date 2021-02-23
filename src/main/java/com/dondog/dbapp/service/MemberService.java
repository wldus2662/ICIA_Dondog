 package com.dondog.dbapp.service;

import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.MemberDao;
import com.dondog.dbapp.dto.MemberDto;

import lombok.extern.java.Log;

@Service
@Log
public class MemberService {
	//DAO 객체
	@Autowired
	private MemberDao mDao;
	
	//세션 객체
	@Autowired
	private HttpSession session;
	
	//ModelAndView
	private ModelAndView mv;
	
	
	public String loginProc(MemberDto member,
			RedirectAttributes rttr) {
		String view = null;
		
		//DB에서 암호화된 비밀번호 구하기
		//String encPwd = mDao.getEncPwd(member.getM_id());
		String encPwd = mDao.getEncPwd(member.getM_id()); 
	log.info(encPwd);
	log.info(member.getM_pass());
		//암호화된 비밀번호와 입력한 비밀번호의 비교 처리를 위한
		//인코더 생성
		BCryptPasswordEncoder pwdEncode = new BCryptPasswordEncoder();
		
		if(encPwd != null) {
			//아이디 있음.
			if(pwdEncode.matches(member.getM_pass(), encPwd)) {
				//if(member.getM_pass().equals(encPwd)) {
				//암호화된 비밀번호와 입력한 비밀번호가 같으면 true
				//틀리면 false를 반환하는 메소드 - matches
				
				log.info("확인");
				
				//화면에 출력할 사용자 정보 가져오기
				member = mDao.getMemberInfo(member.getM_id());
				session.setAttribute("mb", member);
				
				if(member.getM_level() == 8)
				{
					session.invalidate();
					view = "redirect:loginFrm";
					rttr.addFlashAttribute("msg", "탈퇴한 회원입니다.");
				}else if(member.getM_level() == 9)
				{
					session.invalidate();
					view = "redirect:loginFrm";
					rttr.addFlashAttribute("msg", "강제퇴장된 회원입니다.");
				}
				else
				{
					view = "redirect:main";
				}
	
			}
			else {
				//비밀번호 틀린 경우.
				view = "redirect:loginFrm";
				rttr.addFlashAttribute("msg", "비밀번호 오류");
			}
		}
		else {
			//아이디 없음.
			view = "redirect:loginFrm";
			rttr.addFlashAttribute("msg", "아이디 없음");
		}
		
		return view;
	}
	
	public String logout() {
		session.invalidate();
		
		return "home";
	}
	///////////////////////////////////////////////////////////////////
	
	
	
	public String idCheck(String id) {
		log.info("idCheck() id: "+id);
		String result = null;
		
		int cnt = mDao.idCheck(id);
		if(cnt == 0) {
			//사용 가능 아이디 
			result = "success";
		}
		else {
			//중복된 아이디
			result = "fail";
		}
		return result;
	}
	
	public String name2Check(String name2) {
		log.info("name2Check() name2: "+name2);
		String result = null;
		
		int cnt = mDao.name2Check(name2);
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
	public String emailCheck(String email) {
		log.info("emailCheck() email: "+email);
		String result = null;
		
		int cnt = mDao.emailCheck(email);
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
	
	//회원가입 - 1.기본정보입력
	@Transactional
	public String memberInsert(MemberDto member,
			RedirectAttributes rttr) {
		String view = null;
		
		//비밀번호 암호화 처리
		//스프링 프레임워크에서 제공하는 암호화 인코더 사용
		BCryptPasswordEncoder pwdEncoder =
				new BCryptPasswordEncoder();
		
		String encPwd = pwdEncoder.encode(member.getM_pass());
		member.setM_pass(encPwd);
		String type = member.getType();
		log.info(type);
		try {
			mDao.memberInsert(member);

			//반려동물입력 때 사용할 사용자 정보 가져오기
			member = mDao.getMemberInfo(member.getM_id());
			//반려동물입력 때 사용하기 위해 세션에 다시 저장
			session.setAttribute("mb", member);
	
			view = "redirect:joinFrm_pet?"+type;
			
			rttr.addFlashAttribute("msg", "입력 성공");
		} catch (Exception e) {
			//e.printStackTrace();
			view = "redirect:joinFrm";
			rttr.addFlashAttribute("msg", "입력 실패");
		}
		
		return view;
	}
		
		//기본 정보 가져오기
		public ModelAndView getMemberInfo(String m_id) {
			mv = new ModelAndView();
			//글 내용 가져오기
			MemberDto member = mDao.getMemberInfo(m_id);

			//모델 데이터 담기
			mv.addObject("mb", member);
			//뷰 이름 지정하기
			mv.setViewName("myInfo");

			return mv;
		}
		//수정 정보 가져오기
		public ModelAndView myInfo_updateFrm(String m_id, RedirectAttributes rttr) {
			mv = new ModelAndView();
			//수정할 내용 가져오기
			MemberDto member = mDao.getMemberInfo(m_id);
			//모델 데이터 담기
			mv.addObject("member", member);
			//뷰 이름 지정하기
			mv.setViewName("myInfo_upFrm");
			
			return mv;
		}
		
		//기본 정보 수정 처리
		@Transactional
		public String myInfoUpdate(MemberDto member,
				RedirectAttributes rttr) {
			String view = null;
			String m_id = member.getM_id();
			try {
				mDao.myInfoUpdate(member);
				
				rttr.addFlashAttribute("msg", "수정 완료");
			} catch (Exception e) {
				e.printStackTrace();
				rttr.addFlashAttribute("msg", "수정 실패");
			}
			view = "redirect:myInfoData?m_id="+m_id;
			return view;
		}
		/////////////////////////////////////////////////0201추가

		@Transactional
		public String myQuit(String m_id, RedirectAttributes rttr) {
			log.info("myQuit()- m_id : "+m_id);

			String view = null;
			try {
				//상태 컬럼 8로 변경 
				mDao.myQuit(m_id);
				logout();
				view = "redirect:/";
				rttr.addFlashAttribute("msg", "정상적으로 탈퇴되었습니다.");
			} catch (Exception e) {
				//e.printStackTrace();
				view= "redirect:myMain";
				rttr.addFlashAttribute("msg", "탈퇴 실패");
			}
			return view;
		}
}//class end






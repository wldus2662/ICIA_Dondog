package com.dondog.dbapp.service;

import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.UserSearchDao;
import com.dondog.dbapp.dto.MemberDto;

import lombok.extern.java.Log;

@Service
@Log
public class UserSearchService {
	@Autowired
	private UserSearchDao uDao;
	@Autowired
	private MemberService mServ;
	//세션 객체
	@Autowired
	private HttpSession session;

	//아이디 찾기
	public String get_searchId(String user_name, String user_phone) {
		log.info("get_searchId");
		String result = "";

		try {
			result = uDao.searchId(user_name, user_phone);
			log.info("회원 아이디: " +result);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	//비밀번호 찾기
	public String get_searchPw(String user_id, String user_email) {
		log.info("get_searchPw");
	
		Random random = new Random();
		int checkNum = (random.nextInt(888888) + 111111);
		String key = Integer.toString(checkNum);
		log.info("임시 비밀번호 " +key);

		try {
			//스프링 프레임워크에서 제공하는 암호화 인코더 사용
			BCryptPasswordEncoder pwdEncoder =
					new BCryptPasswordEncoder();
			
			String encPwd = pwdEncoder.encode(key);
			uDao.searchPassword(user_id, user_email, encPwd);
			log.info("비밀번호 : " +key);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return key;
	}
	
	//비밀번호 변경 처리
		public String updatePw(String m_pass,RedirectAttributes rttr) {
			log.info("uServ.updatePw()- m_pass : " +m_pass);
			String view = null;
			
			MemberDto member = (MemberDto)session.getAttribute("mb");
			String m_id = member.getM_id();
			log.info("아이디 : "+m_id);
			
			//스프링 프레임워크에서 제공하는 암호화 인코더 사용
			BCryptPasswordEncoder pwdEncoder =
					new BCryptPasswordEncoder();
			
			String encPwd = pwdEncoder.encode(m_pass);
			log.info(encPwd);
			try {
				//로그인된 아이디의 정보에 비밀번호를 업데이트
				uDao.updatePw(m_id, encPwd);
				mServ.logout();
				view = "redirect:/";
				rttr.addFlashAttribute("msg", "비밀번호가 변경되었습니다. "
						+ "변경된 비밀번호로 다시 로그인해주세요.");
			} catch (Exception e) {
				e.printStackTrace();
				view= "redirect:myPass";
				rttr.addFlashAttribute("msg", "변경 실패");
			}			
			return view;
		}
}

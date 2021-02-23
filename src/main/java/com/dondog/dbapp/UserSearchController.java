package com.dondog.dbapp;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.service.UserSearchService;

import lombok.extern.java.Log;

@Controller
@Log
public class UserSearchController {
	@Autowired
	private UserSearchService searchService;

	@GetMapping("userSearch")
	public String userSearch() {
		return "userSearch";
	}
	
	// 아이디 찾기
	@PostMapping(value="userIdSearch", produces= "application/json; charset=utf-8")
	@ResponseBody
	String userIdSearch(@RequestParam("inputName_1") String user_name, 
			@RequestParam("inputPhone_1") String user_phone) {
		log.info(user_name);
		log.info(user_phone);
		String result = searchService.get_searchId(user_name, user_phone);
		log.info(result);
		return result;
	}
	// 아이디 찾기
	@PostMapping(value="userPwSearch", produces= "application/json; charset=utf-8")
	@ResponseBody
	String userPwSearch(@RequestParam("inputId") String user_id, 
			@RequestParam("inputEmail_2") String user_email) {
		log.info(user_id);
		log.info(user_email);
		String result = searchService.get_searchPw(user_id, user_email);
		log.info(result);
		return result;
	}
	
	@GetMapping("myPass")
	public String myPass() {
		return "myPass";
	}
	//비밀번호 변경 처리 
	@PostMapping("updatePw")
	public String updatePw(String m_pass,
		RedirectAttributes rttr) {
		log.info("updatePw()-m_pass : " +m_pass);
		String view= searchService.updatePw(m_pass, rttr);
	
		return view;
	}
	
}

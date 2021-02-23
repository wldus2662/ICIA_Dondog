package com.dondog.dbapp;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.service.CashService;

import lombok.extern.java.Log;

@Controller
@Log
public class CashController {
	
	@Autowired
	private CashService cServ;
	//세션 객체
	@Autowired
	private HttpSession session;
	
	private ModelAndView mv;
	
	//결제 정보 페이지 이동 & 결제내역 가져오기
	@GetMapping("cashList")
	public ModelAndView cashList(String m_id) {
		log.info("cashList() m_id : "+m_id);

		mv = cServ.getCashList(m_id);
		return mv;
	}
	//결제 상세 내역 보기
	@GetMapping("cashContents")
	public ModelAndView cashContents(String c_num) {
		log.info("cashContents()-c_num : " +c_num);
		mv = cServ.cashContents(c_num);
		return mv;
	}	
	//결제 취소 처리 
	@GetMapping("cashCancle")
	public String cashCancle(String c_num,
		RedirectAttributes rttr) {
		log.info("cashCancle()-c_num : " +c_num);
		String view= cServ.cashCancle(c_num, rttr);
	
		return view;
	}
	
	//결제 관리 페이지 이동 & 결제내역 가져오기
	@GetMapping("cashAdmin")
	public ModelAndView cashAdmin() {
		log.info("cashAdmin()");

		mv = cServ.getCashAll();
		return mv;
	}
	
	//결제 상세 내역 보기
	@GetMapping("cashAdContents")
	public ModelAndView cashAdContents(String c_num) {
		log.info("cashAdContents()-c_num : " +c_num);
		mv = cServ.cashAdContents(c_num);
		return mv;
	}	
	//결제 승인 처리
	@GetMapping("cashSuccess")
	public String cashSuccess(String c_num,
			RedirectAttributes rttr) {
			log.info("cashSuccess()-c_num : " +c_num);
			String view= cServ.cashSuccess(c_num, rttr);
		
			return view;
	}
	
}

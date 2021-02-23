package com.dondog.dbapp;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.service.HpChartService;

import lombok.extern.java.Log;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@Log
public class HpChartController {
	@Autowired
	private HpChartService hServ;

	private ModelAndView mv;
	
	//병원 예약내역 가져오기
	@GetMapping("hpChart")
	public ModelAndView hpChart() {
		log.info("hpChart");

		mv = hServ.gethosList();
		return mv;
	}
	//예약 내역 상세보기
	@GetMapping("hpChartContents")
	public ModelAndView hpChartContents(String hp_num) {
		log.info("hpChartContents");
		mv = hServ.hpChartContents(hp_num);
		return mv;
	}
	//진단서 업로드 폼으로 이동
	@GetMapping("hpChart_upFrm")
	public ModelAndView hpChart_upFrm(String hp_num) {
		log.info("hpChart_upFrm");
		mv = hServ.hpChart_upFrm(hp_num);
		return mv;
	}
	
	//진단서 업로드
	@PostMapping("hpChartUpload")
	public String hpChartUpload(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		String view = hServ.hpChartUpload(multi, rttr);
		return view;
	}
	
}

package com.dondog.dbapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.service.HpChartService;
import com.dondog.dbapp.service.MyResNowService;
import lombok.extern.java.Log;

@Controller
@Log
public class MyResNowController {
	//서비스 객체 변수
	@Autowired
	private MyResNowService rServ;

	//ModelAndView 객체
	private ModelAndView mv;

	//나의 예약 리스트 보기	
	@GetMapping("myResNow")
	public ModelAndView myResNow() {
		log.info("myResNow()");

		mv = rServ.getresList();

		return mv;
	}
	//병원 예약 상세 내역 보기
	@GetMapping("myResHosContents")
	public ModelAndView myResHosContents(String hp_num) {
		log.info("myResHosContents()");
		mv = rServ.hpChartContents(hp_num);
		return mv;
	}
	//병원 예약 취소 처리 
	@GetMapping("myhosCancle")
	public String myhosCancle(String hp_num,
			RedirectAttributes rttr) {
		log.info("myhosCancle()-hp_num : " +hp_num);
		String view= rServ.myhosCancle(hp_num, rttr);

		return view;
	}
	//미용 예약 상세 내역 보기
	@GetMapping("myResBeaContents")
	public ModelAndView myResBeaContents(String ca_num) {
		log.info("myResBeaContents()");
		mv = rServ.bContents(ca_num);
		return mv;
	}
	//미용 예약 취소 처리 
	@GetMapping("mybeuCancle")
	public String mybeuCancle(String ca_num,
			RedirectAttributes rttr) {
		log.info("mybeuCancle()-hp_num : " +ca_num);
		String view= rServ.bCancle(ca_num, rttr);

		return view;
	}
	//훈련소 예약 상세 내역 보기
	@GetMapping("myResTraContents")
	public ModelAndView myResTraContents(String ca_num) {
		log.info("myResTraContents()");
		mv = rServ.tContents(ca_num);
		return mv;
	}
	//훈련소 예약 취소 처리 
	@GetMapping("mytraCancle")
	public String mytraCancle(String ca_num,
			RedirectAttributes rttr) {
		log.info("mytraCancle()-hp_num : " +ca_num);
		String view= rServ.tCancle(ca_num, rttr);

		return view;
	}
	//숙소 예약 상세 내역 보기
	@GetMapping("myResHotContents")
	public ModelAndView myResHotContents(String ca_num) {
		log.info("myResHotContents()");
		mv = rServ.hContents(ca_num);
		return mv;
	}
	//숙소 예약 취소 처리 
	@GetMapping("myhotCancle")
	public String myhotCancle(String ca_num,
			RedirectAttributes rttr) {
		log.info("myhotCancle()-hp_num : " +ca_num);
		String view= rServ.hCancle(ca_num, rttr);

		return view;
	}
}

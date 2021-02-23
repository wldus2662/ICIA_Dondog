package com.dondog.dbapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dto.CareReservationDto;
import com.dondog.dbapp.dto.HospitalDto;
import com.dondog.dbapp.dto.HostMemberDto;
import com.dondog.dbapp.service.HostResService;

import lombok.extern.java.Log;

@Controller
@Log
public class HostResController {
	//서비스 객체 변수
	@Autowired
	private HostResService hServ;

	//ModelAndView 객체
	private ModelAndView mv;

	//내 업체 예약 리스트 보기	
	@GetMapping("hostResList")
	public ModelAndView hostResList() {
		log.info("hostResList()");
		mv = hServ.getresList();

		return mv;
	}
	//병원 예약 상세 내역 보기
	@GetMapping("hostResHospital")
	public ModelAndView hostResHospital(String hp_num) {
		log.info("hostResHospital()");
		mv = hServ.hostResHospital(hp_num);
		return mv;
	}
	//병원 예약 수락 처리
	@GetMapping("hostResHosSuccess")
	public String hostResHosSuccess(String hp_num,
			RedirectAttributes rttr) {
		log.info("hostResHosSuccess()-hp_num : " +hp_num);
		String view= hServ.hosSuccess(hp_num, rttr);

		return view;
	}
	//병원 예약 거절 처리 
	@PostMapping("hostResHosCancle")
	public String hostResHosCancle(HospitalDto h,
			RedirectAttributes rttr) {
		log.info("hostResHosCancle()");
		String view= hServ.hosCancle(h, rttr);

		return view;
	}

	//미용 예약 상세 내역 보기
	@GetMapping("hostResBeauty")
	public ModelAndView hostResBeauty(String ca_num) {
		log.info("hostResBeauty()");
		mv = hServ.hContents(ca_num);
		return mv;
	}
	//훈련소 예약 상세 내역 보기
	@GetMapping("hostResTraining")
	public ModelAndView hostResTraining(String ca_num) {
		log.info("hostResTraining()");
		mv = hServ.hContents(ca_num);
		return mv;
	}
	//숙소 예약 상세 내역 보기
	@GetMapping("hostResHotel")
	public ModelAndView hostResHotel(String ca_num) {
		log.info("hostResHotel()");
		mv = hServ.hContents(ca_num);
		return mv;
	}
	//숙소 예약 수락 처리
	@GetMapping("hostResHotSuccess")
	public String hostResHotSuccess(String ca_num,
			RedirectAttributes rttr) {
		log.info("hostResHotSuccess()-ca_num : " +ca_num);
		String view= hServ.hSuccess(ca_num, rttr);
		
		return view;
	}
	//숙소 예약 거절 처리  
	@PostMapping("careCancle")
	public String careCancle(CareReservationDto c,
			RedirectAttributes rttr) {
		log.info("careCancle()");
		String view= hServ.careCancle(c, rttr);

		return view;
	}

}

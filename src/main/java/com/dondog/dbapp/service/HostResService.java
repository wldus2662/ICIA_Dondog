package com.dondog.dbapp.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.HostResDao;
import com.dondog.dbapp.dao.HpChartDao;
import com.dondog.dbapp.dao.MyResNowDao;
import com.dondog.dbapp.dto.CareReservationDto;
import com.dondog.dbapp.dto.HospitalDto;
import com.dondog.dbapp.dto.HostMemberDto;

import lombok.extern.java.Log;

@Service
@Log
public class HostResService {
	//DAO 객체
	@Autowired
	private HostResDao hDao;
	@Autowired
	private HpChartDao hcDao;
	@Autowired
	private MyResNowDao rDao;
	//세션 객체
	@Autowired
	private HttpSession session;

	//ModelAndView
	private ModelAndView mv;

	//예약된 리스트 가져오기 
	public ModelAndView getresList() {

		log.info("getresList");

		mv = new ModelAndView();

		HostMemberDto host = (HostMemberDto)session.getAttribute("mb");
		log.info("업체 아이디 : "+host.getH_id());

		//업종 비교
		String kind = host.getH_kind();
		log.info("업체 종류 : "+kind);
		if(kind.equals("병원")) {
			//병원 예약목록
			List<HospitalDto> hoslist = hDao.gethosInfo(host.getH_id());
			mv.addObject("hList", hoslist);
		}
		else {
			//미용, 훈련소, 숙소 예약 목록
			List<CareReservationDto> carelist = hDao.getCareInfo(host.getH_id());
			mv.addObject("cList", carelist);
		}
		mv.setViewName("hostResList");

		return mv;
	}

	//병원 예약 상세보기 
	public ModelAndView hostResHospital(String hp_num) {
		log.info("hostResHospital()- hp_num : " +hp_num);
		mv = new ModelAndView();

		HospitalDto h = hcDao.hpChartContents(hp_num);
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("h", h);	
		mv.setViewName("hostResHospital");

		return mv;
	}

	//병원 예약 수락 처리
	public String hosSuccess(String hp_num,RedirectAttributes rttr) {
		log.info("hosSuccess()- hp_num : " +hp_num);

		String view = null;

		try {
			//상태를 수락으로 업데이트
			hDao.hosSuccess(hp_num);
			rttr.addFlashAttribute("msg", "예약이 수락되었습니다.");
		} catch (Exception e) {
			//e.printStackTrace();
			rttr.addFlashAttribute("msg", "수락 실패");
		}

		view = "redirect:hostResHospital?hp_num="+hp_num;

		return view;
	}
	//병원 예약 거절 처리
	public String hosCancle(HospitalDto h, RedirectAttributes rttr) {
		log.info("hosCancle()");
		log.info("취소사유 : " +h.getHp_can());
		String view = null;
		String hp_num = h.getHp_num();
		log.info(hp_num);
		try {
			//상태를 취소로 업데이트
			rDao.hosCancle(hp_num);
			hDao.hosCanReason(h);

			rttr.addFlashAttribute("msg", "예약이 거절되었습니다.");
		} catch (Exception e) {
			//e.printStackTrace();
			rttr.addFlashAttribute("msg", "거절 실패");
		}

		view = "redirect:hostResHospital?hp_num="+hp_num;

		return view;
	}
	//미용, 훈련소, 숙소 예약 상세보기 
	public ModelAndView hContents(String ca_num) {
		log.info("hContents()- ca_num : " +ca_num);
		mv = new ModelAndView();

		CareReservationDto c = rDao.getContents(ca_num);
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("c", c);	
		if(ca_num.contains("H"))mv.setViewName("hostResHotel");
		else if (ca_num.contains("B")) mv.setViewName("hostResBeauty");
		else mv.setViewName("hostResTraining");
		
		return mv;
	}
	//미용, 훈련소, 숙소 예약 수락 처리
	public String hSuccess(String ca_num,RedirectAttributes rttr) {
		log.info("hSuccess()- ca_num : " +ca_num);

		String view = null;

		try {
			//상태를 수락으로 업데이트
			hDao.careSuccess(ca_num);
			rttr.addFlashAttribute("msg", "예약이 수락되었습니다.");
		} catch (Exception e) {
			//e.printStackTrace();
			rttr.addFlashAttribute("msg", "수락 실패");
		}
		if(ca_num.contains("H"))	view = "redirect:hostResHotel?ca_num="+ca_num;
		else if (ca_num.contains("B")) view = "redirect:hostResBeauty?ca_num="+ca_num;
		else view = "redirect:hostResTraining?ca_num="+ca_num;
		
		return view;
	}
	//미용, 훈련소, 숙소 예약 거절 처리
	public String careCancle(CareReservationDto c, RedirectAttributes rttr) {
		log.info("careCancle()");
		log.info("취소사유 : " +c.getCa_can());
		String view = null;
		String ca_num = c.getCa_num();
		log.info(ca_num);
		try {
			//상태를 취소로 업데이트
			rDao.myCancle(ca_num);
			hDao.careCanReason(c);

			rttr.addFlashAttribute("msg", "예약이 거절되었습니다.");
		} catch (Exception e) {
			//e.printStackTrace();
			rttr.addFlashAttribute("msg", "거절 실패");
		}
		if(c.getCa_num().contains("H"))	view = "redirect:hostResHotel?ca_num="+ca_num;
		else if (c.getCa_num().contains("B")) view = "redirect:hostResBeauty?ca_num="+ca_num;
		else view = "redirect:hostResTraining?ca_num="+ca_num;
		
		return view;
	}
}

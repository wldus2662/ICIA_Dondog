package com.dondog.dbapp.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.HpChartDao;
import com.dondog.dbapp.dao.MyResNowDao;
import com.dondog.dbapp.dao.myHistoryDao;
import com.dondog.dbapp.dto.CareReservationDto;
import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HospitalDto;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.ResPetsitterDto;

import lombok.extern.java.Log;

@Service
@Log
public class MyResNowService {

	//DAO 객체
	@Autowired
	private myHistoryDao hDao;
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

		MemberDto member = (MemberDto)session.getAttribute("mb");
		log.info(member.getM_id());

		//병원 예약목록
		List<HospitalDto> hoslist = hDao.gethosInfo(member.getM_id());
		mv.addObject("hList", hoslist);

		//미용, 훈련소, 숙소 예약 목록
		List<CareReservationDto> carelist = hDao.getCareInfo(member.getM_id());
		mv.addObject("cList", carelist);

		//펫시터 예약 목록
		List<ResPetsitterDto> sitterlist = hDao.getsitterInfo(member.getM_id());
		mv.addObject("sList", sitterlist);


		mv.setViewName("myResNow");

		return mv;
	}

	//병원 예약 상세보기
	public ModelAndView hpChartContents(String hp_num) {
		log.info("hpChartContents()- hp_num : " +hp_num);
		mv = new ModelAndView();

		HospitalDto h = hcDao.hpChartContents(hp_num);
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("h", h);	
		List<FileDto> fList = hcDao.getfList(h.getP_pid());
		mv.addObject("fList", fList);
		mv.setViewName("myResHosContents");

		return mv;
	}
	//병원 예약 취소 처리
	public String myhosCancle(String hp_num,RedirectAttributes rttr) {
		log.info("myhosCancle()- hp_num : " +hp_num);

		String view = null;

		try {
			//상태를 취소로 업데이트
			rDao.hosCancle(hp_num);
			rttr.addFlashAttribute("msg", "예약이 취소되었습니다.");
		} catch (Exception e) {
			//e.printStackTrace();
			rttr.addFlashAttribute("msg", "취소 실패");
		}

		view = "redirect:myResHosContents?hp_num="+hp_num;

		return view;
	}

	//미용 예약 상세보기
	public ModelAndView bContents(String ca_num) {
		log.info("bContents()- ca_num : " +ca_num);
		mv = new ModelAndView();

		CareReservationDto c = rDao.getContents(ca_num);
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("c", c);	
		mv.setViewName("myResBeaContents");

		return mv;
	}
	//미용 예약 취소 처리
	public String bCancle(String ca_num,RedirectAttributes rttr) {
		log.info("bCancle()- ca_num : " +ca_num);

		String view = null;

		try {
			//상태를 취소로 업데이트
			rDao.myCancle(ca_num);
			rttr.addFlashAttribute("msg", "예약이 취소되었습니다.");
		} catch (Exception e) {
			//e.printStackTrace();
			rttr.addFlashAttribute("msg", "취소 실패");
		}

		view = "redirect:myResBeaContents?ca_num="+ca_num;

		return view;
	}
	//훈련소 예약 상세보기
	public ModelAndView tContents(String ca_num) {
		log.info("tContents()- ca_num : " +ca_num);
		mv = new ModelAndView();

		CareReservationDto c = rDao.getContents(ca_num);
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("c", c);	
		mv.setViewName("myResTraContents");

		return mv;
	}
	//미용 예약 취소 처리
		public String tCancle(String ca_num,RedirectAttributes rttr) {
			log.info("tCancle()- ca_num : " +ca_num);

			String view = null;

			try {
				//상태를 취소로 업데이트
				rDao.myCancle(ca_num);
				rttr.addFlashAttribute("msg", "예약이 취소되었습니다.");
			} catch (Exception e) {
				//e.printStackTrace();
				rttr.addFlashAttribute("msg", "취소 실패");
			}

			view = "redirect:myResTraContents?ca_num="+ca_num;

			return view;
		}
	//숙소 예약 상세보기
	public ModelAndView hContents(String ca_num) {
		log.info("hContents()- ca_num : " +ca_num);
		mv = new ModelAndView();

		CareReservationDto c = rDao.getContents(ca_num);
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("c", c);	
		mv.setViewName("myResHotContents");

		return mv;
	}
	//숙소 예약 취소 처리
		public String hCancle(String ca_num,RedirectAttributes rttr) {
			log.info("hCancle()- ca_num : " +ca_num);

			String view = null;

			try {
				//상태를 취소로 업데이트
				rDao.myCancle(ca_num);
				rttr.addFlashAttribute("msg", "예약이 취소되었습니다.");
			} catch (Exception e) {
				//e.printStackTrace();
				rttr.addFlashAttribute("msg", "취소 실패");
			}

			view = "redirect:myResHotContents?ca_num="+ca_num;

			return view;
		}
}

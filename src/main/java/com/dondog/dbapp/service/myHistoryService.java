package com.dondog.dbapp.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.dao.myHistoryDao;
import com.dondog.dbapp.dto.CareReservationDto;
import com.dondog.dbapp.dto.CommuntyDto;
import com.dondog.dbapp.dto.HospitalDto;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.ResPetsitterDto;

import lombok.extern.java.Log;

@Service
@Log
public class myHistoryService {
		//DAO 객체
		@Autowired
		private myHistoryDao hDao;
		
		//세션 객체
		@Autowired
		private HttpSession session;
		
		//ModelAndView
		private ModelAndView mv;
		
			//나의 업체 이용내역 (간단히) 목록 가져오는 메소드
			public ModelAndView getHosList() {
			
			log.info("getHosList");
			
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
			
			//DB에서 조회한 데이터 목록을 모델에 추가
			mv.setViewName("myHistory");
					
			return mv;
		}
}//class end

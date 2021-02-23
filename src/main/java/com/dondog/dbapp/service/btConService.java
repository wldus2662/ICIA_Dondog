package com.dondog.dbapp.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.dao.myHistoryDao;
import com.dondog.dbapp.dto.CareReservationDto;
import com.dondog.dbapp.dto.MemberDto;

import lombok.extern.java.Log;

@Service
@Log
public class btConService {

	//DAO 객체
			@Autowired
			private myHistoryDao btDao;
			
			//세션 객체
			@Autowired
			private HttpSession session;
			
			//ModelAndView
			private ModelAndView mv2;
			
			public ModelAndView btlist() {
				
				log.info("getbtlist");
				
				mv2 = new ModelAndView();
				
				MemberDto member = (MemberDto)session.getAttribute("mb");
				log.info(member.getM_id());
				
				//미용 예약목록
				List<CareReservationDto> btlist = btDao.getbtInfo(member.getM_id());
				mv2.addObject("btList", btlist);
	
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv2.setViewName("btContents");
						
				return mv2;
			}
	
}

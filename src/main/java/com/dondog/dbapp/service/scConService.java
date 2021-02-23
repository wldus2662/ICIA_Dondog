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
public class scConService {

	//DAO 객체
			@Autowired
			private myHistoryDao scDao;
			
			//세션 객체
			@Autowired
			private HttpSession session;
			
			//ModelAndView
			private ModelAndView mv3;
			
			public ModelAndView sclist() {
				
				log.info("getsclist");
				
				mv3 = new ModelAndView();
				
				MemberDto member = (MemberDto)session.getAttribute("mb");
				log.info(member.getM_id());
				
				//훈련소 예약목록
				List<CareReservationDto> sclist = scDao.getscInfo(member.getM_id());
				mv3.addObject("scList", sclist);
	
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv3.setViewName("scContents");
						
				return mv3;
			}
	
}

package com.dondog.dbapp.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.dao.myHistoryDao;
import com.dondog.dbapp.dto.HospitalDto;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.ResPetsitterDto;

import lombok.extern.java.Log;

@Service
@Log
public class psConService {

	//DAO 객체
			@Autowired
			private myHistoryDao psDao;
			
			//세션 객체
			@Autowired
			private HttpSession session;
			
			//ModelAndView
			private ModelAndView mv5;
			
			public ModelAndView getsitterlist1() {
				
				log.info("getsitterInfo1");
				
				mv5 = new ModelAndView();
				
				MemberDto member = (MemberDto)session.getAttribute("mb");
				log.info(member.getM_id());
				
				//펫시터 예약목록
				List<ResPetsitterDto> sitterlist1 = psDao.getsitterInfo1(member.getM_id());
				mv5.addObject("sList1", sitterlist1);
	
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv5.setViewName("psContents");
						
				return mv5;
			}
	
}

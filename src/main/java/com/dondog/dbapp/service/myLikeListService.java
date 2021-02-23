package com.dondog.dbapp.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.dao.myHistoryDao;
import com.dondog.dbapp.dto.HostBoardDto;
import com.dondog.dbapp.dto.LikeListDto;
import com.dondog.dbapp.dto.MemberDto;

import lombok.extern.java.Log;

@Service
@Log
public class myLikeListService {

	//DAO 객체
			@Autowired
			private myHistoryDao hpDao;
			
			//세션 객체
			@Autowired
			private HttpSession session;
			
			//ModelAndView
			private ModelAndView mv;
			
			public ModelAndView myLikeList() {
				
				log.info("myLikeList");
				
				mv = new ModelAndView();
				
				MemberDto member = (MemberDto)session.getAttribute("mb");
				log.info(member.getM_id());
				
				//병원 예약목록
				List<LikeListDto> myLikeList = hpDao.myLikeList(member.getM_id());
				mv.addObject("myLikeList", myLikeList);
	
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.setViewName("myLikeList");
						
				return mv;
			}
			//업체정보 상세내역
			public ModelAndView myLiCon(String bh_num) {
				log.info("myLiCon()- bh_num : " +bh_num);
				mv = new ModelAndView();
					
				HostBoardDto lic = hpDao.myLiCon(bh_num);
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.addObject("lic", lic);	

				mv.setViewName("myLiCon");

				return mv;
			}
			
	
}

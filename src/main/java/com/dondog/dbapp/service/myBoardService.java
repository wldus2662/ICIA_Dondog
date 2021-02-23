package com.dondog.dbapp.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.dao.myHistoryDao;
import com.dondog.dbapp.dto.CommuntyDto;
import com.dondog.dbapp.dto.MemberDto;


import lombok.extern.java.Log;

@Service
@Log
public class myBoardService {

	//DAO 객체
			@Autowired
			private myHistoryDao hpDao;
			
			//세션 객체
			@Autowired
			private HttpSession session;
			
			//ModelAndView
			private ModelAndView mv6;
			
			public ModelAndView getCmList() {
				
				log.info("getCmList");
				
				mv6 = new ModelAndView();
				
				MemberDto member = (MemberDto)session.getAttribute("mb");
				log.info(member.getM_id());
				
				//게시글목록
				List<CommuntyDto> cmlist = hpDao.getCmList(member.getM_id());
				mv6.addObject("cmlist", cmlist);
				
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv6.setViewName("myBoard");
				
				return mv6;
			}//method end

	
}

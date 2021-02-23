package com.dondog.dbapp.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.dao.myHistoryDao;
import com.dondog.dbapp.dto.BlackListDto;
import com.dondog.dbapp.dto.MemberDto;

import lombok.extern.java.Log;

@Service
@Log
public class mgBlackListService {

	//DAO 객체
			@Autowired
			private myHistoryDao mgbDao;
			
			//세션 객체
			@Autowired
			private HttpSession session;
			
			//ModelAndView
			private ModelAndView mv8;
			
			public ModelAndView mgBlackList() {
				
				log.info("mgBlackList");
				
				mv8 = new ModelAndView();
				
				MemberDto member = (MemberDto)session.getAttribute("mb");
				log.info(member.getM_id());
				
				//멤버 목록
				List<BlackListDto> mgBlackList = mgbDao.mgBlackList(member.getM_id());
				mv8.addObject("mgBlackList", mgBlackList);
	
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv8.setViewName("mgBlackList");
						
				return mv8;
			}
	
}

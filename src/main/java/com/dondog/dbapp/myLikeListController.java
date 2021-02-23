package com.dondog.dbapp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.service.myLikeListService;

import lombok.extern.java.Log;


@Controller
@Log
public class myLikeListController {

	private static final Logger logger = LoggerFactory.getLogger(myLikeListController.class);
	
	//서비스 객체 변수
		@Autowired
		private myLikeListService mylServ;
		
		//ModelAndView 객체
			private ModelAndView mv;
	
			
			@GetMapping("myLikeList")
			public ModelAndView myLikeList() {
				log.info("myLikeList()");
				
				mv = mylServ.myLikeList();
				
				return mv;
			}
			//업체등록 상세 내역 보기
			@GetMapping("myLiCon")
			public ModelAndView myLiCon(String bh_num) {
				log.info("myLiCon()-bh_num : " +bh_num);
				mv = mylServ.myLiCon(bh_num);
				return mv;
			}
}

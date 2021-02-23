package com.dondog.dbapp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.service.myBoardService;

import lombok.extern.java.Log;


@Controller
@Log
public class myBoardController {

	private static final Logger logger = LoggerFactory.getLogger(myBoardController.class);
	
	//서비스 객체 변수
		@Autowired
		private myBoardService mbcServ;
		
		//ModelAndView 객체
			private ModelAndView mv6;
	
			
			@GetMapping("myBoard")
			public ModelAndView myBoard() {
				log.info("myBoard()");
				
				mv6 = mbcServ.getCmList();
				
				return mv6;
			}
}

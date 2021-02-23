package com.dondog.dbapp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.service.mgBlackListService;

import lombok.extern.java.Log;


@Controller
@Log
public class mgBlackListController {

	private static final Logger logger = LoggerFactory.getLogger(mgBlackListController.class);
	
	//서비스 객체 변수
		@Autowired
		private mgBlackListService mgbServ;
		
		//ModelAndView 객체
			private ModelAndView mv8;
	
			
			@GetMapping("mgBlackList")
			public ModelAndView mgBlackList() {
				log.info("mgBlackList()");
				
				mv8 = mgbServ.mgBlackList();
				
				return mv8;
			}
}

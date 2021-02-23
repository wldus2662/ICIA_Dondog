package com.dondog.dbapp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.service.btConService;

import lombok.extern.java.Log;


@Controller
@Log
public class btConController {

	private static final Logger logger = LoggerFactory.getLogger(btConController.class);
	
	//서비스 객체 변수
		@Autowired
		private btConService btServ;
		
		//ModelAndView 객체
			private ModelAndView mv2;
	
			
			@GetMapping("btContents")
			public ModelAndView btContents() {
				log.info("btContents()");
				
				mv2 = btServ.btlist();
				
				return mv2;
			}
}

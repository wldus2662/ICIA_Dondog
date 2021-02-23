package com.dondog.dbapp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.service.btConService;
import com.dondog.dbapp.service.scConService;

import lombok.extern.java.Log;


@Controller
@Log
public class scConController {

	private static final Logger logger = LoggerFactory.getLogger(scConController.class);
	
	//서비스 객체 변수
		@Autowired
		private scConService scServ;
		
		//ModelAndView 객체
			private ModelAndView mv3;
	
			
			@GetMapping("scContents")
			public ModelAndView scContents() {
				log.info("scContents()");
				
				mv3 = scServ.sclist();
				
				return mv3;
			}
}

package com.dondog.dbapp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.service.hpConService;
import com.dondog.dbapp.service.psConService;

import lombok.extern.java.Log;


@Controller
@Log
public class psConController {

	private static final Logger logger = LoggerFactory.getLogger(psConController.class);
	
	//서비스 객체 변수
		@Autowired
		private psConService psServ;
		
		//ModelAndView 객체
			private ModelAndView mv5;
	
			
			@GetMapping("psContents")
			public ModelAndView psContents() {
				log.info("psContents()");
				
				mv5 = psServ.getsitterlist1();
				
				return mv5;
			}
}

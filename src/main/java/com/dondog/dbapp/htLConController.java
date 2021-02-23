package com.dondog.dbapp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.service.htLConService;

import lombok.extern.java.Log;


@Controller
@Log
public class htLConController {

	private static final Logger logger = LoggerFactory.getLogger(htLConController.class);
	
	//서비스 객체 변수
		@Autowired
		private htLConService htLServ;
		
		//ModelAndView 객체
			private ModelAndView mv4;
	
			@GetMapping("htLContents")
			public ModelAndView htLContents() {
				log.info("htLContents()");
				
				mv4 = htLServ.htLlist();
				
				return mv4;
			}
}

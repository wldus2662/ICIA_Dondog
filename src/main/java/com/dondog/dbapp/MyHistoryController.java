package com.dondog.dbapp;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.servlet.ModelAndView;


import com.dondog.dbapp.service.myHistoryService;

import lombok.extern.java.Log;

@Controller
@Log
public class MyHistoryController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyHistoryController.class);
	
	//서비스 객체 변수
	@Autowired
	private myHistoryService mhServ;
	
	//ModelAndView 객체
		private ModelAndView mv;
		
		
	@GetMapping("getHosList")
	public ModelAndView HosList() {
		log.info("getHosList()");
		
		mv = mhServ.getHosList();
				
		return mv;
	}

	@GetMapping("getCareList")
	public ModelAndView CareList() {
		log.info("getCareList()");
		
		mv = mhServ.getHosList();
				
		return mv;
	}
	
	@GetMapping("myHistory")
	public ModelAndView myHistory() {
		log.info("myHistory()");
		
		mv = mhServ.getHosList();
		
		return mv;
	}
	
}

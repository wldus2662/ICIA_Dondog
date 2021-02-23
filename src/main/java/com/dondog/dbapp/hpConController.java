package com.dondog.dbapp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.service.hpConService;

import lombok.extern.java.Log;


@Controller
@Log
public class hpConController {

	private static final Logger logger = LoggerFactory.getLogger(hpConController.class);
	
	//서비스 객체 변수
		@Autowired
		private hpConService hcServ;
		
		//ModelAndView 객체
			private ModelAndView mv1;
	
			
			//예약 내역 상세보기
			@GetMapping("hpContents")
			public ModelAndView hpContents(String hp_num) {
				log.info("hpContents()");
				mv1 = hcServ.hpContents(hp_num);
				return mv1;
			}
			@GetMapping("hpChCon")
			public String hpChCon() {
				logger.info("hpChCon()");
				
				return "hpChCon";
			}
			
			//첨부파일 다운로드 처리
			@GetMapping("download")
			public void fileDownLoad(String f_sysname, HttpServletRequest request,HttpServletResponse response) {
				log.info("fileDownLoad() file: " + f_sysname);
				
				hcServ.fileDown(f_sysname, request, response);
			}
}

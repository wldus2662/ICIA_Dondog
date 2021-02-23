package com.dondog.dbapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.service.BeautyService;

import lombok.extern.java.Log;

@Controller
@Log
public class BeautyController {

	@Autowired
	BeautyService btServ;
	
	private ModelAndView mv;
	
	@GetMapping("btReservation")
	public ModelAndView btReservation(String h_id) {
		log.info("btReservation() - h_id: " + h_id);
		
		mv = btServ.getHost2(h_id);
		
		return mv;
	}
}

package com.dondog.dbapp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dto.ReplyDto;
import com.dondog.dbapp.service.ServCenterService;

import lombok.extern.java.Log;

@Controller
@Log
public class ServCenterController {
	@Autowired
	private ServCenterService ScServ;
	
	
	private ModelAndView mv;
	
	
	@GetMapping("sCenterList")
	public ModelAndView sCenterList(Integer pageNum) {
		log.info("sCenterList");
		mv = ScServ.getscBoardList(pageNum);
		return mv;
	}
	
	@GetMapping("scCompWrite")
	public String scCompWrite() {
		log.info("scCompWrite()");
		
		return "scCompWrite";
	}
	
	@PostMapping("scBoardWrite")
	public String scBoardWrite(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		log.info("scBoardWrite()");
		
		String view = ScServ.scBoardInsert(multi, rttr);
		
		return view;
	}
	
	@GetMapping("scQueList")
	public ModelAndView scQueList(Integer pageNum) {
		log.info("scQueList()");
		mv = ScServ.getscBoardList(pageNum);
		return mv;
	}
	@GetMapping("scQueWrite")
	public String scQueWrite() {
		log.info("scQueWrite");
		return "scQueWrite";
	}
	@PostMapping("scQueWrite")
	public String scQueWrite(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		String view = ScServ.OneBoardInsert(multi, rttr);
		return view;
	}
	//scCompLook//////
	@GetMapping("scCompLook")
	public ModelAndView scCompLook(String bl_num) {
		log.info("scCompLook() - blnum" + bl_num);
		mv = ScServ.scCompLook(bl_num);
		return mv;
	}
	
	@GetMapping("updateBlFrm")
	public ModelAndView updateFrm(String bl_num, RedirectAttributes rttr) {
		log.info("updateBlFrm() - bl_num: " + bl_num);
		
		mv = ScServ.updateBlFrm(bl_num, rttr);
		
		return mv;
	}
	@PostMapping("scCompUpdate")
	public String scCompUpdate(MultipartHttpServletRequest multi,RedirectAttributes rttr) {
		String view = ScServ.scCompUpdate(multi, rttr);
		
		return view;
	}
	
	@GetMapping("scdelete")
	public String scCompDelete(String bl_num, RedirectAttributes rttr) {
		log.info("scCompDelete() - bl_num: " + bl_num);
		
		String view = ScServ.scCompDelete(bl_num, rttr);
		
		return view;
	}
	
	@PostMapping(value = "ScReplyIns",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, List<ReplyDto>> 
				ScReplyInsert(ReplyDto reply){
		Map<String, List<ReplyDto>> rMap = 
				ScServ.ScReplyInsert(reply);
		
		return rMap;
	}
	
	
}

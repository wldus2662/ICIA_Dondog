package com.dondog.dbapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dto.HostMemberDto;
import com.dondog.dbapp.service.HospitalService;
import com.dondog.dbapp.service.HostBoardService;
import com.dondog.dbapp.service.HostMemberService;

import lombok.extern.java.Log;

@Controller
@Log
public class HospitalController {
	
	@Autowired
	HospitalService hpServ;
	@Autowired
	HostMemberService hmServ;
	@Autowired
	HostBoardService hServ;
	
	private ModelAndView mv;
	
	@PostMapping("resHpwrite")
	public String resHpwrite(MultipartHttpServletRequest multi, 
			RedirectAttributes rttr) {	
		log.info("resHpwrite()");
		
		String view =hpServ.resHpwrite(multi, rttr);
		
		return view;
	}
	@GetMapping("resHp")
	public ModelAndView resHp(String h_id) {
		log.info("resHp() - h_id: " + h_id);
		
		mv = hpServ.getHost(h_id);

		return mv;
	}
	
	@GetMapping("Hospital_List")
	public ModelAndView HptalList(Integer pageNum) {
		log.info("HptalList()");
		mv = hServ.gethpBoardList(pageNum);
		return mv;		
	}
	
	@GetMapping("HosPSres")
	public ModelAndView HosPSres(String hp_num) {
		log.info("HosPSres - hp_num" + hp_num);
		mv = hpServ.getHosPSres(hp_num);
		return mv;
	}
	
	@PostMapping("writeHPQuest")
	public String writeHPQuest(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		log.info("writeQuest()");
		String view =hpServ.writeHPQuest(multi, rttr);
		
		return view;
	}
	
}

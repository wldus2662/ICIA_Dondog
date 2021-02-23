package com.dondog.dbapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.HostMemberDao;
import com.dondog.dbapp.dao.MemberDao;
import com.dondog.dbapp.dto.HostMemberDto;

import lombok.extern.java.Log;

@Service
@Log
public class BeautyService {

	@Autowired
	HostMemberDao hostDao;
	

	private ModelAndView mv;
	
	
	public ModelAndView getHost2(String h_id) {
		mv = new ModelAndView();
		HostMemberDto host = hostDao.getHostInfo(h_id);
		
		mv.addObject("hBoard",host);
		mv.setViewName("resBt");		
		return mv;
	}
}

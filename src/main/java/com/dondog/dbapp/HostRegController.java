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

import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.service.HostRegService;

import lombok.extern.java.Log;

@Controller
@Log
public class HostRegController {
	@Autowired
	private HostRegService hServ;
	
	//ModelAndView 객체
	private ModelAndView mv;
	
	//등록한 업체 리스트 보기
	@GetMapping("hostRegNow")
	public ModelAndView hostRegNow() {
		log.info("hostRegNow()");
		mv = hServ.gethList();

		return mv;
	}
	
	//내 업체 정보 보기
	@GetMapping("hostInfo")
	public ModelAndView hostInfo() {
		log.info("hostInfo()");
		mv = hServ.hContents();
		return mv;
	}
	
	//내 업체 정보 수정 페이지로 이동 & 수정할 정보 불러오기
	@GetMapping("hostInfo_upFrm")
		public ModelAndView hostInfo_upFrm(String h_id, RedirectAttributes rttr) {
		log.info("hostInfo_upFrm()-h_id : " +h_id);
		mv = hServ.hostInfo_upFrm(h_id, rttr);
		
		return mv;
	}
	//내 업체 정보 수정 처리
	@PostMapping("hostInfoUpdate")
	public String hostInfoUpdate(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		String view= hServ.hostInfoUpdate(multi, rttr);

		return view;
	}
	//개별 파일 삭제
	@PostMapping(value = "delhfile",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, List<FileDto>> delFile(String sysname, String bh_num) {
		Map<String, List<FileDto>> rMap = null;

		rMap = hServ.fileDelete(sysname, bh_num);

		return rMap;
	}
}

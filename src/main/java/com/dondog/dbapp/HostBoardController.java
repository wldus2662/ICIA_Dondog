package com.dondog.dbapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dto.HostMemberDto;
import com.dondog.dbapp.service.HostBoardService;
import com.dondog.dbapp.service.HostMemberService;

import lombok.extern.java.Log;

@Controller
@Log
public class HostBoardController {
	@Autowired
	private HostMemberService hostServ;
	
	@Autowired
	private HostBoardService bServ;
	
	private ModelAndView mv;
	
	@GetMapping("hMain")
	public String hMain() {
		log.info("hMain()");
		
		return "hMain";
	}
	
	@GetMapping("writeHostFrm")
	public String writeHostFrm() {
		log.info("writeHostFrm()");
		
		return "writeHostFrm";
	}
	
	@PostMapping("boardHostWrite")
	public String boardHostWrite(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		log.info("boardHostWrite()");
		
		String view = bServ.hBoardInsert(multi, rttr);
		
		return view;
	}
	
	@GetMapping("hostMain")
	public ModelAndView HBoardContents(String bhnum) {
		log.info("HBoardContents() - bhnum: " + bhnum);
		
		mv = bServ.getHContents(bhnum);
		
		return mv;
	}
	@GetMapping("ingHpReg")
	public ModelAndView hBoardList(Integer pageNum) {
		log.info("hBoardList()");
		mv = bServ.gethBoardList(pageNum);
		return mv;		
	}
	//HBupdateFrm
	@GetMapping("HBupdateFrm")
	public ModelAndView HBupdateFrm(String bh_num, RedirectAttributes rttr) {
		log.info("HBupdateFrm() - bh_num: " + bh_num);
		
		mv = bServ.HBupdateFrm(bh_num, rttr);
		
		return mv;
	}
	@PostMapping("HBupdate")
	public String HBupdate(MultipartHttpServletRequest multi,RedirectAttributes rttr) {
		String view = bServ.HBupdate(multi, rttr);
		
		return view;
	}
	
	//기본 정보 가져오기 
	@GetMapping("hmInfoData")
	public ModelAndView hmInfoData(String h_id) {
	log.info("hostInfo()-m_id: " +h_id);
	mv = hostServ.getHMInfo(h_id);
	return mv;
	}
	//내 정보 확인 페이지 이동
	@GetMapping("HMInfo")
	public String HMInfo() {
	log.info("HMInfo()");
	return "HMInfo";
	}
	@GetMapping("HMInfo_upFrm")
	public ModelAndView HMInfo_upFrm(String h_id, RedirectAttributes rttr) {
	log.info("HMInfo_upFrm()-h_id : " +h_id);
	mv = hostServ.HMInfo_updateFrm(h_id, rttr);
	return mv;
	}
	@PostMapping("HMInfoUpdate")
	public String HMInfoUpdate(HostMemberDto host,RedirectAttributes rttr) {
		String view= hostServ.HMInfoUpdate(host, rttr);
		return view;
	}
	@GetMapping("HBdelete")
	public String scCompDelete(String bh_num, RedirectAttributes rttr) {
		log.info("scCompDelete() - bh_num: " + bh_num);
		
		String view = bServ.HBdelete(bh_num, rttr);
		
		return view;
	}
	
	//미용업체 등록리스트
	@GetMapping("hostMypage")
	public ModelAndView hostMypage() {
		log.info("hostMypage()");

		mv = bServ.gethostList();

		return mv;
	}

	//미용소 훈련소 업체 등록 페이지 이동
	@GetMapping("hostregForm")
	public String hostregForm() {
		log.info("hostregForm()");
		
		return "hostregForm"; 
	}
	
	//업체 등록
	@PostMapping("hostregFrm")
	public String hostregFrm(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		log.info("hostregFrm()");

		String view = bServ.hostregInsert(multi, rttr);

		return view;

	}
	
	//미용소 훈련소 업체 서비스등록 페이지 이동
	@GetMapping("hostService")
	public ModelAndView hostService(String bh_num) {
		log.info("hostService()");

		mv = new ModelAndView();

		mv.addObject("bh_num", bh_num);
		mv.setViewName("hostService");
		return mv;
	}
	
	//등록 상세내역 페이지
	@GetMapping("htcontents")
	public ModelAndView companyRegContents(String bh_num) {
		log.info("companyRegContents() - bh_num: " + bh_num);

		mv = bServ.getRegContents(bh_num);

		return mv;
	}
	
	//등록게시글 삭제
	@GetMapping("htdelete")
	public String hostRegDelete(String bh_num, RedirectAttributes rttr) {
		log.info("hostRegDelete() - bh_num: " + bh_num);

		String view = bServ.regDelete(bh_num, rttr);

		return view;
	}
	
	//미용검색 첫화면
	@GetMapping("beautySearch")
	public ModelAndView getbtList() {
		log.info("getbtList()");
		mv = bServ.getbeautyList();
		
		return mv;
	}

	//등록 상세내역 페이지
	@GetMapping("htcontents_bt")
	public ModelAndView companyRegContents2(String bh_num) {
		log.info("companyRegContents2() - bh_num: " + bh_num);

		mv = bServ.getRegContents2(bh_num);

		return mv;
	}
	
}//end

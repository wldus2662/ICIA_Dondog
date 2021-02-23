package com.dondog.dbapp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.ReplyDto;
import com.dondog.dbapp.service.BoardService;
import com.dondog.dbapp.service.HostBoardService;
import com.dondog.dbapp.service.ReviewService;

import lombok.extern.java.Log;

@Controller
@Log
public class BoardController {

	@Autowired
	private BoardService bServ;
	@Autowired
	private ReviewService rServ;
	
	private ModelAndView mv;
	
	@GetMapping("list")
	public ModelAndView boardList(Integer pageNum) {
		
		mv = bServ.getBoardList(pageNum);
		
		return mv;
	}
	
	@GetMapping("contents")
	public ModelAndView boardContents(String b_num) {
		
		mv = bServ.getContents(b_num);
		
		return mv;
	}
	
	@GetMapping("boardWrite")
	public String boardWrite() {
		
		log.info("boardWrite()");
		
		return "boardWrite";
	}
	
	@PostMapping("writeBoard")
	public String writeBoard(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		log.info("writeBoard()");
		String view = bServ.boardInsert(multi, rttr);
		
		return view;	
	}
	
	@PostMapping("likeBoard")
	public String likeBoard() {
		
		return null;
	}
	
	@GetMapping("hostcontents")
	public ModelAndView hostContents(String bh_num) {
		
		mv = bServ.getHost(bh_num);
		
		return mv;
	}
	
	//첨부파일 다운로드 처리
	@GetMapping("download2")
	public void fileDownLoad(String f_sysname, HttpServletRequest request, HttpServletResponse response) {
		
		log.info("fileDownLoad() file: " + f_sysname);
		
		bServ.fileDown(f_sysname, request, response);
	}
	
	@PostMapping(value = "replyIns", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, List<ReplyDto>> replyInsert(ReplyDto reply) {
		Map<String, List<ReplyDto>> rMap = bServ.replyInsert(reply);
		
		return rMap;
	}
	
	@PostMapping(value = "serviceInsert", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, String> serviceInsert(String s_contents, String s_price, String s_cnum) {
		
		boolean result = bServ.serviceInsert(s_contents, s_price, s_cnum);
		
		Map<String, String> rmap = new HashMap<String, String>();
		
		if(result == true) {
			rmap.put("result", "등록 성공");
		}
		else {
			rmap.put("result", "등록 실패");
		}
		
		return rmap;
	}
	
	@GetMapping("updateFrm")
	public ModelAndView updateFrm(String b_num, 
			RedirectAttributes rttr) {
		log.info("updateFrm() - bnum: " + b_num);
		
		mv = bServ.updateFrm(b_num, rttr);
		
		return mv;
	}
	
	@PostMapping("boardUpdate")
	public String boardUpdate(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		String view = bServ.boardUpdate(multi, rttr);
		
		return view;
	}
	
	@PostMapping(value = "delfile2",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, List<FileDto>> delFile(String f_sysname, String b_num) {
		
		Map<String, List<FileDto>> rMap = null;
		
		log.info("delfile sysname : " + f_sysname);
		
		rMap = bServ.fileDelete(f_sysname, b_num);
		
		return rMap;
	}
	
	@GetMapping("delete")
	public String boardDelete(String b_num, 
			RedirectAttributes rttr) {
		log.info("boardDelete() - b_num: " + b_num);
		
		String view = bServ.boardDelete(b_num, rttr);
		
		return view;
	}
	
	@GetMapping("writeReview")
	public String writeReview() {
		log.info("writeReview()");
		return "writeReview";
	}
	@GetMapping("reviewList")
	public ModelAndView reviewList(Integer pageNum) {
		log.info("reviewList()");
		
		mv = bServ.getReviewList(pageNum);

		return mv;
	}
	
	@PostMapping("reviewWrite")
	public String reviewWrite(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		log.info("reviewWrite()");
		String view = bServ.reviewInsert(multi, rttr);

		return view;
	}
	
	@GetMapping("comService")
	public ModelAndView comService(String bh_num) {
		log.info("comService - bh_num");
		mv = new ModelAndView();
		
		mv.addObject("bh_num", bh_num);
		mv.setViewName("comService");
		return mv;
	}
	
	@PostMapping("regFrm")
	public ModelAndView regFrm(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		mv = bServ.htReg(multi, rttr);
				
		return mv;
		
	}
	
	@GetMapping("hostregFrm")
	public String hostregFrm() {
		
		return "hostregFrm";
	}
	
	@GetMapping("petsgoSerch")
	public ModelAndView petsgoSerch(Integer pageNum) {
		
		mv = bServ.getCompList(pageNum);
		
		return mv;
	}
	
	@GetMapping("serviceContents")
	public ModelAndView hostContents2(String bh_num) {
		
		mv = bServ.getHost2(bh_num);
		
		return mv;
	}
	@GetMapping("viewSearch")
	public ModelAndView viewSearch(Integer pageNum) {
		
		mv = bServ.getManyview(pageNum);
		
		return mv;
	}
	@GetMapping("viewBoard")
	public ModelAndView viewBoard(Integer pageNum) {
		
		mv = bServ.getBoardview(pageNum);
		
		return mv;
	}
	@GetMapping("boardList")
	public ModelAndView timeList(Integer pageNum) {
		
		mv = bServ.getBoardList(pageNum);
		
		return mv;
	}
	@GetMapping("headBoard")
	public ModelAndView headBoard(Integer head, Integer pageNum) {
		
		mv = bServ.getHeadList(head, pageNum);
		
		return mv;	
	}
	@GetMapping("rvcontents")
	public ModelAndView rvcontents(String rv_num) {
		
		mv = bServ.rvcontents(rv_num);
		
		return mv;
	}
	
	@PostMapping(value = "replyIns2", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, List<ReplyDto>> replyInsert2(ReplyDto reply) {
		Map<String, List<ReplyDto>> rMap = bServ.replyInsert2(reply);
		
		return rMap;
	}
	
	@GetMapping("updateFrm2")
	public ModelAndView updateFrm2(String rv_num, RedirectAttributes rttr) {
		log.info("updateFrm2() - rv_num: " + rv_num);
		
		mv = bServ.updateFrm2(rv_num, rttr);
		
		return mv;
	}
	
	@PostMapping("reviewUpdate")
	public String reviewUpdate(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		String view = bServ.reviewUpdate(multi, rttr);
		
		return view;
	}
	
	@GetMapping("delete2")
	public String boardDelete2(String rv_num, RedirectAttributes rttr) {
		log.info("boardDelete2() - rv_num: " + rv_num);
		
		String view = bServ.boardDelete2(rv_num, rttr);
		
		return view;
	}
	
	@PostMapping(value = "delfile3",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, List<FileDto>> delFile3(String f_sysname, String rv_num) {
		
		Map<String, List<FileDto>> rMap = null;
		
		log.info("delfile3 sysname : " + f_sysname);
		
		rMap = bServ.fileDelete3(f_sysname, rv_num);
		
		return rMap;
	}
	
} //class fin

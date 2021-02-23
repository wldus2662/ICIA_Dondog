package com.dondog.dbapp.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.ServCenterDao;
import com.dondog.dbapp.dto.BlackListDto;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.ReplyDto;
import com.dondog.dbapp.util.Paging;

import lombok.extern.java.Log;

@Service
@Log
public class ServCenterService {
	
	@Autowired
	private ServCenterDao ScDao;
	
	private ModelAndView mv;
	
	@Autowired
	private HttpSession session;

	public ModelAndView getscBoardList(Integer pageNum) {
		log.info("getscBoardList - pageNum: " + pageNum);
		mv = new ModelAndView();
		
		int num = (pageNum == null) ? 1 : pageNum;
		
		List<BlackListDto> SCList = ScDao.getSCList(num);
		//String BLnum = SCList.get

			mv.addObject("SCList", SCList);
			mv.addObject("paging", getPaging(num));
			session.setAttribute("pageNum", num);
			mv.setViewName("sCenterList");
		return mv;
	}
	
	private String getPaging(int num) {
		//전체 글 개수 구하기(from DB)
		int maxNum = ScDao.getSCBoardCnt();
		int listCnt = 10;
		int pageCnt = 2;
		String listName = "SCList";
		
		Paging paging = new Paging(maxNum, num, listCnt,
				pageCnt, listName);
		
		String pagingHtml = paging.makePaging();
		
		return pagingHtml;
	}

	public String scBoardInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		log.info("scBoardInsert()");
		
		String view = null;
		
		String m_id =  multi.getParameter("m_id");
		String hid = multi.getParameter("h_id");
		String name = multi.getParameter("m_name2");
		String bl_title = multi.getParameter("btitle");
		String bl_contents = multi.getParameter("bcontents");
		
		bl_contents = bl_contents.trim();
		BlackListDto black = new BlackListDto();
		
		black.setM_id(m_id);
		black.setBl_name(name);
		black.setBl_title(bl_title);
		black.setBl_contents(bl_contents);
		
		try {
			ScDao.scBoardInsert(black);
			view = "redirect:sCenterList";
			rttr.addFlashAttribute("msg", "글 등록 성공");
			
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:scCompWrite";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}
		
		return view;
	}

	public String OneBoardInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		log.info("OneBoardInsert()");
		String view = null;
		
		String m_id = null;
		String h_id = null;
		String mid = multi.getParameter("m_id");
		String hid = multi.getParameter("h_id");
		String bl_title = multi.getParameter("bl_title");
		String bl_contents = multi.getParameter("bl_contents");
		//String check = multi.getParameter("fileCheck");
		bl_contents = bl_contents.trim();
		
		BlackListDto black = new BlackListDto();
		if(mid != null) {
			black.setM_id(m_id);
		}
		if(hid != null) {
			black.setH_id(h_id);
		}
		black.setBl_title(bl_title);
		black.setBl_contents(bl_contents);
		try {
			ScDao.OneBoardInsert(black);
			view = "redirect:scQueList";
			rttr.addFlashAttribute("msg", "글 등록 성공");
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:scQueWrite";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}
		
		return view;
	}

	public ModelAndView scCompLook(String bl_num) {
		mv = new ModelAndView();
		BlackListDto black = ScDao.getscComp(bl_num);
		List<ReplyDto> scrList = ScDao.getScReplyList(bl_num);
		mv.addObject("scBoard", black);
		mv.addObject("scrList", scrList);
		mv.setViewName("scCompLook");
		
		return mv;
	}

	public ModelAndView updateBlFrm(String bl_num, RedirectAttributes rttr) {
		mv = new ModelAndView();
		
		BlackListDto black = ScDao.getscComp(bl_num);
		
		MemberDto member = (MemberDto)session.getAttribute("mb");
		
		mv.addObject("scBoard", black);
		mv.setViewName("updateBlFrm");
		return mv;
	}

	public String scCompUpdate(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		
		String view = null;
		
		String bl_num = multi.getParameter("bl_num");
		String m_id =  multi.getParameter("m_id");
		String name = multi.getParameter("m_name2");
		String bl_title = multi.getParameter("btitle");
		String bl_contents = multi.getParameter("bcontents");
		
		log.info("scCompUpdate() t: " + bl_title + ", c: " + bl_contents);
		
		bl_contents = bl_contents.trim();
		BlackListDto black = new BlackListDto();
		
		black.setBl_num(bl_num);
		black.setM_id(m_id);
		black.setBl_name(name);
		black.setBl_title(bl_title);
		black.setBl_contents(bl_contents);
		
		try {
			ScDao.scCompUpdate(black);
			rttr.addFlashAttribute("msg", "글 수정 성공");
			
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msg", "글 수정 실패");
		}
		view = "redirect:scCompLook?bl_num=" + bl_num;
		return view;
	}

	public String scCompDelete(String bl_num, RedirectAttributes rttr) {
		log.info("scCompDelete() - bl_num: " + bl_num);
		
		String view = null;
		
		try {
			//댓글 삭제
			//bDao.replyDelete(bl_num);
			//게시글 삭제
			ScDao.scCompDelete(bl_num);
			
			view = "redirect:sCenterList";
			rttr.addFlashAttribute("msg", "삭제 성공");
			
		} catch (Exception e) {
			//e.printStackTrace();
			view = "redirect:scCompLook?bl_num=" + bl_num;
			rttr.addFlashAttribute("msg", "삭제 실패");
		}
		
		return view;
	}

	public Map<String, List<ReplyDto>> ScReplyInsert(ReplyDto reply) {
		Map<String, List<ReplyDto>> rMap = null;
		try {
			//댓글을 DB에 입력
			ScDao.ScReplyInsert(reply);
			
			//댓글 목록을 다시 검색
			List<ReplyDto> scrList = ScDao.getScReplyList(reply.getBl_num());
			rMap = new HashMap<String, List<ReplyDto>>();
			rMap.put("scrList", scrList);
		}catch (Exception e) {
			//e.printStackTrace();
			rMap = null;
		}
		
		return rMap;
	}

}

package com.dondog.dbapp.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.ReviewDao;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.ReviewDto;

import lombok.extern.java.Log;

@Service
@Log
public class ReviewService {

	@Autowired
	private ReviewDao rDao;
	private ModelAndView mv;

	@Autowired
	private HttpSession session;

	// 리뷰 작성 메소드
	@Transactional
	public String reviewInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {

		String view = null;
		
		String id = multi.getParameter("rv_name");
		String contents = multi.getParameter("rv_contents");
		String snum = multi.getParameter("s_num");
		
		contents = contents.trim();

		ReviewDto review = new ReviewDto();

		review.setRv_contents(contents);
		review.setRv_name(id);
		review.setS_num(snum);

		try {
			rDao.reviewInsert(review);

			MemberDto member = (MemberDto) session.getAttribute("mb");

			view = "redirect:./";
			rttr.addFlashAttribute("msg", "글 등록 성공");
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:writeReview";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}
		return view;
	}

	// 리뷰 목록 가져오는 메소드
	public ModelAndView getReviewList(Integer pageNum) {
		mv = new ModelAndView();

		int num = (pageNum == null) ? 1 : pageNum;

		List<ReviewDto> rList = rDao.getList(num);

		// DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("rList", rList);

		// 세션에 페이지 번호 저장
		session.setAttribute("pageNum", num);

		mv.setViewName("reviewList");
		return mv;
	}
}

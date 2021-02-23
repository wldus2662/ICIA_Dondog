package com.dondog.dbapp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.CashDao;
import com.dondog.dbapp.dto.CashDto;

import lombok.extern.java.Log;


@Service
@Log
public class CashService {
	@Autowired
	private CashDao cDao;
	
	private ModelAndView mv;
	//결제 목록 가져오는 메소드
	public ModelAndView getCashList(String m_id) {
		log.info("getCashList()- m_id : " +m_id);
		mv = new ModelAndView();
		
		List<CashDto> cList = cDao.getcList(m_id);
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("cList", cList);	

		mv.setViewName("cashList");

		return mv;
	}//method end
	
	//결제 상세내역 가져오는 메소드
	public ModelAndView cashContents(String c_num) {
		log.info("cashContents()- c_num : " +c_num);
		mv = new ModelAndView();
			
		CashDto cash = cDao.cashContents(c_num);
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("c", cash);	

		mv.setViewName("cashContents");

		return mv;
	}

	//결제 취소 처리
	public String cashCancle(String c_num,RedirectAttributes rttr) {
		log.info("cashCancle()- c_num : " +c_num);
		String view=null;
		
		try {
			//상태를 환불처리로 업데이트
			cDao.statUpdate(c_num);
			rttr.addFlashAttribute("msg", "결제가 취소되었습니다.");
		} catch (Exception e) {
			//e.printStackTrace();
			rttr.addFlashAttribute("msg", "취소 실패");
		}
		
		view = "redirect:cashContents?c_num="+c_num;
		
		return view;
	}
	//결제 대기 목록 가져오기(관리자)
	public ModelAndView getCashAll() {
		log.info("getCashAll() ");
		mv = new ModelAndView();
		
		List<CashDto> cList = cDao.cashAll();
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("cList", cList);	

		mv.setViewName("cashAdmin");

		return mv;
	}//method end
	
	//결제 상세내역 가져오는 메소드(관리자)
	public ModelAndView cashAdContents(String c_num) {
		log.info("cashAdContents()- c_num : " +c_num);
		mv = new ModelAndView();
			
		CashDto cash = cDao.cashContents(c_num);
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("c", cash);	

		mv.setViewName("cashAdContents");

		return mv;
	}
	//결제 승인 처리 (관리자)
	public String cashSuccess(String c_num,RedirectAttributes rttr) {
		log.info("cashSuccess()- c_num : " +c_num);
		String view = null;
		
		try {
			//상태를 환불처리로 업데이트
			cDao.statSuccess(c_num);
			rttr.addFlashAttribute("msg", "결제가 승인되었습니다.");
		} catch (Exception e) {
			//e.printStackTrace();
			rttr.addFlashAttribute("msg", "승인 실패");
		}
		
		view = "redirect:cashAdContents?c_num="+c_num;
		
		return view;
	}
}//class end

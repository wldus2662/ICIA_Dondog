package com.dondog.dbapp.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.MemberDao;
import com.dondog.dbapp.dao.myHistoryDao;
import com.dondog.dbapp.dto.CareReservationDto;
import com.dondog.dbapp.dto.CashDto;
import com.dondog.dbapp.dto.MemberDto;

import lombok.extern.java.Log;

@Service
@Log
public class mgMemberService {

	//DAO 객체
			@Autowired
			private myHistoryDao mgmDao;
			@Autowired
			private MemberDao mbdDao;
			
			//세션 객체
			@Autowired
			private HttpSession session;
			
			//ModelAndView
			private ModelAndView mv;
			
			public ModelAndView mgMemberList() {
				
				log.info("mgMemberList");
				
				mv = new ModelAndView();
				
				MemberDto member = (MemberDto)session.getAttribute("mb");
				log.info(member.getM_id());
				
				//멤버 목록
				List<MemberDto> mgMemberList = mgmDao.mgMemberList(member.getM_id());
				mv.addObject("mList", mgMemberList);
	
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.setViewName("mgMember");
						
				return mv;
			}
			//회원 상세내역 가져오는 메소드
			public ModelAndView mgMemContents(String m_id) {
				
				log.info("mgMemContents()- m_id : " + m_id);
				mv = new ModelAndView();
					
				MemberDto memdel = mbdDao.getMemberInfo(m_id);
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.addObject("m", memdel);	

				mv.setViewName("mgMemContents");

				return mv;
			}
			
			//회원 레벨 9로 변경 처리
			public String blackdel(String m_id,RedirectAttributes rttr) {
				log.info("blackdel()- m_id : " +m_id);
				String view=null;
				
				try {
					//상태를 레벨9로 업데이트
					mbdDao.blackdel(m_id);
					rttr.addFlashAttribute("msg", "강제탈퇴 처리되었습니다.");
				} catch (Exception e) {
					//e.printStackTrace();
					rttr.addFlashAttribute("msg", "강제탈퇴 실패");
				}
				
				view = "redirect:mgMemContents?m_id="+m_id;
				
				return view;
				
			}
			
			//회원 레벨 1로 변경 처리
			public String mgSignup(String m_id,RedirectAttributes rttr) {
				log.info("mgSignup()- m_id : " +m_id);
				String view=null;
				
				try {
					//상태를 레벨1로 업데이트
					mbdDao.mgSignup(m_id);
					rttr.addFlashAttribute("msg", "관리자 계정으로 승인되었습니다.");
				} catch (Exception e) {
					//e.printStackTrace();
					rttr.addFlashAttribute("msg", "관리자 승인 실패");
				}
				
				view = "redirect:mgMemContents?m_id="+m_id;
				
				return view;
				
			}
}

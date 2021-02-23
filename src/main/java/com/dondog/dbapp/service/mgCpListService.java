package com.dondog.dbapp.service;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.mgCpListDao;

import com.dondog.dbapp.dto.HostBoardDto;
import com.dondog.dbapp.dto.HostMemberDto;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.PetsitterFormDto;

import lombok.extern.java.Log;

@Service
@Log
public class mgCpListService {
		//DAO 객체
		@Autowired
		private mgCpListDao mcDao;
		
		//세션 객체
		@Autowired
		private HttpSession session;
		
		//ModelAndView
		private ModelAndView mv;
		
			//업체 정보 승인 대기 목록 가져오기
			public ModelAndView mgCApproList() {
				log.info("mgCApproList() ");
				mv = new ModelAndView();
				
				List<HostBoardDto> hbList = mcDao.mgCApproList();
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.addObject("hbList", hbList);	

				mv.setViewName("mgCpAdmin");

				return mv;
			}
			
			//업체 정보 상세내역 가져오는 메소드
			public ModelAndView mgCpLook(String bh_num) {
				log.info("mgCpLook()- bh_num : " +bh_num);
				mv = new ModelAndView();
					
				HostBoardDto bh = mcDao.mgCpLook(bh_num);
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.addObject("bh", bh);	

				mv.setViewName("mgCpLook");

				return mv;
			}
			
			//업제정보 등록 승인 처리
			public String mgCAppro(String bh_num,RedirectAttributes rttr) {
				log.info("mgCAppro()- bh_num : " +bh_num);
				String view = null;
				
				try {
					
					mcDao.mgCAppro(bh_num);
					rttr.addFlashAttribute("msg", "업체 정보 등록이 승인되었습니다.");
				} catch (Exception e) {
					//e.printStackTrace();
					rttr.addFlashAttribute("msg", "승인 실패");
				}
				
				view = "redirect:mgCpLook?bh_num="+bh_num;
				
				return view;
			}
		
			//업제정보 등록 거절 처리
			public String mgCAppro1(String bh_num,RedirectAttributes rttr) {
				log.info("mgCAppro1()- bh_num : " +bh_num);
				String view = null;
				
				try {
					//상태를 거절로 업데이트
					mcDao.mgCAppro1(bh_num);
					rttr.addFlashAttribute("msg", "업체 정보 등록이 거절되었습니다.");
				} catch (Exception e) {
					//e.printStackTrace();
					rttr.addFlashAttribute("msg", "거절 실패");
				}
				
				view = "redirect:mgCpLook?bh_num="+bh_num;
				
				return view;
			}
			
			//업체 등록 내용 지우기
			public String mgHbDel(String bh_num, RedirectAttributes rttr) {
				log.info("mgHbDel()- bh_num : " +bh_num);
				String view=null;
				try {
					//상태를 레벨9로 업데이트
					mcDao.mgHbDel(bh_num);
					rttr.addFlashAttribute("msg", "업체 등록 내역이 삭제되었습니다.");
				} catch (Exception e) {
					//e.printStackTrace();
					rttr.addFlashAttribute("msg", "삭제 실패");
				}
				
				view = "redirect:mgCpLook?bh_num="+bh_num; 
				
				return view;
			}
			//업체 목록 가져오기
			public ModelAndView mgCpList() {
				log.info("mgCpList() ");
				mv = new ModelAndView();
				
				List<HostBoardDto> mgcList = mcDao.mgCpList();
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.addObject("mgcList", mgcList);	

				mv.setViewName("mgCpList");

				return mv;
			}
			
			//업체 상세내역 가져오는 메소드
			public ModelAndView mgCpLook2(String h_id) {
				
				log.info("mgCpLook2()- h_id : " + h_id);
				mv = new ModelAndView();
					
				HostMemberDto hostmem = mcDao.mgCpLook2(h_id);
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.addObject("hm", hostmem);	

				mv.setViewName("mgCpLook2");

				return mv;
			}
			
			//업체 강제 탈퇴
			public String mgCpDel(String h_id, RedirectAttributes rttr) {
				log.info("mgCpDel()- h_id : " +h_id);
				String view=null;
				try {
					//상태를 레벨9로 업데이트
					mcDao.mgCpDel(h_id);
					rttr.addFlashAttribute("msg", "강제탈퇴 처리되었습니다. 업체정보 등록에서 업체 내역을 반드시 삭제해주세요.");
				} catch (Exception e) {
					//e.printStackTrace();
					rttr.addFlashAttribute("msg", "강제탈퇴 실패");
				}
				
				view = "redirect:mgCpLook2?h_id="+h_id; 
				
				return view;
			}
			
			//펫시터 신청 목록 가져오기
			public ModelAndView mgPApproList() {
				log.info("mgPApproList() ");
				mv = new ModelAndView();
				
				List<PetsitterFormDto> paList = mcDao.mgPApproList();
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.addObject("paList", paList);	

				mv.setViewName("mgPApproList");

				return mv;
			}
			
			//펫시터 상세 정보 가져오기
			public ModelAndView mgPApproList2(String up_num) {
				log.info("mgPApproList2()- up_num : " +up_num);
				mv = new ModelAndView();
					
				PetsitterFormDto PaList2 = mcDao.mgPApproList2(up_num);
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.addObject("PaList2", PaList2);	

				mv.setViewName("mgPApproList2");

				return mv;
			}
			//펫시터 신청승인
			public String sittera(String up_num, RedirectAttributes rttr) {
				log.info("sittera()- up_num : " +up_num);
				String view = null;
				
				try {
					
					mcDao.sittera(up_num);
					rttr.addFlashAttribute("msg", "펫시터 신청이 승인되었습니다. 반드시 멤버 등급을 변경해주세요.");
				} catch (Exception e) {
					//e.printStackTrace();
					rttr.addFlashAttribute("msg", "승인 실패");
				}
				
				view = "redirect:mgPApproList2?up_num="+up_num;
				
				return view;
			}
			//펫시터 신청 거절
			public String sitterd(String up_num, RedirectAttributes rttr) {
				log.info("sitterd()- up_num : " +up_num);
				String view = null;
				
				try {
					
					mcDao.sitterd(up_num);
					rttr.addFlashAttribute("msg", "펫시터 신청이 거절되었습니다.");
				} catch (Exception e) {
					//e.printStackTrace();
					rttr.addFlashAttribute("msg", "거절 실패");
				}
				
				view = "redirect:mgPApproList2?up_num="+up_num;
				
				return view;
			}

			
			//펫시터 등급 바꿔줄 목록 가져오기
			public ModelAndView sitterupList() {
				log.info("sitterupList() ");
				mv = new ModelAndView();
				
				List<MemberDto> suList = mcDao.sitterupList();
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.addObject("suList", suList);	

				mv.setViewName("sitterupList");

				return mv;
			}
			
			//펫시터 등급 바꿔줄 상세정보 가져오기
			public ModelAndView sitterupList2(String m_id) {
				log.info("sitterupList2()- m_id : " +m_id);
				mv = new ModelAndView();
					
				MemberDto suList2 = mcDao.sitterupList2(m_id);
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv.addObject("suList2", suList2);	

				mv.setViewName("sitterupList2");

				return mv;
			}
			//일반 -> 비전문가펫시터 등업
			public String Bsitterup(String m_id, RedirectAttributes rttr) {
				log.info("Bsitterup()- m_id : " +m_id);
				String view = null;
				
				try {
					
					mcDao.Bsitterup(m_id);
					rttr.addFlashAttribute("msg", "비전문가 펫시터로 등업되었습니다.");
				} catch (Exception e) {
					//e.printStackTrace();
					rttr.addFlashAttribute("msg", "등업 실패");
				}
				
				view = "redirect:sitterupList2?m_id="+m_id;
				
				return view;
			}

			public String Asitterup(String m_id, RedirectAttributes rttr) {
				log.info("Asitterup()- m_id : " +m_id);
				String view = null;
				
				try {
					
					mcDao.Asitterup(m_id);
					rttr.addFlashAttribute("msg", "전문 펫시터로 등업되었습니다.");
				} catch (Exception e) {
					//e.printStackTrace();
					rttr.addFlashAttribute("msg", "등업 실패");
				}
				
				view = "redirect:sitterupList2?m_id="+m_id;
				
				return view;
			}
		
			
			
			
}//class end

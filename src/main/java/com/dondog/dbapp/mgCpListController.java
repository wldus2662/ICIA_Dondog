package com.dondog.dbapp;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.service.mgCpListService;

import lombok.extern.java.Log;

@Controller
@Log
public class mgCpListController {
	
	//서비스 객체 변수
	@Autowired
	private mgCpListService mcServ;
	@Autowired
	private HttpSession session;
	
	//ModelAndView 객체
	private ModelAndView mv;
		
	//업체등록 관리 페이지 이동 & 미등록 업체의 신청내역 가져오기
		@GetMapping("mgCApproList")
		public ModelAndView mgCApproList() {
			log.info("mgCApproList()");

			mv = mcServ.mgCApproList();
			return mv;
		}
		
		//업체등록 상세 내역 보기
		@GetMapping("mgCpLook")
		public ModelAndView mgCpLook(String bh_num) {
			log.info("mgCpLook()-bh_num : " +bh_num);
			mv = mcServ.mgCpLook(bh_num);
			return mv;
		}	
		//등록 승인 처리
		@GetMapping("mgCAppro")
		public String mgCAppro(String bh_num,
				RedirectAttributes rttr) {
				log.info("mgCAppro()-bh_num : " + bh_num);
				String view= mcServ.mgCAppro(bh_num, rttr);
			
				return view;
		}	
		//등록 거절 처리
				@GetMapping("mgCAppro1")
				public String mgCAppro1(String bh_num,
						RedirectAttributes rttr) {
						log.info("mgCAppro1()-bh_num : " + bh_num);
						String view= mcServ.mgCAppro1(bh_num, rttr);
					
						return view;
				}
			
		//업체 등록 내역 삭제 처리
				@GetMapping("mgHbDel")
				public String mgHbDel(String bh_num,
						RedirectAttributes rttr) {
						log.info("mgHbDel()-bh_num : " + bh_num);
						String view= mcServ.mgHbDel(bh_num, rttr);
					
						return view;
				}		
				
		//업체 관리 페이지 이동 & 업체 내역 가져오기
				@GetMapping("mgCpList")
				public ModelAndView mgCpList() {
					log.info("mgCpList()");

					mv = mcServ.mgCpList();
					return mv;
				}	
				
		//회원 상세 내역보기
				@GetMapping("mgCpLook2")
				public ModelAndView mgCpLook2(String h_id) {
					log.info("mgCpLook2()-h_id : " +h_id);
					mv = mcServ.mgCpLook2(h_id);
					return mv;
				}				
				
		//업체 레벨 9로 바꾸기 (업체강제탈퇴)
				@GetMapping("mgCpDel")
				public String mgCpDel(String h_id,
					RedirectAttributes rttr) {
					log.info("mgCpDel()-m_id : " +h_id);
					String view= mcServ.mgCpDel(h_id, rttr);
				
					return view;
				}
				
				//미승인 펫시터 정보 페이지 이동 & 미승인 펫시터의 신청내역 가져오기
				@GetMapping("mgPApproList")
				public ModelAndView mgPApproList() {
					log.info("mgPApproList()");

					mv = mcServ.mgPApproList();
					return mv;
				}
				
				//펫시터 상세 내역 보기
				@GetMapping("mgPApproList2")
				public ModelAndView mgPApproList2(String up_num) {
					log.info("mgPApproList2()-up_num : " +up_num);
					mv = mcServ.mgPApproList2(up_num);
					return mv;
				}
				
				//승인 처리
				@GetMapping("sittera")
				public String sittera(String up_num,
						RedirectAttributes rttr) {
						log.info("sittera()-up_num : " + up_num);
						String view= mcServ.sittera(up_num, rttr);
					
						return view;
				}	
				
				//거절 처리
				@GetMapping("sitterd")
				public String sitterd(String up_num,
						RedirectAttributes rttr) {
						log.info("sitterd()-up_num : " + up_num);
						String view= mcServ.sitterd(up_num, rttr);
					
						return view;
				}
				
				//펫시터 등급 변경 페이지 이동 & 펫시터 등업할 내역 가져오기
				@GetMapping("sitterupList")
				public ModelAndView sitterupList() {
					log.info("sitterupList()");

					mv = mcServ.sitterupList();
					return mv;
				}
				
				//펫시터 등급 변경할 멤버 상세 내역 보기
				@GetMapping("sitterupList2")
				public ModelAndView sitterupList2(String m_id) {
					log.info("sitterupList2()-m_id : " +m_id);
					mv = mcServ.sitterupList2(m_id);
					return mv;
				}
				
				
				//일반-> 비전문가 펫시터로 승급 처리
				@GetMapping("Bsitterup")
				public String Bsitterup(String m_id,
						RedirectAttributes rttr) {
						log.info("Bsitterup()-m_id : " + m_id);
						String view= mcServ.Bsitterup(m_id, rttr);
					
						return view;
				}
				
				
				//비전문가-> 전문가 펫시터로 승급 처리
				@GetMapping("Asitterup")
				public String Asitterup(String m_id,
						RedirectAttributes rttr) {
						log.info("Asitterup()-m_id : " + m_id);
						String view= mcServ.Asitterup(m_id, rttr);
					
						return view;
				}
}

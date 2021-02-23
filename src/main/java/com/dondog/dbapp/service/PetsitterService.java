package com.dondog.dbapp.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.MemberDao;
import com.dondog.dbapp.dao.PetsitterDao;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.PetDto;
import com.dondog.dbapp.dto.PetsitterFormDto;
import com.dondog.dbapp.dto.PetsitterQ_cancel;
import com.dondog.dbapp.dto.PetsitterQuestion;
import com.dondog.dbapp.dto.PetsitterQuestlistDto;
import com.dondog.dbapp.dto.ResPetsitterDto;
import com.dondog.dbapp.dto.petsitter_listDto;
import com.dondog.dbapp.dto.quest_listDto;
import com.dondog.dbapp.util.Paging;

import lombok.extern.java.Log;

@Service
@Log
public class PetsitterService {
	//DAO 객체
	@Autowired
	private MemberDao mDao;
	
	@Autowired
	private PetsitterDao pDao;
	
	//세션 객체
	@Autowired
	private HttpSession session;
	
	//ModelAndView
	private ModelAndView mv;
	
	
	public String loginProc(MemberDto member,
			RedirectAttributes rttr) {
		String view = null;
		
		//DB에서 암호화된 비밀번호 구하기
		//String encPwd = mDao.getEncPwd(member.getM_id());
		String encPwd = mDao.getEncPwd(member.getM_id()); 
	log.info(encPwd);
	log.info(member.getM_pass());
		//암호화된 비밀번호와 입력한 비밀번호의 비교 처리를 위한
		//인코더 생성
		//BCryptPasswordEncoder pwdEncode = 
		//		new BCryptPasswordEncoder();
		
		if(encPwd != null) {
			//아이디 있음.
			//if(pwdEncode.matches(member.getM_pass(), encPwd)) {
			if(member.getM_pass().equals(encPwd)) {
				//암호화된 비밀번호와 입력한 비밀번호가 같으면 true
				//틀리면 false를 반환하는 메소드 - matches
				
				log.info("확인");
				
				//화면에 출력할 사용자 정보 가져오기
				member = mDao.getMemberInfo(member.getM_id());
				session.setAttribute("mb", member);
				
				if(member.getM_level() == 8)
				{
					view = "redirect:loginFrm";
					rttr.addFlashAttribute("msg", "탈퇴한 회원입니다.");
				}else if(member.getM_level() == 9)
				{
					view = "redirect:loginFrm";
					rttr.addFlashAttribute("msg", "강제퇴장된 회원입니다.");
				}
				else
				{
					view = "redirect:main";
				}
	
			}
			else {
				//비밀번호 틀린 경우.
				view = "redirect:loginFrm";
				rttr.addFlashAttribute("msg", "비밀번호 오류");
			}
		}
		else {
			//아이디 없음.
			view = "redirect:loginFrm";
			rttr.addFlashAttribute("msg", "아이디 없음");
		}
		
		return view;
	}
	
	
	
	public String logout() {
		session.invalidate();
		
		return "home";
	}


	@Transactional
	public String QuestInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		// TODO Auto-generated method stub
		
		
		log.info("QuestInsert()");
		
		String view = null;
		
		String m_id = multi.getParameter("m_id");
		String m_id2 = multi.getParameter("m_id2");
		String p_pid = multi.getParameter("p_pid");
		String hp_num= multi.getParameter("hp_num");
		String ca_num = multi.getParameter("ca_num");
		String rsp_in = multi.getParameter("from");
		String rsp_out = multi.getParameter("to");
		String rsp_contents = multi.getParameter("contents");
		String rsp_etc = multi.getParameter("rsp_etc");
		String rsp_lic= multi.getParameter("licens");
		String rsp_cond1 = multi.getParameter("patient");
		String rsp_cond2 = multi.getParameter("pickup_suc");
		String rsp_cond3 = multi.getParameter("no_animal");
		String rsp_cond4= multi.getParameter("old");
		String rsp_cond5 = multi.getParameter("notting");
		String rsp_pick = multi.getParameter("pickup_how");
		
		//textarea는 입력한 문자열 앞뒤로 공백이 발생
		//문자열 앞뒤 공백 제거
		rsp_etc= rsp_etc.trim();
		ResPetsitterDto respet =new ResPetsitterDto();
		respet.setM_id(m_id);
		respet.setM_id2(m_id2);
		respet.setP_pid(p_pid);
		respet.setHp_num(hp_num);
		respet.setCa_num(ca_num);
		respet.setRsp_in(rsp_in);
		respet.setRsp_out(rsp_out);
		respet.setRsp_contents(rsp_contents);
		respet.setRsp_etc(rsp_etc);
		respet.setRsp_lic(rsp_lic);
		respet.setRsp_cond1(rsp_cond1);
		respet.setRsp_cond2(rsp_cond2);
		respet.setRsp_cond3(rsp_cond3);
		respet.setRsp_cond4(rsp_cond4);
		respet.setRsp_cond5(rsp_cond5);
		respet.setRsp_pick(rsp_pick);
		
		
		try {
			
			pDao.petsitter_quest_Insert(respet);
			
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "등록성공");
		
			log.info("확인");
		
		}
		catch(Exception e)
		{
			e.printStackTrace();
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}
		
		return view;
	}
	
	public ModelAndView getpetList() {
		
		log.info("getpetList()");
		
		mv = new ModelAndView();
				
		MemberDto member = (MemberDto)session.getAttribute("mb");
		System.out.println(member.getM_id());
		List<PetDto> petlist = pDao.getPetInfo(member.getM_id());
		mv.addObject("pList", petlist);
		
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.setViewName("pet_list_popup");
		
		return mv;
	}//method en



	public ModelAndView getquestionList() {
		// TODO Auto-generated method stub
		
		log.info("getpetList()");
		
		mv = new ModelAndView();
		
		List<PetsitterQuestion> pet_quest_list = pDao.getpet_question();
		
		log.info(pet_quest_list.get(1).toString());
		log.info(pet_quest_list.get(2).toString());
		
		mv.addObject("pqList", pet_quest_list);
		
		mv.setViewName("pet_sitter_apply");
		
		return mv;
	}
	
	@Transactional
	public String petsitterInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		// TODO Auto-generated method stub
		
		
		log.info("QuestInsert()");
		
		String view = null;
		
		String m_id = multi.getParameter("m_id");
		String up_myself = multi.getParameter("up_contents");
		String up_title = multi.getParameter("up_title");
		String up_pet = multi.getParameter("up_pet");
		String up_exp = multi.getParameter("up_exp");
		String up_answer = multi.getParameter("up_answer");
		String up_conum = multi.getParameter("up_conum");
		String up_lssuer = multi.getParameter("up_lssuer");
		
		
		//textarea는 입력한 문자열 앞뒤로 공백이 발생
		//문자열 앞뒤 공백 제거
		up_exp= up_exp.trim();
		up_myself= up_myself.trim();
		
		int up_answer_tren= Integer.parseInt(up_answer);
		int up_pet_tren = 0;
		
		if(up_pet != null) {
			up_pet_tren = 1;
		}
		
		PetsitterFormDto PetsitterForm =new PetsitterFormDto();
		PetsitterForm.setM_id(m_id);
		PetsitterForm.setUp_myself(up_myself);
		PetsitterForm.setUp_title(up_title);
		PetsitterForm.setUp_answer(up_answer_tren);
		PetsitterForm.setUp_conum(up_conum);
		PetsitterForm.setUp_exp(up_exp);
		PetsitterForm.setUp_lssuer(up_lssuer);
		PetsitterForm.setUp_pet(up_pet_tren);

		
		try {
			
			pDao.PetsitterForm_Insert(PetsitterForm);
			
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "등록성공");
		
			log.info("확인");
			//MemberDto member = (MemberDto)session.getAttribute("mb");
			/*
			if(member.getM_point() < 100)
			{
				pDao.m_point(id);
				
				member = mDao.getMemberInfo(id);
				session.setAttribute("mb", member);
			}
			*/
			//파일 업로드 메소드 호출
			/*
			if(check.equals("1"))
			{
				fileUp(multi, board.getBnum());
			}
			*/
		}
		catch(Exception e)
		{
			e.printStackTrace();
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}
		
		return view;
	}

	public ModelAndView petsitterlist(Integer pageNum) {
		// TODO Auto-generated method stub
		mv = new ModelAndView();
		
		int num = (pageNum == null) ? 1 : pageNum;
		
		List<petsitter_listDto> sitterList = pDao.getsitterList(num);
		
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("sitterList", sitterList);
		
		//페이징 처리
		mv.addObject("paging", getPaging(num));
		
		//세션에 페이지 번호 저장
		session.setAttribute("pageNum", num);
		
		mv.setViewName("petsitter_list");
		
		return mv;
	}
	


	public ModelAndView getinglist(Integer pageNum) {
		
		mv = new ModelAndView();
		
		int num = (pageNum == null) ? 1 : pageNum;
		
		MemberDto member = (MemberDto)session.getAttribute("mb");
		System.out.println(member.getM_id());
		List<ResPetsitterDto> ingList = pDao.getingList(member.getM_id());
		
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("ingList", ingList);
		
		//페이징 처리
		mv.addObject("paging", getPaging(num));
		
		//세션에 페이지 번호 저장
		session.setAttribute("pageNum", num);
		
		mv.setViewName("quest_list_ing");
		
		return mv;
	}
	
	public ModelAndView getquestlist(Integer pageNum) {
		
		mv = new ModelAndView();
		
		int num = (pageNum == null) ? 1 : pageNum;
		
		List<quest_listDto> questList = pDao.getquestList(num);		
		
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("questList", questList);
		
		//페이징 처리
		mv.addObject("paging", getPaging2(num));
		
		//세션에 페이지 번호 저장
		session.setAttribute("pageNum", num);
		
		mv.setViewName("quest_list");
		
		return mv;
	}
	
	public ModelAndView getquestContents(String pnum)
	{
		mv= new ModelAndView();
		
		//글내용 가져오기
		ResPetsitterDto respet = pDao.getquestContents(pnum);
		
		mv.addObject("respet", respet);
		
		//뷰 이름 지정 하기
		
		mv.setViewName("petsitter_quest_info");
		
		return mv;
	}
	
	public ModelAndView getingContents(String pnum)
	{
		mv= new ModelAndView();
		
		//글내용 가져오기
		ResPetsitterDto respet = pDao.getquestContents(pnum);
		
		mv.addObject("respet", respet);
		
		//뷰 이름 지정 하기
		
		mv.setViewName("petsitter_quest_info_ing");
		
		return mv;
	}
	
	private String getPaging(int num) {
		//전체 글 개수 구하기(from DB)
		int maxNum = pDao.getsitterListCnt();
		//설정값(페이지 당 글 개수, 그룹 당 페이지 개수, 게시판 이름)
		int listCnt = 10;
		int pageCnt = 2;
		String listName = "list";
		
		Paging paging = new Paging(maxNum, num, listCnt,
				pageCnt, listName);
		
		String pagingHtml = paging.makePaging();
		
		return pagingHtml;
	}
	
	private String getPaging2(int num) {
		//전체 글 개수 구하기(from DB)
		int maxNum = pDao.getquestListCnt();
		//설정값(페이지 당 글 개수, 그룹 당 페이지 개수, 게시판 이름)
		int listCnt = 10;
		int pageCnt = 2;
		String listName = "petsitter_res_paging";
		
		Paging paging = new Paging(maxNum, num, listCnt,
				pageCnt, listName);
		
		String pagingHtml = paging.makePaging();
		
		return pagingHtml;
	}
	

	
	public Map<String, MemberDto> getmemberinfo(String mid) {
		// TODO Auto-generated method stub
		Map<String, MemberDto> mmap = null;
		
		MemberDto member= pDao.getMemberInfo_res(mid);
		
		mmap = new HashMap<String, MemberDto>();
		
		mmap.put("member",member);
		
		return mmap;
	}
	
	public Map<String, PetDto> getpetinfo(String pid) {
		// TODO Auto-generated method stub
		Map<String, PetDto> pmap = null;
		
		PetDto pet= pDao.getpetInfo_res(pid);
		
		pmap = new HashMap<String, PetDto>();
		
		pmap.put("pet",pet);
		
		return pmap;
	}


	@Transactional
	public String resUpdate(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		// TODO Auto-generated method stub

		

		String view = null;
		
		String rsp_num = multi.getParameter("pst_num");
		String pst_id = multi.getParameter("pst_id");
		String pst_cash = multi.getParameter("pst_cash");
		String rsp_stat = "1";
		
		//textarea는 입력한 문자열 앞뒤로 공백이 발생
		//문자열 앞뒤 공백 제거
		
		int pst_num_tren= Integer.parseInt(pst_cash);
		
				
		ResPetsitterDto updateres =new ResPetsitterDto();
		updateres.setRsp_num(rsp_num);
		updateres.setM_id2(pst_id);
		updateres.setRsp_price(pst_num_tren);
		updateres.setRsp_stat(rsp_stat);
		
		try {
			
			pDao.PetsitterRes_update(updateres);
			
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "등록성공");
		
			log.info("확인");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}
		
		return view;
	}



	public ModelAndView getsitterContents(String snum)
	{
		mv= new ModelAndView();
		
		//글내용 가져오기
		MemberDto sitter = pDao.getsitterContents(snum);
		
		PetsitterFormDto pf = pDao.getpetForm(snum);
		
		mv.addObject("sitter", sitter);
		mv.addObject("pf", pf);
		
		//뷰 이름 지정 하기
		
		mv.setViewName("petsitter_info");
		
		return mv;
	}



	public Map<String, MemberDto> getpetsitterinfo(String pst_pstid) {
		// TODO Auto-generated method stub
		Map<String, MemberDto> pstmap = null;
		
		MemberDto pstinfo= pDao.getMemberInfo_res(pst_pstid);
		
		pstmap = new HashMap<String, MemberDto>();
		
		pstmap.put("pstinfo",pstinfo);
		
		return pstmap;
	}



	public String resing_end(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		// TODO Auto-generated method stub
		
		
		String view = null;
		
		String rsp_num = multi.getParameter("pst_num");
		String rsp_stat = "2";
		
		//textarea는 입력한 문자열 앞뒤로 공백이 발생
		//문자열 앞뒤 공백 제거
		
				
		ResPetsitterDto updatereslast =new ResPetsitterDto();
		
		updatereslast.setRsp_stat(rsp_stat);
		updatereslast.setRsp_num(rsp_num);
		
		try {
			
			pDao.PetsitterRes_updatelast(updatereslast);
			
			rttr.addFlashAttribute("msg", "등록성공");
		
			log.info("확인");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			rttr.addFlashAttribute("msg", "글 등록 실패");
			
		}
		
		ResPetsitterDto sarchres =new ResPetsitterDto();
		
		
		sarchres = pDao.Petsitter_ressurch(rsp_num);
		
			
			PetsitterQuestlistDto psq = new PetsitterQuestlistDto();
			psq.setRsp_num(rsp_num);
			psq.setM_id(sarchres.getM_id());
			psq.setM_id2(sarchres.getM_id2());
			
			try {
				
				pDao.Petsitter_questList(psq);
				
				view="redirect:petsittermain";
				rttr.addFlashAttribute("msg", "등록성공");
			
				log.info("확인");
			}
			catch(Exception e)
			{
				e.printStackTrace();
				view="redirect:petsittermain";
				rttr.addFlashAttribute("msg", "글 등록 실패");
			}
		
		return view;
	}



	public String resing_cencle(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		
		String view = null;
		
		String rsp_num = multi.getParameter("pst_num");
		String pst_cash = "0";
		String rsp_stat = "0";
		
		//textarea는 입력한 문자열 앞뒤로 공백이 발생
		//문자열 앞뒤 공백 제거
		int pst_num_tren= Integer.parseInt(pst_cash);
				
		ResPetsitterDto updatereslast =new ResPetsitterDto();
		updatereslast.setRsp_price(pst_num_tren);
		updatereslast.setRsp_stat(rsp_stat);
		updatereslast.setRsp_num(rsp_num);
		
		try {
			
			pDao.PetsitterRes_updatecancle(updatereslast);
			
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "등록성공");
		
			log.info("확인");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}
		
		return view;
	}



	public ModelAndView mypetsitterlist() {
		// TODO Auto-generated method stub
		
		mv = new ModelAndView();
		
		MemberDto member = (MemberDto)session.getAttribute("mb");
		String mid = member.getM_id();

		List<PetsitterQuestlistDto> questList2 = pDao.getquestList2(mid);		
		
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("questList2", questList2);
		
		mv.setViewName("pet_my_quest_list");
		
		return mv;
	}



	public ModelAndView myquest(String mnum) {
		
		// TODO Auto-generated method stub
		mv= new ModelAndView();
		
		//글내용 가져오기
		PetsitterQuestlistDto myq = pDao.getmyquestContents(mnum);
		
		mv.addObject("myq", myq);
		//뷰 이름 지정 하기
		
		mv.setViewName("pet_sitter_mypet");
		
		return mv;
	}



	public ModelAndView youerpetsitterlist() {
		// TODO Auto-generated method stub

		mv = new ModelAndView();
		
		MemberDto member = (MemberDto)session.getAttribute("mb");
		String mid = member.getM_id();

		List<PetsitterQuestlistDto> questList2 = pDao.getyouquestList2(mid);		
		
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("questList2", questList2);
		
		mv.setViewName("pet_you_quest_list");
		
		return mv;
	}



	public ModelAndView youerquest(String mnum) {
		// TODO Auto-generated method stub
		
		mv= new ModelAndView();
		
		//글내용 가져오기
		PetsitterQuestlistDto youerq = pDao.getmyquestContents(mnum);
		
		mv.addObject("youerq", youerq);
		//뷰 이름 지정 하기
		
		mv.setViewName("pet_sitter_youerpet");
		
		return mv;
	}



	public Map<String, PetsitterQuestlistDto> mp_up(String mp_num, String cheak) {
		// TODO Auto-generated method stub
		
		Map<String, PetsitterQuestlistDto> mp_map = null;
		
		
			try {
				if(cheak.equals("1"))
				{
					pDao.getmp_eat_up(mp_num);
					log.info(mp_num);
				}
				else if(cheak.equals("2"))
				{
					pDao.getmp_walk_up(mp_num);
					log.info(mp_num);
				}
				else if(cheak.equals("3"))
				{
					pDao.getmp_bath_up(mp_num);
					log.info(mp_num);
				}
				else if(cheak.equals("4"))
				{
					pDao.getmp_medic_up(mp_num);
					log.info(mp_num);
				}
				else if(cheak.equals("5"))
				{
					pDao.getmp_clean_up(mp_num);
					log.info(mp_num);
				}
				
			
				log.info("확인");
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		 
		
		PetsitterQuestlistDto mp_eat_up= pDao.getmyquestContents(mp_num);
		
		mp_map = new HashMap<String, PetsitterQuestlistDto>();
		
		mp_map.put("mp_map",mp_eat_up);
		
		return mp_map;
		
	}



	public boolean petquestcancles(String mp_num,String rsp_num, String CR) {
		
		boolean chk = false;
		
		PetsitterQ_cancel pq_cancel =new PetsitterQ_cancel();
		
		pq_cancel.setCr(CR);
		pq_cancel.setMp_num(mp_num);
		pq_cancel.setMp_etc(2);
		
		ResPetsitterDto updatereslast =new ResPetsitterDto();
		updatereslast.setRsp_price(0);
		updatereslast.setRsp_stat("3");
		updatereslast.setRsp_num(rsp_num);
		
			
		
		try {
			pDao.Petsitter_questList_cancle(pq_cancel);
			pDao.PetsitterRes_questcancle(updatereslast);
			
			chk = true;
				log.info("확인");
			}
			catch(Exception e)
			{
				e.printStackTrace();
				chk = false;
			}
		
		return chk;
		
	}



	public String petsittersucess(MultipartHttpServletRequest multi,RedirectAttributes rttr) {
		// TODO Auto-generated method stub

		String view = null;
		
		String mp_num = multi.getParameter("mp_num");
		
		try {
			
			pDao.petsittersucess(mp_num);
			
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "등록성공");
		
			log.info("확인");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}
		
		boolean chk = questcompletist(mp_num);
		
		if(chk)
		{
			rttr.addFlashAttribute("msg", "모든 의뢰가 완료되었습니다.");
		}
		
		
		return view;
	}



	public String mysucess(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		// TODO Auto-generated method stub
		String view = null;
		
		String mp_num = multi.getParameter("mp_num");
		
		try {
			
			pDao.mysucess(mp_num);
			
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "등록성공");
		
			log.info("확인");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}
		
		boolean chk = questcompletist(mp_num);
		
		if(chk)
		{
			rttr.addFlashAttribute("msg", "모든 의뢰가 완료되었습니다.");
		}
		
		return view;
	}
	
	//내일 할거
	//펫시터 퀘스트리스트 완료 완성학기
	
	public boolean questcompletist(String mp_num) {
		// TODO Auto-generated method stub
		
		int my_chk= pDao.mysucess_chk(mp_num);
		int you_chk= pDao.petsittersucess_chk(mp_num);
		PetsitterQuestlistDto rsp_chk = pDao.getmyquestContents(mp_num);
		
		boolean chk = false;
		
		try {
			
			if(my_chk == you_chk)
			{
				pDao.questcomp(mp_num);
				
				pDao.res_comp(rsp_chk.getRsp_num());
				chk = true;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return chk;
	}
	
	public boolean petquestchk(String mp_num) {
		// TODO Auto-generated method stub
		
		int my_chk= pDao.mysucess_chk(mp_num);
		
		boolean chk = false;

			if(my_chk == 1)
			{
				chk = true;
			}
		
		return chk;
	}
	
	public boolean myquestchk(String mp_num) {
		// TODO Auto-generated method stub
		
		int you_chk = 0;
		
		you_chk = pDao.petsittersucess_chk(mp_num);
		
		boolean chk = false;

			if(you_chk == 1)
			{
				chk = true;
			}
		
		return chk;
	}



	public ModelAndView pst_res_list() {
		mv = new ModelAndView();
		
		
		MemberDto member = (MemberDto)session.getAttribute("mb");
		System.out.println(member.getM_id());
		List<ResPetsitterDto> sitterList = pDao.pst_res_list(member.getM_id());
		
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("sitterList", sitterList);
		
		mv.setViewName("petsitter_reslist");
		
		return mv;
	}
	

	
	public ModelAndView getresContents(String pnum)
	{
		mv= new ModelAndView();
		
		//글내용 가져오기
		ResPetsitterDto respet = pDao.getquestContents(pnum);
		
		mv.addObject("respet", respet);
		
		//뷰 이름 지정 하기
		
		mv.setViewName("petsitter_res_info");
		
		return mv;
	}
	
	public ModelAndView come_quest() {
		mv = new ModelAndView();
		MemberDto member = (MemberDto)session.getAttribute("mb");
		System.out.println(member.getM_id());
		List<ResPetsitterDto> sitterList = pDao.pst_come_list(member.getM_id());
		
		//DB에서 조회한 데이터 목록을 모델에 추가
		mv.addObject("sitterList", sitterList);
		
		
		mv.setViewName("petsitter_com_res");
		
		return mv;
	}



	public ModelAndView petsitterupdate(String pnum)
	{
		mv= new ModelAndView();
		
		//글내용 가져오기
		ResPetsitterDto respet = pDao.getquestContents(pnum);
		
		mv.addObject("rsp", respet);
		
		//뷰 이름 지정 하기
		
		mv.setViewName("pet_sitter_upFrm");
		
		return mv;
	}

	@Transactional
	public String res_update(ResPetsitterDto resDto, 
			MultipartHttpServletRequest multi, RedirectAttributes rttr)
	{
	
		
		log.info("QuestInsert()");
		
		String view = null;
		
		String m_id = multi.getParameter("m_id");
		String m_id2 = multi.getParameter("m_id2");
		String p_pid = multi.getParameter("p_pid");
		String hp_num= multi.getParameter("hp_num");
		String ca_num = multi.getParameter("ca_num");
		String rsp_in = multi.getParameter("from");
		String rsp_out = multi.getParameter("to");
		String rsp_contents = multi.getParameter("contents");
		String rsp_etc = multi.getParameter("rsp_etc");
		String rsp_lic= multi.getParameter("licens");
		String rsp_cond1 = multi.getParameter("patient");
		String rsp_cond2 = multi.getParameter("pickup_suc");
		String rsp_cond3 = multi.getParameter("no_animal");
		String rsp_cond4= multi.getParameter("old");
		String rsp_cond5 = multi.getParameter("notting");
		String rsp_pick = multi.getParameter("pickup_how");
		
		//textarea는 입력한 문자열 앞뒤로 공백이 발생
		//문자열 앞뒤 공백 제거
		rsp_etc= rsp_etc.trim();
		resDto.setM_id(m_id);
		resDto.setM_id2(m_id2);
		resDto.setP_pid(p_pid);
		resDto.setHp_num(hp_num);
		resDto.setCa_num(ca_num);
		resDto.setRsp_in(rsp_in);
		resDto.setRsp_out(rsp_out);
		resDto.setRsp_contents(rsp_contents);
		resDto.setRsp_etc(rsp_etc);
		resDto.setRsp_lic(rsp_lic);
		resDto.setRsp_cond1(rsp_cond1);
		resDto.setRsp_cond2(rsp_cond2);
		resDto.setRsp_cond3(rsp_cond3);
		resDto.setRsp_cond4(rsp_cond4);
		resDto.setRsp_cond5(rsp_cond5);
		resDto.setRsp_pick(rsp_pick);
		
		try {
			pDao.res_update(resDto);
			
					
			view = "redirect:pst_res_list";
			rttr.addFlashAttribute("msg", "수정 성공");
		} catch (Exception e) {
			//e.printStackTrace();
			view = "redirect:res_update";
			rttr.addFlashAttribute("msg", "수정 실패");
		}
		
		return view;
	}
	
	
}//class end






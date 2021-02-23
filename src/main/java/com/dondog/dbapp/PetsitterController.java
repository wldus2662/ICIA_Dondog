package com.dondog.dbapp;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.PetDto;
import com.dondog.dbapp.dto.PetsitterQuestlistDto;
import com.dondog.dbapp.dto.ResPetsitterDto;
import com.dondog.dbapp.service.MemberService;
import com.dondog.dbapp.service.PetsitterService;

import lombok.extern.java.Log;


/**
 * Handles requests for the application home page.
 */
@Controller
@Log
public class PetsitterController {
	
	private static final Logger logger = LoggerFactory.getLogger(PetsitterController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@Autowired
	private MemberService mServ;
	
	private ModelAndView mv;
	
	@Autowired
	private PetsitterService pServ;
	
	@GetMapping("petlist")
	public ModelAndView petlist() {
		log.info("petlist()");
		
		mv =pServ.getpetList();
		
		return mv;
	}
	
	@PostMapping("writeQuest")
	public String petsitterres(MultipartHttpServletRequest multi, 
			RedirectAttributes rttr) {
		
		log.info("writeQuest()");
		
		String view =pServ.QuestInsert(multi, rttr);
		
		return view;
	}
	
	@GetMapping("petsittermain")
	public String petsittermain() {
		log.info("pet_sitter_main()");
		
		return "pet_sitter_main";
	}
	
	@GetMapping("petsitterup")
	public ModelAndView petsitterup() {
		log.info("petsitterup()");
		
		mv =pServ.getquestionList();
		
		return mv;
	}
	
	@GetMapping("inglist")
	public ModelAndView inglist(Integer pageNum) {
		log.info("petsitterup()");
		
		mv =pServ.getinglist(pageNum);
		
		return mv;
	}
	
	@GetMapping("questing")
	public ModelAndView questing(String inum)
	{
		log.info("questing()- bnum: " + inum);
		
		mv= pServ.getingContents(inum);
		
		return mv;
	}
	@PostMapping("petsitterupcon")
	public String petsitterupcon(MultipartHttpServletRequest multi, 
			RedirectAttributes rttr) {
		
		log.info("writeQuest()");
		
		String view =pServ.petsitterInsert(multi, rttr);
		
		return view;
	}
	
	@GetMapping("petsitterlist")
	public ModelAndView petsitterlist(Integer pageNum) {
		log.info("petsitterlist()");
		
		mv = pServ.petsitterlist(pageNum);
				
		return mv;
	}
	
	@GetMapping("serchquset")
	public ModelAndView questlist(Integer pageNum) {
		log.info("petsitterlist()");
		
		mv = pServ.getquestlist(pageNum);
		
		return mv;
	}
	
	@GetMapping("questcontents")
	public ModelAndView questcontents(String qnum)
	{
		log.info("quest_listDto()- bnum: " + qnum);
		
		mv= pServ.getquestContents(qnum);
		
		return mv;
	}
	
			
	@GetMapping("sittercontents")
	public ModelAndView sittercontents(String snum)
	{
		log.info("quest_listDto()- bnum: " + snum);
				
		mv= pServ.getsitterContents(snum);
				
		return mv;
	}
			

	@GetMapping(value = "getmemberinfo", 
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, MemberDto> getmemberinfo(String mid) {
		log.info("getmemberinfo() id: " + mid);
		
		Map<String, MemberDto> mmap = null;
		
		mmap = pServ.getmemberinfo(mid);
		
		return mmap;
	}
	
	@GetMapping(value = "getpetinfo", 
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, PetDto> getpetinfo(String pid) {
		log.info("getmemberinfo() id: " + pid);
		
		Map<String, PetDto> mmap = null;
		
		mmap = pServ.getpetinfo(pid);
		
		return mmap;
	}
	@GetMapping(value = "getpst_info", 
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, MemberDto> getpst_info(String pst_pstid) {
		log.info("getmemberinfo() id: " + pst_pstid);
		
		Map<String, MemberDto> mmap = null;
		
		mmap = pServ.getpetsitterinfo(pst_pstid);
		
		return mmap;
	}
	
	
	@PostMapping("petsittersucces")
	public String petsittersucces(MultipartHttpServletRequest multi, 
			RedirectAttributes rttr)
	{
		log.info("petsittersucces()");
		String view= null;		
		view = pServ.resUpdate(multi,rttr);
		
		return view;
	}
	
	@PostMapping("next_res")
	public ModelAndView next_res(MultipartHttpServletRequest multi, 
			RedirectAttributes rttr)
	{
		log.info("petsittersucces()");
		String view= null;		
		mv = new ModelAndView();
		
		String m_id2 = multi.getParameter("m_id2");
		
		//textarea는 입력한 문자열 앞뒤로 공백이 발생
		//문자열 앞뒤 공백 제거
		
		ResPetsitterDto respm =new ResPetsitterDto();
		respm.setM_id2(m_id2);
		
		mv.addObject("respm", respm);
		
		//뷰 이름 지정 하기
		
		mv.setViewName("pet_sitter_res");
		
		return mv;
	}
	
	@PostMapping("resing_end")
	public String resing_end(MultipartHttpServletRequest multi, 
			RedirectAttributes rttr)
	{
		log.info("resing_end()");
		String view= null;		
		view = pServ.resing_end(multi,rttr);
		
		return view;
	}
	
	@PostMapping("resing_cencle")
	public String resing_cencle(MultipartHttpServletRequest multi, 
			RedirectAttributes rttr)
	{
		log.info("resing_cencle()");
		String view= null;		
		view = pServ.resing_cencle(multi,rttr);
		
		return view;
	}
	
	@GetMapping("mypetsitterlist")
	public ModelAndView mypetsitterlist()
	{
		mv = new ModelAndView();
		
		log.info("mypetsitterlist()");
		mv = pServ.mypetsitterlist();
		
		return mv;
	}
	
	@GetMapping("youerpetsitterlist")
	public ModelAndView youerpetsitterlist()
	{
		mv = new ModelAndView();
		
		log.info("youerpetsitterlist()");
		mv = pServ.youerpetsitterlist();
		
		return mv;
	}
	
	@GetMapping("myquest")
	public ModelAndView myquest(String mnum)
	{
		log.info("myquest()- mnum: " + mnum);
		
		mv= pServ.myquest(mnum);
				
		return mv;
	}
	
	@GetMapping("youerquest")
	public ModelAndView youquest(String mnum)
	{
		log.info("youerquest()- mnum: " + mnum);
		
		mv= pServ.youerquest(mnum);
				
		return mv;
	}
	
	@PostMapping(value = "mp_up", 
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, PetsitterQuestlistDto> mp_up(String mp_num ,String cheak) {
		log.info("getmemberinfo() id: " + mp_num);
		
		Map<String, PetsitterQuestlistDto> mp_map = null;
		
		mp_map = pServ.mp_up(mp_num ,cheak);
		
		return mp_map;
	}
	
	@PostMapping(value = "petquestcancles", 
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public boolean petquestcancles(String mp_num ,String rsp_num,String CR ) {
		log.info("petquestcancles() id: " + mp_num);
		
		boolean chk = false;
		
		chk= pServ.petquestcancles(mp_num ,rsp_num,CR);
		
		return chk;
	}
	
	@PostMapping("petsittersucess")
	public String petsittersucess(MultipartHttpServletRequest multi,RedirectAttributes rttr)
	{
		String view = null;
		
		log.info("petsittersucess()");	
		
		view = pServ.petsittersucess(multi,rttr);
				
		return view;
	}
	
	@PostMapping("mysucess")
	public String mysucess(MultipartHttpServletRequest multi, RedirectAttributes rttr)
	{
		String view = null;
		
		log.info("petsittersucess()");
		
		view = pServ.mysucess(multi,rttr);
				
		return view;
	}
	
	@PostMapping(value = "petquestchk", 
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public boolean petquestchk(String mp_num) {
		log.info("petquestchk() id: " + mp_num);
		
		boolean chk = false;
		
		chk= pServ.petquestchk(mp_num);
		
		return chk;
	}
	
	@PostMapping(value = "myquestchk", 
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public boolean myquestchk(String mp_num) {
		log.info("petquestchk() id: " + mp_num);
		
		boolean chk = false;
		
		chk= pServ.myquestchk(mp_num);
		
		return chk;
	}
	
	@GetMapping("pst_res_list")
	public ModelAndView pst_res_list() {
		log.info("petsitterlist()");
		
		mv = pServ.pst_res_list();
				
		return mv;
	}
	
	@GetMapping("rescontents")
	public ModelAndView rescontents(String qnum)
	{
		log.info("quest_listDto()- bnum: " + qnum);
		
		mv= pServ.getresContents(qnum);
		
		return mv;
	}
	
	@GetMapping("come_quest")
	public ModelAndView come_quest() {
		log.info("come_quest()");
		
		mv = pServ.come_quest();
				
		return mv;
	}
	
	@GetMapping("petsitterupdate")
	public ModelAndView petsitterupdate(String pnum) {
		log.info("petsitterupdate() rsp_num:"+ pnum);
		
		mv = pServ.petsitterupdate(pnum);
				
		return mv;
	}
	
	@PostMapping("res_update")
	public String res_update(ResPetsitterDto resDto,MultipartHttpServletRequest multi, RedirectAttributes rttr)
	{
		String view = null;
		
		log.info("res_update()");
		
		view = pServ.res_update(resDto,multi,rttr);
				
		return view;
	}
	
}

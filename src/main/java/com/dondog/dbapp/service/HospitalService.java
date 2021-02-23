package com.dondog.dbapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.HospitalDao;
import com.dondog.dbapp.dao.HostBoardDao;
import com.dondog.dbapp.dao.HostMemberDao;
import com.dondog.dbapp.dao.PetMemberDao;
import com.dondog.dbapp.dto.HospitalDto;
import com.dondog.dbapp.dto.HostBoardDto;
import com.dondog.dbapp.dto.HostMemberDto;
import com.dondog.dbapp.dto.HpRegformDto;
import com.dondog.dbapp.dto.PetDto;
import com.dondog.dbapp.dto.ResPetsitterDto;

import lombok.extern.java.Log;

@Service
@Log
public class HospitalService {
	@Autowired
	HospitalDao HosDao;
	@Autowired
	HostMemberDao hostDao;
	@Autowired
	private HostBoardDao bDao;
	@Autowired
	PetMemberDao petDao;
	
	private ModelAndView mv;
	
	public String resHpwrite(MultipartHttpServletRequest multi, 
			RedirectAttributes rttr) {
		log.info("resHpwrite()");
		String view = null;
		String m_id = multi.getParameter("m_id");
		String h_id = multi.getParameter("h_id");
		String p_pid = multi.getParameter("p_pid");
		String from = multi.getParameter("from");
		String time = multi.getParameter("time");	
		String hp_in = from+" "+time;
		String hp_contents = multi.getParameter("hp_contents");
		String hp_visit = multi.getParameter("hp_visit");
		String hp_symp = multi.getParameter("hp_symp");
		
		hp_contents = hp_contents.trim();
		hp_visit = hp_visit.trim();
		HospitalDto hospital = new HospitalDto();
		hospital.setM_id(m_id);
		hospital.setH_id(h_id);
		hospital.setP_pid(p_pid);
		hospital.setHp_in(hp_in);
		hospital.setHp_contents(hp_contents);
		hospital.setHp_visit(hp_visit);
		hospital.setHp_symp(hp_symp);
		try {
			HosDao.resHpInsert(hospital);
			view = "redirect:myResNow";
			rttr.addFlashAttribute("msg", "글 등록 성공");
		} catch (Exception e) {
			//e.printStackTrace();
			view = "redirect:main";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}		
		return view;
	}
	
	public ModelAndView getHost(String hid) {
		mv = new ModelAndView();
		HostMemberDto host = hostDao.getHostInfo(hid);
		
		mv.addObject("hBoard",host);
		mv.setViewName("resHp");		
		return mv;
	}

	public ModelAndView getHosPSres(String hp_num) {
		log.info("getHosPSres");
		mv = new ModelAndView();
		HospitalDto hp = HosDao.getHosInfo(hp_num);
		String id = hp.getP_pid();
		PetDto pet =  petDao.getPetInfo(id);
		mv.addObject("hp",hp);
		mv.addObject("pet",pet);
		mv.setViewName("HosPSresW");
		return mv;
	}

	public String writeHPQuest(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		log.info("writeHPQuest()");
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
			HosDao.HPquestInsert(respet);	
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "등록성공");
		
			log.info("확인");
			
		} catch (Exception e) {
			e.printStackTrace();
			view="redirect:petsittermain";
			rttr.addFlashAttribute("msg", "글 등록 실패");
		}
		
		return view;
	}
	

}

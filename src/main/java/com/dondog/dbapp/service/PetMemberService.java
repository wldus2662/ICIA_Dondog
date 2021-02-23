package com.dondog.dbapp.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dao.PetMemberDao;
import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HostBoardDto;
import com.dondog.dbapp.dto.HostMemberDto;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.PetDto;


import lombok.extern.java.Log;

@Service
@Log
public class PetMemberService {
	@Autowired
	private PetMemberDao pmDao;
	//세션 객체
	@Autowired
	private HttpSession session;
	//ModelAndView
	private ModelAndView mv;
	
	//회원가입- 2.반려동물 정보입력
			@Transactional
			public String petInsert(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
				log.info("mServ.petInsert()");
				String view = null;
				
				String id = multi.getParameter("m_id");
				String name = multi.getParameter("p_name");
				String kind = multi.getParameter("p_kind");
				String kindt = multi.getParameter("p_kindt");
				String age = multi.getParameter("p_age");
				String gender = multi.getParameter("p_gender");
				String pnum = multi.getParameter("p_pnum");
				String size = multi.getParameter("p_size");
				
				String check = multi.getParameter("fileCheck");
				
				String type = multi.getParameter("type");
				log.info(type);
				PetDto pet = new PetDto();
				pet.setM_id(id);
				pet.setP_name(name);
				pet.setP_kind(kind);
				pet.setP_kindt(kindt);
				pet.setP_age(Integer.parseInt(age));
				pet.setP_gender(gender);
				pet.setP_pnum(pnum);
				pet.setP_size(Integer.parseInt(size));
				
				try {
					pmDao.petInsert(pet);
					//파일 업로드 처리 메소드 호출
					if(check.equals("1")) {
						fileUp(multi,pet.getP_pid());
					}
					if(type.contains("2")) {//펫시터가입으로 들어온 경우
						view ="redirect:pet_sitter_apply";//펫시터등록페이지로 이동
					}
					else{//일반 가입으로 들어온 경우
						view ="redirect:/";//메인 페이지로 이동
					}
					rttr.addFlashAttribute("msg", "가입 성공");
				}catch(Exception e) {
					//e.printStackTrace();
					view = "redirect:joinFrm_pet";
					rttr.addFlashAttribute("msg", "가입 실패");
				}
			
				return view; 
			}
			//파일 업로드 처리 메소드
			public boolean fileUp(MultipartHttpServletRequest multi, String p_pid)throws Exception {
				
				//저장공간에 대한 절대 경로 구하기
				String path = multi.getSession().getServletContext().getRealPath("/");

				path += "resources/upload/";
				log.info(path);
				log.info(p_pid);
				
				File dir = new File(path);

				if(dir.isDirectory()==false) {
					dir.mkdir();//폴더가 없을 경우 폴더 생성.
				}
				//실제 파일명과 저장 파일명을 함께 관리
				Map<String, String> fmap = new HashMap<String, String>();

				fmap.put("p_pid", p_pid);  
				
				//파일 전송시 기본 값을 파일 다중 선택임.
				//멀티파트 요청 객체에서 꺼내올 때는 List를 사용.
				List<MultipartFile> fList = multi.getFiles("files");
				for(int i = 0; i<fList.size(); i++) {
					MultipartFile mf = fList.get(i);
					String on = mf.getOriginalFilename();
					fmap.put("f_oriname", on);
					log.info(on);
					//변경된 파일 이름 저장
					String sn = System.currentTimeMillis()
							+"."//확장자 구분 점
							+ on.substring(on.lastIndexOf(".")+1);
					fmap.put("f_sysname", sn);
					log.info(sn);
					//해당 폴더에 파일 저장하기 
					mf.transferTo(new File(path+sn));	   

					pmDao.petfileInsert(fmap);
				}
				return true;
			}
			
			//반려동물 정보 가져오기
			public ModelAndView getPetInfo(String p_pid) {
				mv = new ModelAndView();
				
				//글 내용 가져오기
				PetDto pet = pmDao.getPetInfo(p_pid);
				
			
				//파일목록 가져오기
				List<FileDto> pfList = pmDao.getpfList(pet.getP_pid());

				//모델 데이터 담기
				mv.addObject("pet", pet);
				mv.addObject("pfList", pfList);
				
				//뷰 이름 지정하기
				mv.setViewName("petInfo");

				return mv;
			}
			
			//수정할 내용 가져오기 
			public ModelAndView petInfo_updateFrm(String p_pid, 
					RedirectAttributes rttr) {
				mv = new ModelAndView();
				log.info("petInfo_upFrm - Serv :"+p_pid);
				PetDto pet= pmDao.getPetInfo(p_pid);
				
				String pid = pet.getP_pid();
				log.info("petUpdateFrm pid: "+pid);
				mv.addObject("pet", pet);
				List<FileDto> pfList = pmDao.getpfList(pid);
				mv.addObject("pfList", pfList);
				mv.setViewName("petInfo_upFrm");
						
				return mv;
			}
			//반려동물 정보 수정 처리 
			@Transactional
			public String petInfoUpdate(MultipartHttpServletRequest multi,
					RedirectAttributes rttr) {
				log.info("mServ.petInfoUpdate()");
				String view = null;
				
				String pid = multi.getParameter("p_pid");//0130수정
				String kindt = multi.getParameter("p_kindt");
				String age = multi.getParameter("p_age");
				String gender = multi.getParameter("p_gender");
				String pnum = multi.getParameter("p_pnum");
				String size = multi.getParameter("p_size");
		
				String check = multi.getParameter("fileCheck");
				
				String m_id = multi.getParameter("m_id");
	
				PetDto pet = new PetDto();
				pet.setP_kindt(kindt);
				pet.setP_age(Integer.parseInt(age));
				pet.setP_gender(gender);
				pet.setP_pnum(pnum);
				pet.setP_size(Integer.parseInt(size));
				pet.setM_id(m_id);
				pet.setP_pid(pid);
				try {
					pmDao.petInfoUpdate(pet);
					
					//파일 업로드 메소드 호출
					if(check.equals("1")) {
						log.info(pid);
						fileUp(multi, pid);//0130수정
					}
					
					rttr.addFlashAttribute("msg", "수정 성공");
				} catch (Exception e) {
					e.printStackTrace();
					rttr.addFlashAttribute("msg", "수정 실패");
				}
				
				view = "redirect:petInfoData?p_pid="+pet.getP_pid();
				
				return view;
			}
			
			@Transactional
			public Map<String, List<FileDto>> fileDelete(String sysname, String p_pid) {
				Map<String, List<FileDto>> rMap = null;
				log.info("fileDelete() - sysname: " + sysname + ", p_pid: " + p_pid);
				//절대 경로는 세션으로 구할 수도 있다.
				String path = session.getServletContext()
						.getRealPath("/");
				
				log.info(path);
				path += "resources/upload/" + sysname;
				
				try {
					pmDao.fileDelete(sysname);
					
					File file = new File(path);
					
					if(file.exists()) {
						if(file.delete()) {
							List<FileDto> fList = pmDao.getpfList(p_pid);
							rMap = new HashMap<String, List<FileDto>>();
							rMap.put("pfList", fList);
						}
						else {
							rMap = null;
						}
					}
					
				} catch (Exception e) {
					e.printStackTrace();
					rMap = null;
				}
				
				return rMap;
			}
			
			///////////////////////////////////////////////////////////////////////0205
			
			//등록한 업체 정보 리스트 가져오기 
			public ModelAndView petInfoList() {

				log.info("petInfoList");

				mv = new ModelAndView();
				
				//로그인한 아이디의 정보 꺼내오기
				MemberDto member = (MemberDto)session.getAttribute("mb");
				log.info("회원 아이디 : "+member.getM_id());
				
				List<PetDto> pList = pmDao.getPetList(member.getM_id());
				mv.addObject("pList", pList);
				mv.setViewName("petInfoList");

				return mv;
			}
}//class end

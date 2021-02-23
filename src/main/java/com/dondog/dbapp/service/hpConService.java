package com.dondog.dbapp.service;

import java.io.*;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.dondog.dbapp.dao.myHistoryDao;
import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HospitalDto;
import com.dondog.dbapp.dto.MemberDto;

import lombok.extern.java.Log;

@Service
@Log
public class hpConService {

	//DAO 객체
			@Autowired
			private myHistoryDao hpDao;
			
			//세션 객체
			@Autowired
			private HttpSession session;
			
			//ModelAndView
			private ModelAndView mv1;
			
			//예약 내용 상세보기
			public ModelAndView hpContents(String hp_num) {
				log.info("hpContents()- hp_num : " +hp_num);
				mv1 = new ModelAndView();
				
				//예약내역가져오기
				HospitalDto h = hpDao.hpContents(hp_num);
				
				//파일목록가져오기
				List<FileDto> fList = hpDao.getfList(h.getP_pid());
				
				//DB에서 조회한 데이터 목록을 모델에 추가
				mv1.addObject("h", h);
				mv1.addObject("fList", fList);
				mv1.setViewName("hpContents");

				return mv1;
			}
	
			
			//파일 다운로드 메소드
			public void fileDown(String f_sysname, HttpServletRequest request, HttpServletResponse response) {
				// 서버의 파일 위치의 절대 경로 구하기
				String path = request.getSession().getServletContext()
						.getRealPath("/");
				
				path += "resources/upload/";
				log.info(path);
				
				String f_oriName = hpDao.getOriName(f_sysname);
				path += f_sysname;//다운로드할 파일경로+파일명
				
				//서버 저장장치(디스크)에서 저장된 파일을 읽어오는 통로
				InputStream is = null;
				//사용자 컴퓨터에 파일을 보내는 통로
				OutputStream os = null;
				
				try {
					//파일명 인코딩(파일명이 한글일 때 깨짐을 방지)
					String dFileName = URLEncoder.encode(f_oriName, "UTF-8");
					
					//파일 객체 생성
					File file = new File(path);
					is = new FileInputStream(file);
					
					//응답 객체(response)의 헤더 설정
					//파일전송용 contentType 설정
					response.setContentType("application/octet-stream");
					response.setHeader("content-Disposition", 
							"attachment; filename=\"" + dFileName + "\"");
					//attachment; filename="가나다라.jpg"
					
					//응답 객체와 보내는 통로 연결
					os = response.getOutputStream();
					
					//파일 전송(byte 단위로 전송)
					byte[] buffer = new byte[1024];
					int length;
					while((length = is.read(buffer)) != -1) {
						os.write(buffer, 0, length);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						os.flush();//os에 남아 있을지 모르는 데이터를 강제로 전부 보내도록 처리.	
						os.close();
						is.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			
			}
	
}

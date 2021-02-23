package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class petsitter_listDto {
	private String m_id;//아이디
	private String m_pass;//비밀번호
	private String m_name;///이름
	private String m_birth;//생년월일
	private String m_addr;//주소
	private String m_phone;//전화번호
	private String m_email;//이메일
	private String m_grade;//등급
	private int m_career;//고용횟수(펫시터)
	private int m_point;//포인트
	private int m_level;//권한
	private int m_bad;//신고당한횟수
	private String m_name2;//닉네임
}

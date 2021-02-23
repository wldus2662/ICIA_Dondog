package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class HostMemberDto {
	private String h_id;//업체아이디
	private String h_pass;//비밀번호
	private String h_addr;//주소
	private String h_phone;//전화번호
	private String h_email;//이메일
	private String h_busin;//업체명
	private String h_conum;//사업자등록번호
	private String h_grade;//등급
	private String h_kind;//업종
	private String m_name2;//더미
	private String m_level;//더미
	private String m_id;//더미
	private int h_bad;//신고회수
	private int h_level;//권한
}

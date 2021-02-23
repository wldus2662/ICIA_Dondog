package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class quest_listDto {
	private String rsp_num;//아이디
	private String m_id;//비밀번호
	private String p_pid;///이름
	private String rsp_in;//생년월일
	private String rsp_out;//주소
	private String rsp_stat;//전화번호
	private String hp_num;//이메일
	private String ca_num;//등급
	private String rsp_cond1;//고용횟수(펫시터)
	private String rsp_cond2;//포인트
	private String rsp_cond3;//권한
	private String rsp_cond4;//신고당한횟수
	private String rsp_cond5;//신고당한횟수
}

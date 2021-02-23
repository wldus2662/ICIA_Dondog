package com.dondog.dbapp.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BlackListDto {
	private String bl_num;//신고번호
	private String m_id;//회원아이디(신고당한)
	private String h_id;//업체아이디(신고당한)
	private String r_rnum;//댓글번호
	private String bl_name;//신고자닉네임
	private String bl_contents;//신고내용
	private String bl_title;	//신고제목
	private Timestamp bl_date;//날짜
	private String m_id2;//관리자아이디
}

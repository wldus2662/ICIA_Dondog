package com.dondog.dbapp.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CommuntyDto {
	private String b_num;//글번호
	private String m_id;//아이디(작성자)
	private Timestamp b_date;//날짜
	private String b_title;//제목
	private int b_view;//조회수
	private int b_recom;//추천수
	private String b_contents;//내용
	private int b_head;//말머리
}

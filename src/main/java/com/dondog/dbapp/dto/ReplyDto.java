package com.dondog.dbapp.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReplyDto {
	private String r_rnum;//댓글번호
	private String b_num;//글번호
	private String tr_num;//훈련일지번호
	private String rv_num;//리뷰글번호
	private Timestamp r_date;//날짜
	private int r_recom;//추천
	private String r_contents;//댓글내용
	private String r_name;//작성자(닉네임)
	private String bl_num;//신고번호
}

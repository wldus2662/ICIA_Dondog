package com.dondog.dbapp.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReviewDto {
	private String rv_num;//글번호
	private String me_num;//치료번호
	private String s_num;//업체서비스번호
	private String rsp_num;//펫시터접수번호
	private String h_id;//업체아이디
	private String rv_contents;//리뷰내용
	private String rv_name;//작성자(닉네임)
	private int rv_recom;//추천
	private int rv_star;//평점
	private Timestamp rv_date;
}

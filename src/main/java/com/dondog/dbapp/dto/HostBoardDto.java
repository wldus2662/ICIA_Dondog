package com.dondog.dbapp.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class HostBoardDto {
	private String bh_num;//글번호
	private String h_id;//업체아이디
	private String f_fnum;//파일번호
	private String bt_num;//미용체크
	private String tc_num;//훈련체크
	private String hc_num;//병원체크
	private String s_num;//업체서비스번호
	private Timestamp bh_date;//날짜
	private String bh_title;//제목
	private int bh_view;//조회수
	private int bh_recom;//추천
	private String bh_contents;//업체정보 내용
	private int bh_stat;//상태
	private int bh_review;//리뷰개수
}

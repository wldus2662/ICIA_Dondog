package com.dondog.dbapp.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CashDto {
	private String c_num;//결제번호
	private String rsp_num;//펫시터 접수번호
	private String ca_num;//예약번호
	private String c_contents;//지출내역
	private int c_money;//금액
	private int c_stat;//상태
	private Timestamp c_date;//처리날짜
	private String m_id;//0129추가
}

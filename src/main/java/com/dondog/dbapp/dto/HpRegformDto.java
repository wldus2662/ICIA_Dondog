package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class HpRegformDto {
	private String hc_num;//병원체크
	private int hc_normal;//일반병원
	private int hc_alltime;//24시병원
	private int hc_parking;//주차
	private int hc_beauty;//미용
	private int hc_hotel;//호텔
	private int hc_supplies;//용품
	private int hc_second;//2차병원
	//01-31
	private String bh_num;//글번호
}

package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class BtRegformDto {
	private String bt_num;//미용체크
	private int bt_visit;//방문미용
	private int bt_pickup;//픽업가능
	private int bt_parking;//주차
	private int bt_supplies;//용품
	private String bh_num;
}

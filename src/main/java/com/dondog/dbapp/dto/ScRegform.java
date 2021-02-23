package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class ScRegform {
	private String tc_num;//훈련소체크
	private int tc_parking;
	private int tc_basic;
	private int tc_clean;
	private int tc_prob;
	private int tc_social;
	private int tc_visit;
	private int tc_admis;
}

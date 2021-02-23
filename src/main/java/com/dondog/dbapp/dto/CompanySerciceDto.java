package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class CompanySerciceDto {
	private String s_num;//업체서비스 번호
	private String f_fnum;//파일번호
	private int s_price;//비용
	private String s_contents;//서비스 내용
	private int s_stat;//상태
	private String s_cnum; // 업체 서비스 글번호
}

package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class PetsitterQuestion {
	private String pq_num;//시험번호
	private String up_num;//신청번호
	private int pq_tnum;//문제번호
	private String pq_contens;//문제내용
	private int pq_anser;//정답
	private int pq_myanser;//작성자 답

}

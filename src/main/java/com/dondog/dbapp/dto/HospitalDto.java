package com.dondog.dbapp.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class HospitalDto {
	private String hp_num;//접수번호
	private String p_pid;//반려동물아이디
	private String h_id;//업체아이디
	private String m_id;//사용자아이디
	private String hp_in;//체크인
	private Timestamp hp_out;//체크아웃
	private String hp_contents;//기타사항
	private String hp_date;//증상발생일
	private String hp_visit;//방문목적
	private String hp_symp;//증상
	private int hp_suc;//수락여부
	private String hp_can;//취소사유
}

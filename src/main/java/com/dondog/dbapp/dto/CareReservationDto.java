package com.dondog.dbapp.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CareReservationDto {
	private String ca_num;//예약번호
	private String p_pid;//반려동물아이디
	private String h_id;//업체아이디
	private Timestamp ca_in;//체크인
	private Timestamp ca_out;//체크아웃
	private String s_num;//업체서비스번호
	//snum 외래키연동 업체서비스를 예약으로 불러오는게 맞는거같아 수정필요
	//ERD클라우드는 아직 수정전
	private int ca_suc;//수락여부
	private String ca_can;//취소사유
	private String m_id;//0203추가
}

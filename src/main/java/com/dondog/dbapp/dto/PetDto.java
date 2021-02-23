package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class PetDto {
	private String p_pid;//반려동물아이디
	private String m_id;//주인아이디
	private String f_fnum;//파일번호
	private int p_count;//넘버링(마리)
	private String p_name;//이름
	private String p_kind;//반려동물 종류
	private String p_kindt;//품종
	private int p_age;//나이
	private String p_gender;//성별
	private String p_pnum;//반려동물 번호
	private int p_size;//크기
	private String type;//가입 종류
}

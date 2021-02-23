package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class PetsitterFormDto {
	private String up_num;//신청번호
	private String m_id;//아이디
	private String up_myself;//자기소개
	private String up_title;//제목
	private int up_pet;//펫유/무
	private String up_exp;//펫돌봄경험
	private int up_answer;//정답개수
	private int up_stat;//상태
	private String up_conum;//자격번호
	private String up_lssuer;//발급처
}

package com.dondog.dbapp.dto;

import lombok.Data;


	@Data
	public class PetsitterQuestlistDto {
		private String mp_num;//나의펫의뢰번호
		private String rsp_num;//접수번호
		private int mp_eat;//사료급여
		private int mp_clean;//배변처리
		private int mp_walk;//산책
		private int mp_bath;//목욕
		private int mp_medic;//약주기
		private String mp_cancle;//취소사유
		private int mp_etc;//기타
		private String m_id;//취소사유
		private String m_id2;//취소사유
		private String my_suc;//취소사유
		private String pst_suc;//취소사유
	}


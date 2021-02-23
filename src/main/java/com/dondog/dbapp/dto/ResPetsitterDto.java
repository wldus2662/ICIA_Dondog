package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class ResPetsitterDto {
	private String rsp_num;//접수번호
	private String p_pid;//반려동물 아이디
	private String m_id2;//펫시터 계정아이디	
	private String m_id;//일반아이디
	private String hp_num;//병원접수번호
	private String ca_num;//업체예약번호
	private String rsp_in;//체크인
	private String rsp_out;//체크아웃
	private String rsp_etc;//기타사항
	private String rsp_stat;//진행사항
	private int rsp_price;//의뢰비용
	private String rsp_contents;//의뢰내용
	private String rsp_lic;//자격증유무
	private String rsp_cond1;//환자견 케어선택
	private String rsp_cond2;//픽업가능 선택
	private String rsp_cond3;//반려동물 유무
	private String rsp_cond4;//노령견 케어선택
	private String rsp_cond5;//없음
	private String rsp_pick;//픽업방식 협의
}

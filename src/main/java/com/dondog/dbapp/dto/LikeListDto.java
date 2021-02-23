package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class LikeListDto {
	private String lk_num;//찜 번호
	private String m_id;//찜당한 아이디
	private String bh_num;//찜당한 업체 
	private String lk_id;//찜한 사용자
}

package com.dondog.dbapp.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class TrainingDiaryDto {
	private String tr_num;//훈련번호
	private String ca_num;//예약번호
	private String tr_title;//제목
	private String tr_contents;//훈련일지내용
	private Timestamp tr_date;//날짜
}

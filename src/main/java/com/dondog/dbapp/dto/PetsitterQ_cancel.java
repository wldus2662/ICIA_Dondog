package com.dondog.dbapp.dto;

import lombok.Data;

@Data
public class PetsitterQ_cancel {
	private String cr;//취소이유
	private String mp_num;//글번호
	private int mp_etc;//글번호

}

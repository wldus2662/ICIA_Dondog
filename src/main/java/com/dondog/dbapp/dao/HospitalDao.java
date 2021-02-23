package com.dondog.dbapp.dao;

import com.dondog.dbapp.dto.HospitalDto;
import com.dondog.dbapp.dto.ResPetsitterDto;

public interface HospitalDao {
	//병원예약
	public boolean resHpInsert(HospitalDto hospital);
	//예약정보 불러오기
	public HospitalDto getHosInfo(String hp_num);
	//펫시터병원예약
	public boolean HPquestInsert(ResPetsitterDto respet);

}

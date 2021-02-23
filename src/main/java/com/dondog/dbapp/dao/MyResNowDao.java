package com.dondog.dbapp.dao;

import com.dondog.dbapp.dto.CareReservationDto;

public interface MyResNowDao {
	//병원 예약 취소 (상태를 취소로 업데이트)
	public void hosCancle(String hp_num);
	
	//미용,훈련소,숙소 상세 내역 가져오기
	public CareReservationDto getContents(String ca_num);
	
	//미용,훈련소,숙소 예약 취소 (상태를 취소로 업데이트)
	public void myCancle(String ca_num);
}

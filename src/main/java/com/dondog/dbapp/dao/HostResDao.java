package com.dondog.dbapp.dao;

import java.util.List;

import com.dondog.dbapp.dto.CareReservationDto;
import com.dondog.dbapp.dto.HospitalDto;

public interface HostResDao {
	//병원 예약목록구하기 (간단히)
	public List<HospitalDto> gethosInfo(String id);
	//미용, 훈련소, 숙소 예약 목록구하기 (간단히)
	public List<CareReservationDto> getCareInfo(String id);
	//병원 예약 수락하기
	public void hosSuccess(String hp_num);
	//미용, 훈련소, 숙소 예약 수락하기
	public void careSuccess(String ca_num);
	//병원 예약 취소 사유 등록하기
	public boolean hosCanReason(HospitalDto h);
	//병원 예약 취소 사유 등록하기
	public boolean careCanReason(CareReservationDto c);
}

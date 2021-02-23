package com.dondog.dbapp.dao;

import java.util.List;
import java.util.Map;

import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HospitalDto;


public interface HpChartDao {
	//병원 예약목록구하기 (업체아이디 기준)
	public List<HospitalDto> gethosList(String id);
	//예약 내역 상세보기(m_id)
	public HospitalDto hpChartContents(String hp_num);
	//진단서 목록 가져오기(p_pid)
	public List<FileDto> getfList(String id);
	//원래 파일 이름 구하기
	public String getOriName(String sysName);
	//진단서 파일 업로드
	public boolean hpChartInsert(Map<String, String> fmap);
}

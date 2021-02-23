package com.dondog.dbapp.dao;

import java.util.List;
import java.util.Map;

import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HostBoardDto;


public interface HostRegDao {
	//업체 등록 목록구하기 (간단히)
	public List<HostBoardDto> gethInfo(String id);
	//업체 등록 상세보기
	public HostBoardDto hContents(String id);
	//업체 등록 파일목록 가져오기
	public List<FileDto> getbhfList(String bh_num);
	//원래 파일 이름 구하기
	public String getOriName(String sysName);
	//내 업체 정보 수정
	public boolean hostInfoUpdate(HostBoardDto h);
	//수정 시 업체 소개 파일 업로드
	public boolean hostfileInsert(Map<String, String> fmap);
	//개별 파일 삭제(내 업체 정보 수정 시)
	public boolean fileDelete(String sysName);
}

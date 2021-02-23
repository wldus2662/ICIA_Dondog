package com.dondog.dbapp.dao;

import java.util.List;
import java.util.Map;

import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.PetDto;

public interface PetMemberDao {
	//회원 가입- 반려동물 정보 입력
	public boolean petInsert(PetDto pet);
	//반려동물 사진 파일 저장용 메소드
	public boolean petfileInsert(Map<String, String> fmap);
	//반려동물 정보 가져오기
	public PetDto getPetInfo(String id);
	//반려동물 정보 이미지 목록 가져오기
	public List<FileDto> getpfList(String id);
	//원래 파일 이름 구하기
	public String getOriName(String sysName);
	//반려동물 정보 수정
	public boolean petInfoUpdate(PetDto pet);
	//개별 파일 삭제(반려동물 정보 수정 시)
	public boolean fileDelete(String sysName);
	//반려동물 정보 목록 가져오기
	public List<PetDto> getPetList(String id);
}

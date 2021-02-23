package com.dondog.dbapp.dao;

import java.util.*;

import com.dondog.dbapp.dto.BlackListDto;
import com.dondog.dbapp.dto.CareReservationDto;
import com.dondog.dbapp.dto.CommuntyDto;
import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HospitalDto;
import com.dondog.dbapp.dto.HostBoardDto;
import com.dondog.dbapp.dto.LikeListDto;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.ResPetsitterDto;


public interface myHistoryDao {

	//병원 이용내역 목록구하기 (간단히)
	public List<HospitalDto> gethosInfo(String id);

	//미용, 훈련소, 숙소 이용내역 목록구하기 (간단히)
	public List<CareReservationDto> getCareInfo(String id);

	//펫시터 이용내역 목록구하기 (간단히)
	public List<ResPetsitterDto> getsitterInfo(String id);

	//미용 이용 상세내역 구하기 
	public List<CareReservationDto> getbtInfo(String id);

	//훈련소 이용 상세내역 구하기 
	public List<CareReservationDto> getscInfo(String id);

	//숙소 이용 상세내역 구하기 
	public List<CareReservationDto> gethtLInfo(String id);

	//펫시터 이용 상세내역 구하기 
	public List<ResPetsitterDto> getsitterInfo1(String id);

	//게시글 해당 파일 목록 가져오기
	public List<FileDto> getBfList(Integer bnum);

	//원래 파일 이름 구하기
	public String getOriName(String sysName);

	//게시글 목록 구하기
	public List<CommuntyDto> getCmList(String id);

	//회원 목록 구하기
	public List<MemberDto> mgMemberList(String id);

	//블랙리스트 목록 구하기
	public List<BlackListDto> mgBlackList(String id);

	//찜목록 구하기
	public List<LikeListDto> myLikeList(String id);
	
	//업체 정보 구하기
	public HostBoardDto myLiCon(String bh_num);

	//병원 이용 상세내역 구하기 
	public HospitalDto hpContents(String hp_num);

	//진단서 목록 가져오기
	public List<FileDto> getfList(String id);
}

package com.dondog.dbapp.dao;

import java.util.*;

import com.dondog.dbapp.dto.BlackListDto;
import com.dondog.dbapp.dto.BtRegformDto;
import com.dondog.dbapp.dto.CommuntyDto;
import com.dondog.dbapp.dto.CompanySerciceDto;
import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HostBoardDto;
import com.dondog.dbapp.dto.HpRegformDto;
import com.dondog.dbapp.dto.ReviewDto;
import com.dondog.dbapp.dto.UpimgFileDto;

public interface HostBoardDao {
	//업체 정보 게시글 등록 
	public boolean hBoardInsert(HostBoardDto hBoard);
	//파일(상단이미지) 저장 메소드
	public boolean hfileInsert(Map<String, String> fmap);
	//파일(본문이미지) 저장 메소드
	public boolean hfileInsert2(Map<String, String> fmap2);
	//파일 저장 메소드
	public boolean hfileInsert3(Map<String, String> fmap3);
	//병원체크박스
	public boolean hpRegformInsert(HpRegformDto hrForm);
	//게시글 가져오기
	public HostBoardDto getHContnents(String bh_num);
	//게시글 파일 가져오기
	public List<FileDto> getHfList(String bhnum);
	//게시글 리뷰 가져오기
	public List<ReviewDto> getHrList(String bhnum);
	//업체게시글 목록 구하기
	public List<HostBoardDto> gethBList(int pageNum);
	//업체게시글 전체 개수 구하기
	public int getHBoardCnt();
	//상단이미지파일 가져오기2/2
	public List<UpimgFileDto> getUfList(String bhnum);
	//게시글수정
	public boolean HBupdate(HostBoardDto hBoard);
	//파일 삭제
	public void hFiledelete(String bh_num);
	//게시글 삭제
	public void HBdelete(String bh_num);
	//업체등록 리스트 
	public List<HostBoardDto> gethostInfo(String hid);
	//업체 정보 게시글 등록 
	public boolean hostBoardInsert(HostBoardDto hBoard);
	//방금 등록한 업체 번호 불러오기
	public String getbh_num();
	//업체 서비스 등록
	public void serviceInsert(CompanySerciceDto comser);
	//업체등록리스트 상세보기
	public HostBoardDto gethostContents(String bh_num);
	//등록양식 삭제
	public boolean regBoardDelete(String bh_num);
	
	////////////////////2.18 추가

	//등록 파일 저장 메소드
	public boolean hbfileInsert(Map<String, String> hbfMap);

	//해당 게시글 파일 목록 가져오기
	public List<FileDto> gethbfList(String bh_num);

	//미용체크박스
	public boolean btRegformInsert(BtRegformDto btForm);
	//미용체크박스  내용 불러오기
	public List<BtRegformDto> getBtregForm(String bh_num);
	//체크박스 내용 삭제 
	public void btregDelete(String bh_num);

	//등록된 업체들 리스트 불러오기
	public List<HostBoardDto> beautyList();
	//등록된 게시글 총갯수 구하기
	public int btCounte();
}

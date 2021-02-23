package com.dondog.dbapp.dao;

import java.util.List;

import com.dondog.dbapp.dto.HostBoardDto;
import com.dondog.dbapp.dto.HostMemberDto;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.PetsitterFormDto;



public interface mgCpListDao {
	
	//업체 승인 대기인 내역 가져오기
	public List<HostBoardDto> mgCApproList();
	//업체 등록 내용 가져오기 (레코드 1행)
	public HostBoardDto mgCpLook(String bh_num);
	//업체 등록 승인(상태를 승인으로 업데이트)
	public void mgCAppro(String bh_num);
	//업체 등록 거절(상태를 거절로 업데이트)
	public void mgCAppro1(String bh_num);
	//업체 리스트 가져오기
	public List<HostBoardDto> mgCpList();
	//업체 상세내역 가져오기
	public HostMemberDto mgCpLook2(String h_id);
	//업체 강제탈퇴(상태를 level 9 로 업데이트)
	public void mgCpDel(String h_id);
	//업체 등록내역 삭제 (상태를 level 9 로 업데이트)
	public void mgHbDel(String bh_num);
	//펫시터 신청 내역 가져오기
	public List<PetsitterFormDto> mgPApproList();
	//펫시터 신청 내역 상세보기
	public PetsitterFormDto mgPApproList2(String up_num);
	//펫시터 신청 승인
	public void sittera(String up_num);
	//펫시터 신청 거절
	public void sitterd(String up_num);
	//펫시터 등급을 바꿔줄 멤버 가져오기
	public List<MemberDto> sitterupList();
	//펫시터 등급 바꿔줄 멤버 상세정보 가져오기
	public MemberDto sitterupList2(String m_id);
	//일반회원-> 비전문가 펫시터로 등업
	public void Bsitterup(String m_id);
	//비전문가-> 전문 펫시터로 등업
	public void Asitterup(String m_id);
	
	
	
}

package com.dondog.dbapp.dao;

import com.dondog.dbapp.dto.HostMemberDto;

public interface HostMemberDao {
	//업체계정회원가입
	public void hostInsert(HostMemberDto host);
	//비밀번호 구하기
	public String getEncHPass(String hid);
	//아이디 체크하기
	public int hidCheck(String hid);
	//로그인후 사용할 정보 가져오기
	public HostMemberDto getHostInfo(String hid);
	//업체명 중복여부 확인- 01-31
	public int hbusinCheck(String hbusin);
	//이메일 중복여부 확인
	public int hemailCheck(String hemail);
	//업체계정 수정
	public void HMInfoUpdate(HostMemberDto host);
	
}//class end

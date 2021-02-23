package com.dondog.dbapp.dao;

import com.dondog.dbapp.dto.MemberDto;

public interface MemberDao {
	//회원 가입- 기본 정보 입력
	public void memberInsert(MemberDto member);
	//비밀번호 구하기
	public String getEncPwd(String id);
	//로그인 후 사용할 사용자 정보 가져오기
	public MemberDto getMemberInfo(String id);
	//아이디 중복여부 확인
	public int idCheck(String id);
	//닉네임 중복여부 확인
	public int name2Check(String name2);
	//이메일 중복여부 확인
	public int emailCheck(String email);
	//정보 수정 - 기본 정보 수정
	public boolean myInfoUpdate(MemberDto member);
	//회원 정보 가져오기
	public MemberDto mgMemContents(String m_id);
	//회원 강제 탈퇴 (상태를 level 9 로 업데이트)
	public void blackdel(String m_id);
	//관리자 회원으로 승인 (상태를 level 1 로 업데이트)
	public void mgSignup(String m_id);
	//회원 탈퇴 0201추가
	public boolean myQuit(String id);
}





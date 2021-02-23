package com.dondog.dbapp.dao;

import org.apache.ibatis.annotations.Param;


public interface UserSearchDao {
	
	//회원 ID 찾기
	public String searchId(@Param("user_name")String user_name, @Param("user_phone")String user_phone); 
	//회원 임시 비밀번호 변경 메서드
	public String searchPassword(@Param("user_id")String user_id,@Param("user_email")String user_email, String key);
	//회원 비밀번호 변경
	public boolean updatePw(@Param("m_id")String m_id, String encPwd);
}

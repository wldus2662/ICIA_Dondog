package com.dondog.dbapp.dao;

import java.util.List;

import com.dondog.dbapp.dto.CashDto;



public interface CashDao {
	//결제 내역 구하기 
	public List<CashDto> getcList(String m_id);
	//게시글 내용(레코드 1행) 가져오기
	public CashDto cashContents(String c_num);
	//결제 취소 (상태를 환불처리로 업데이트)
	public void statUpdate(String c_num);
	//결제 대기인 내역 가져오기
	public List<CashDto> cashAll();
	//결제 승인 (상태를 결제완료로 업데이트)
	public void statSuccess(String c_num);
	
}

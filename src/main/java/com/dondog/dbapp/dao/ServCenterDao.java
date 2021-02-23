package com.dondog.dbapp.dao;

import java.util.List;

import com.dondog.dbapp.dto.BlackListDto;
import com.dondog.dbapp.dto.ReplyDto;

public interface ServCenterDao {
	//고객센터 전체개수구하기
	public int getSCBoardCnt();
	//고객센터 목록 구하기
	public List<BlackListDto> getSCList(int pageNum);
	//불만사상 등록
	public void scBoardInsert(BlackListDto black);
	//1:1문의
	public List<BlackListDto> getOneList(int pageNum);
	//1:1문의 작성
	public void OneBoardInsert(BlackListDto black);
	//불만사항가져오기--222
	public BlackListDto getscComp(String bl_num);
	//불만사항 업데이트
	public boolean scCompUpdate(BlackListDto black);
	//불만사항 삭제
	public boolean scCompDelete(String bl_num);
	//댓글 저장
	public boolean ScReplyInsert(ReplyDto reply);
	//댓글 가져오기
	public List<ReplyDto> getScReplyList(String bl_num);
	

}

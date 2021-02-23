package com.dondog.dbapp.dao;

import java.util.List;
import java.util.Map;

import com.dondog.dbapp.dto.CommuntyDto;
import com.dondog.dbapp.dto.CompanySerciceDto;
import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HostBoardDto;
import com.dondog.dbapp.dto.ReplyDto;
import com.dondog.dbapp.dto.ReviewDto;

public interface BoardDao {

	//게시글 저장 메소드
	public boolean boardInsert(CommuntyDto board);

	//게시글 목록 구하기
	public List<CommuntyDto> getList(int pageNum);

	//게시글 전체 개수 구하기
	public int getBoardCnt();

	//게시글 내용(레코드 1행) 가져오기
	public CommuntyDto getContents(String b_num);

	//조회수 증가
	public void viewUpdate(String b_num);

	//게시글 해당 댓글 목록 가져오기
	public List<ReplyDto> getReplyList(String b_num);

	//댓글 저장 메소드
	public boolean replyInsert(ReplyDto reply);

	//게시글 파일 저장 메소드
	public boolean fileInsert(Map<String, String> fmap);

	//게시글 해당 파일 목록 가져오기
	public List<FileDto> getBfList(String b_num);

	//원래 파일 이름 구하기
	public String getOriName(String f_sysname);

	//게시글 수정하기
	public boolean boardUpdate(CommuntyDto board);
	//게시글 수정시 파일 삭제
	public boolean fileDelete(String f_sysname);

	//게시글의 파일 삭제(같은 게시물의 모든 파일 삭제)
	public boolean filesListDelete(String b_num);
	//게시글 댓글 삭제
	public boolean replyDelete(String b_num);
	//게시글 삭제
	public boolean boardDelete(String b_num);
	///////////////
	// 업체 등록 메소드
	public boolean htReg(HostBoardDto host);
	// 업체 목록 구하기
	public List<HostBoardDto> getHlist(int pageNum);
	//업체목록 전체 개수 구하기
	public int getCompCnt();
	//업체 서비스 내용 가져오기
	public List<CompanySerciceDto> getService(String bh_num);
	//추천수 증가
	public void likeUpdate(String b_num);
	//업체 서비스 등록
	public void serviceInsert(CompanySerciceDto comser);

	//업체 해당 파일 목록 가져오기
	public List<FileDto> getCfList(String bh_num);
	//조회수 증가2
	public void viewUpdate2(String bh_num);
	// 조회수 많은 게시글 목록 구하기
	public List<CommuntyDto> getBlist(int pageNum);
	// 조회수 많은 업체 목록 구하기
	public List<HostBoardDto> getRlist(int pageNum);
	//말머리별 게시글 목록 구하기
	public List<CommuntyDto> getDlist(Map<String, Integer> hmap);
	//업체  파일 등록 메소드
	public boolean fileInsert2(Map<String, String> fmap);
	//말머리별 게시글 개수 구하기
	public int getHeadCount(Integer head);

	//리뷰 목록 구하기
	public List<ReviewDto> getvList(int pageNum);

	//리뷰 저장 메소드
	public boolean reviewInsert(ReviewDto review);

	//리뷰 파일 저장 메소드
	public boolean fileInsert3(Map<String, String> fmap);

	//리뷰 내용 가져오기
	public ReviewDto getrvContents(String rv_num);

	//리뷰 해당 파일 목록 가져오기
	public List<FileDto> getRfList(String rv_num);

	//리뷰 해당 댓글 목록 가져오기
	public List<ReplyDto> getrvReplyList(String rv_num);

	//리뷰 댓글 저장 메소드
	public boolean replyInsert2(ReplyDto reply);

	//리뷰 해당 댓글 목록 가져오기
	public List<ReplyDto> getReplyList2(String rv_num);

	//리뷰 수정하기
	public boolean reviewUpdate(ReviewDto review);

	//리뷰 댓글 삭제
	public boolean replyDelete2(String rv_num);

	//리뷰의 파일 삭제(같은 게시물의 모든 파일 삭제)
	public boolean filesListDelete2(String rv_num);

	//리뷰 삭제
	public boolean reviewDelete(String rv_num);

	//리뷰 수정시 파일 삭제
	public boolean fileDelete2(String f_sysname);


}

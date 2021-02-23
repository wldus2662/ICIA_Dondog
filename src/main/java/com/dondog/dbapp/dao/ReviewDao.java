package com.dondog.dbapp.dao;

import java.util.List;

import com.dondog.dbapp.dto.ReviewDto;

public interface ReviewDao {
	//게시글 저장 메소드
	public boolean reviewInsert(ReviewDto review);
	//게시글 목록 불러오기 메소드
	public List<ReviewDto> getList(int pageNum);
	
}

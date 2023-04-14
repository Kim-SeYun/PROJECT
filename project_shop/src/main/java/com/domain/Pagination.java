package com.domain;

import lombok.Getter;

@Getter
public class Pagination {
	Criteria criteria;
	int startPage; // 시작페이지 버튼 번호
	int endPage; // 마지막페이지 버튼 번호
	int tempEndPage; // 실제 마지막페이지 버튼 번호
	int totalCount; // 총 게시물 수
	int displayPageNum = 5; // 화면이 보여질 페이지 버튼 수
	boolean prev; // 이전페이지 활성화여부
	boolean next; // 다음페이지 활성화여부
	
	public Pagination(Criteria criteria, int totalCount) {
		this.criteria = criteria;
		this.totalCount = totalCount;
		int pageNum = criteria.getPageNum();
		
		// 마지막 페이지 : 올림(페이지번호/displayNum) * displayNum
		endPage = (int)Math.ceil(pageNum/(double)displayPageNum)*displayPageNum;
		startPage = endPage - displayPageNum +1;
		tempEndPage = (int)Math.ceil(totalCount/(double)criteria.getAmount());
		prev = startPage != 1;
		next = endPage < tempEndPage;
		
		if(endPage > tempEndPage) endPage = tempEndPage;
	}

}

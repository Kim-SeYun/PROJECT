package com.domain;

import lombok.Getter;

@Getter
public class Pagination {
	Criteria criteria;
	int startPage; // 시작페이지 버튼 번호
	int endPage; // 마지막페이지 버튼 번호
	int tempEndPage; // 실제 마지막페이지 버튼 번호
	int totalCount; // 총 게시물 수
	int displayPageNum = 10; // 화면이 보여질 페이지 버튼 수
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
/*
 	displayPageNum = 10
 	1~10 : [1][2]...[9][10]
 		endPage = 10
 		startPage = 10-10+1
 		
 	11~20 : [11][12]...[19][20]
 		endPage = 20
 		startPage = 10-10+1
 	
 	21~30 : [21][22]...[29][30]
 		endPage = 30
 		startPage = 30(endPage) - 10(displayPageNum) +1
 
 */

}

/*
 	displayPageNum = 10
 	totalCount = 412
 	
 	1-10페이지 : 
 	[1][2][3]...[9][10][다음페이지]
	 	startPage = [1]
	 	endPage = [10]
	 	prev = false
	 	next = true
	 	
	 11-20페이지 : 
 	 [이전페이지][11][12][13]...[19][20][다음페이지]
	 	startPage = [11]
	 	endPage = [20]
	 	prev = true
	 	next = true
	 	
	  42페이지 : 
 	 [이전페이지][41][42][43]...[49][50][다음페이지]
	 	startPage = [41]
	 	endPage = [50]
	 	prev = true
	 	next = true
	 	
	 실제로 보여질 페이지
	 [이전페이지][41][42]
	 	startPage = [41]
	 	endPage = [42]
	 	prev = true
	 	next = false
 */
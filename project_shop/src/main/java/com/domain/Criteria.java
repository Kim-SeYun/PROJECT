package com.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class Criteria {
	int pageNum; // 현재페이지
	int amount; // 페이징게시물수(10)
	
	public Criteria() {
		this(1, 10); // 1페이지 10개씩 페이징
	}

}
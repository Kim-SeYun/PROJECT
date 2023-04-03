package com.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class OrderVO {
	private int order_id;
	private String id;
	private int pno;
	private int order_cnt;
	private String regDate;
	private String name;
	private String price;
	
	
}
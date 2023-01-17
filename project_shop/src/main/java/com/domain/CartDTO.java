package com.domain;

import java.util.Date;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder
@ToString
public class CartDTO {
	private int cart_id;
	private String id;
	private int pno;
	private int cart_cnt;
	private Date regdate;
	private String name;
	
}

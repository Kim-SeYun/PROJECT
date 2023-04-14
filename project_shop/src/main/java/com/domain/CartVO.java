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
public class CartVO {
	private int cart_id;
	private String id;
	private int pno;
	private int cart_cnt;
	private Date regdate;
	private int price;
	private String name;
	private String weight;
	private String imageFileName;

}
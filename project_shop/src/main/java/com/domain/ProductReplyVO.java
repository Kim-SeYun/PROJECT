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
public class ProductReplyVO {
	private int rno;
	private int pno;
	private String reply;
	private String writer;
	private Date replyDate;
	private Date modifyDate;

}

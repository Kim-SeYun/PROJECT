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
public class MemberVO {
	private int mno;
	private String id;
	private String pwd;
	private String pwdcheck;
	private String phone;
	private String name;
	private String email;
	private String year;
	private String month;
	private String day;
	private String gender;
	private String address;
	private Date joinDate;
	
	public enum MemberGrade {
		ROLE_ADMIN, ROLE_MEMBER
	}

}
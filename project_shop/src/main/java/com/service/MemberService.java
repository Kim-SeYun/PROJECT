package com.service;

import com.dao.MemberDao;
import com.domain.MemberVO;
import com.domain.MemberVO.MemberGrade;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class MemberService {
	
	private MemberDao dao;
	
	// 회원가입
	public void memberJoin(MemberVO vo) {
		dao.insertMember(vo);
	}
	
	// 로그인 체크
	public boolean loginService(MemberVO vo) {
		return dao.loginCheck(vo);
	}
	
	// 회원등급
	public MemberGrade getMemberGrade(String id) {
		return dao.findMemberGradeById(id);
	}
	
	public MemberVO memberInfo(String id) {
		return dao.findInfo(id);
	}
	
	
}
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
	
	// 아이디 중복 체크
	public boolean idCheckService(String id) {
		return dao.idCheck(id);
	}
	
	// 회원등급
	public MemberGrade getMemberGrade(String id) {
		return dao.findMemberGradeById(id);
	}
	
	// 마이페이지
	public MemberVO memberInfo(String id) {
		return dao.findInfo(id);
	}
	
	// 회원수정
	public void modMember(MemberVO vo) {
		dao.updateMember(vo);
	}

	public String findId(MemberVO vo) {
		return dao.findId(vo);
		
	}

	public boolean findPwd(MemberVO vo) {
		return dao.findPwd(vo);
	}

	public void doChangePwd(MemberVO vo) {
		dao.doChangePwd(vo);
	}

	public boolean checkInfo(MemberVO vo) {
		return dao.checkInfo(vo);
	}

}
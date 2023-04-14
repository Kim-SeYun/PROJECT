package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import com.common.ConnectionUtil;
import com.domain.CartVO;
import com.domain.MemberVO;
import com.domain.MemberVO.MemberGrade;

public class MemberDao {
	
private DataSource dataSource;
	
	public MemberDao() {
		dataSource = ConnectionUtil.getDataSource();
	}
	
	// 회원가입
	public void insertMember(MemberVO vo) {
		String query = "insert into shop_member(mno, id, pwd, name, phone, email, year, month, day, gender, address) VALUES(SHOP_MNO_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?,?)";
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getPhone());
			pstmt.setString(5, vo.getEmail());
			pstmt.setString(6, vo.getYear());
			pstmt.setString(7, vo.getMonth());
			pstmt.setString(8, vo.getDay());
			pstmt.setString(9, vo.getGender());
			pstmt.setString(10, vo.getAddress());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 회원정보 조회
	
	public MemberVO findInfo(String id) {
		MemberVO vo = null;
		String query = "SELECT * FROM SHOP_MEMBER where id=?";
		
		try (
				Connection conn = dataSource.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query);
			){
				pstmt.setString(1, id);
				try(ResultSet rs = pstmt.executeQuery();) {
					if(rs.next()) {
						vo = MemberVO.builder()
								.id(rs.getString("id"))
								.name(rs.getString("name"))
								.phone(rs.getString("phone"))
								.email(rs.getString("email"))
								.year(rs.getString("year"))
								.month(rs.getString("month"))
								.day(rs.getString("day"))
								.gender(rs.getString("gender"))
								.address(rs.getString("address"))
								.build();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return vo;
	}
	
	// 로그인 체크
	public boolean loginCheck(MemberVO vo) {
		boolean result = false;
		String query = "select decode(count(*),1,'TRUE','FALSE') as result from shop_member where id=? and pwd=?";
		
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPwd());
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) {
					result = Boolean.parseBoolean(rs.getString("result"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 아이디 중복확인
	public boolean idCheck(String id) {
		boolean result = false;
		String query = "select decode(count(*),1,'TRUE','FALSE') as result from shop_member where id=?";
		
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) {
					result = Boolean.parseBoolean(rs.getString("result"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 회원등급 조회
	public MemberGrade findMemberGradeById(String id) {
		MemberGrade grade = null;
		String query = "select grade from shop_member where id=?";
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);	
		){
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();) {
				if(rs.next()) grade = MemberGrade.valueOf(rs.getString("grade"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grade;
	}
	
	// 회원정보수정
	public void updateMember(MemberVO vo) {
		String query = "update SHOP_MEMBER set email=?, year=?, month=?, day=?, gender=?, address=? where id=?";		
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, vo.getEmail());
			pstmt.setString(2, vo.getYear());
			pstmt.setString(3, vo.getMonth());
			pstmt.setString(4, vo.getDay());
			pstmt.setString(5, vo.getGender());
			pstmt.setString(6, vo.getAddress());
			pstmt.setString(7, vo.getId());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 회원정보 조회
	public String findId(MemberVO vo) {
		String id = null;
		String query = "select id from shop_member where name=? and phone=?";
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);	
		){
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getPhone());
			try(ResultSet rs = pstmt.executeQuery();) {
				if(rs.next()) id = rs.getString("id");
				return id;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}
	
	public boolean findPwd(MemberVO vo) {
		boolean result = false;
		String query = "select decode(count(*),1,'TRUE','FALSE') as result from shop_member where id=? and phone=?";
		
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPhone());
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) {
					result = Boolean.parseBoolean(rs.getString("result"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public boolean checkInfo(MemberVO vo) {
		boolean result = false;
		String query = "select decode(count(*),1,'TRUE','FALSE') as result from shop_member where name=? and phone=?";
		
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getPhone());
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) {
					result = Boolean.parseBoolean(rs.getString("result"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public void doChangePwd(MemberVO vo) {
		String query = "update shop_member set pwd=? where id=?";
		try (
				Connection conn = dataSource.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query);
			){
				pstmt.setString(1, vo.getPwd());
				pstmt.setString(2, vo.getId());

				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}	
	}

		
}
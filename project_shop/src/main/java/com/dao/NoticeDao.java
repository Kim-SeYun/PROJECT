package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.common.ConnectionUtil;
import com.domain.NoticeVO;

public class NoticeDao {
	private DataSource dataSource;
	
	public NoticeDao() {
		dataSource = ConnectionUtil.getDataSource();
	}
	
	// 글목록
	public List<NoticeVO> selectAll() {
		String query = "select * from SHOP_NOTICE order by bno desc";
		List<NoticeVO> list = new ArrayList();
		try (
				Connection conn = dataSource.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query);
				ResultSet rs = pstmt.executeQuery();
			){
				while(rs.next()) {
					NoticeVO vo = NoticeVO.builder()
						.bno(rs.getInt("bno"))
						.title(rs.getString("title"))
						.content(rs.getString("content"))
						.writer(rs.getString("writer"))
						.writeDate(rs.getDate("writeDate"))
						.imageFileName(rs.getString("imageFileName"))
						.build();
					list.add(vo);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
	}
	
	// 글쓰기
	public int insertNotice(NoticeVO vo) {
		String query = "INSERT INTO SHOP_NOTICE(BNO, TITLE, CONTENT, WRITER, imageFileName) VALUES(?,?,?,?,?)";
		int noticeNo = getNewBno();
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setInt(1, noticeNo);
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getContent());
			pstmt.setString(4, vo.getWriter());
			pstmt.setString(5, vo.getImageFileName());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return noticeNo;
	}
	
	// 새로운 글번호 생성
	public int getNewBno() {
		int noticeNo = 0;
		String query = "SELECT MAX(BNO)+1 AS noticeNO FROM SHOP_NOTICE";
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
		){
			if(rs.next()) {
				noticeNo = rs.getInt("noticeNO");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return noticeNo;
	}
	
	// 글상세
	public NoticeVO selectOne(int bno) {
		NoticeVO vo = null;
		String query = "select * from SHOP_NOTICE where bno=?";
		try (
				Connection conn = dataSource.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query);
			){
				pstmt.setInt(1, bno);
				try(ResultSet rs = pstmt.executeQuery();) {
					if(rs.next()) {
						vo = NoticeVO.builder()
							.bno(rs.getInt("bno"))
							.title(rs.getString("title"))
							.content(rs.getString("content"))
							.writer(rs.getString("writer"))
							.writeDate(rs.getDate("writeDate"))
							.imageFileName(rs.getString("imageFileName"))
							.build();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		return vo;
	}
	
	// 글수정
	public void updateNotice(NoticeVO vo) {
		String imageFileName = vo.getImageFileName();
		int bno = vo.getBno();
		String query = "update SHOP_NOTICE set title=?, content=?";
		if(imageFileName!=null) { // 이미지 파일이 있을 때
			query+=",imageFileName=? where bno=?";
		} else { // 이미지 파일이 없을 때
			query+=" where bno=?";
		}
		
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
				
		){
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			if(imageFileName!=null) { // 이미지 파일이 있을 때
				pstmt.setString(3, imageFileName);
				pstmt.setInt(4, bno);
			} else { // 이미지 파일이 없을 때
				pstmt.setInt(3, bno);
			}
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 삭제 처리
	public void deleteNotice(int bno) {
		String query = "delete from SHOP_NOTICE where bno=?";
		try( 
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
				
		){
			pstmt.setInt(1, bno);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}

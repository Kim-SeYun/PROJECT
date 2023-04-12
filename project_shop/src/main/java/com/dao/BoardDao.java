package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.common.ConnectionUtil;
import com.domain.BoardVO;
import com.domain.Criteria;

public class BoardDao {
	
	private DataSource dataSource;
	
	public BoardDao() {
		dataSource = ConnectionUtil.getDataSource();
	}
	
	// 글목록
	public List<BoardVO> selectAll(Criteria criteria) {
		String query = "select rownum, bno, title, content, writer, writeDate, replyCount ";
		query += "from (select /*+index_desc(SHOP_BOARD pk)*/ rownum as rn, bno, title, content, writer, writeDate, replyCount ";
		query += "from SHOP_BOARD ";
		query += "where rownum<=?) where rn > ?";
		List<BoardVO> list = new ArrayList();
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			int maxRow = criteria.getPageNum()*criteria.getAmount();
			int minRow = (criteria.getPageNum() - 1) * criteria.getAmount();
			pstmt.setInt(1, maxRow);
			pstmt.setInt(2, minRow);
			try(ResultSet rs = pstmt.executeQuery();){
					while(rs.next()) {
						BoardVO vo = BoardVO.builder()
								.bno(rs.getInt("bno"))
								.title(rs.getString("title"))
								.content(rs.getString("content"))
								.writer(rs.getString("writer"))
								.writeDate(rs.getDate("writeDate"))
								.replyCount(rs.getInt("replyCount"))
								.build();
						list.add(vo);
					}
					
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getTotalCount() {
		String query = "select count(bno) as count from SHOP_BOARD";
		int totalcount = 0;
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
		){
			if(rs.next()) {
				totalcount = rs.getInt("count");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalcount;
	}
	
	// 글쓰기
	public int insertBoard(BoardVO vo) {
		String query = "INSERT INTO SHOP_BOARD(BNO, TITLE, CONTENT, WRITER, imageFileName) VALUES(?,?,?,?,?)";
		int boardNo = getNewBno();
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setInt(1, boardNo);
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getContent());
			pstmt.setString(4, vo.getWriter());
			pstmt.setString(5, vo.getImageFileName());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardNo;
	}
	
	// 새로운 글번호 생성
	public int getNewBno() {
		int boardNo = 0;
		String query = "SELECT MAX(BNO)+1 AS boardNO FROM SHOP_BOARD";
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
		){
			if(rs.next()) {
				boardNo = rs.getInt("boardNO");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardNo;
	}
	
	// 글상세
	public BoardVO selectOne(int bno) {
		BoardVO vo = null;
		String query = "select * from SHOP_BOARD where bno=?";
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setInt(1, bno);
			try(ResultSet rs = pstmt.executeQuery();) {
				if(rs.next()) {
					vo = BoardVO.builder()
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
	public void updateBoard(BoardVO vo) {
		String imageFileName = vo.getImageFileName();
		int bno = vo.getBno();
		String query = "update SHOP_BOARD set title=?, content=?";
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
	public void deleteBoard(int bno) {
		String query = "delete from SHOP_BOARD where bno=?";
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
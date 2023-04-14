package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.common.ConnectionUtil;
import com.domain.ProductDTO;
import com.domain.ProductReplyVO;
import com.domain.ProductVO;

public class ProductReplyDao {
	
	private DataSource dataSource;
	
	public ProductReplyDao() {
		dataSource = ConnectionUtil.getDataSource();
	}
	
	// 리뷰목록
	public List<ProductReplyVO> p_list(String name) {
		List<ProductReplyVO> p_list = new ArrayList<ProductReplyVO>();
		String query = "select SHOP_PRODUCT.name,SHOP_PRODUCT.pno, P_REPLY.rno, "
				+ "P_REPLY.reply, P_REPLY.writer, P_REPLY.replyDate, P_REPLY.modifyDate from SHOP_PRODUCT right OUTER JOIN P_REPLY on SHOP_PRODUCT.pno=P_REPLY.pno where name=?";
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, name);
			try(ResultSet rs = pstmt.executeQuery();) {
				while(rs.next()) {
					ProductReplyVO vo = ProductReplyVO.builder()
						.rno(rs.getInt("rno"))
						.pno(rs.getInt("pno"))
						.reply(rs.getString("reply"))
						.writer(rs.getString("writer"))
						.replyDate(rs.getDate("replyDate"))
						.modifyDate(rs.getDate("modifyDate"))
						.build();
					p_list.add(vo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return p_list;
	}
	
	public void write(ProductReplyVO vo) {
		String query = "insert into P_REPLY(rno, pno, reply, writer) values(P_REPLY_seq.nextval,?,?,?)";
		try (
				Connection conn = dataSource.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query);
			){
				pstmt.setInt(1, vo.getPno());
				pstmt.setString(2, vo.getReply());
				pstmt.setString(3, vo.getWriter());
				pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 리뷰삭제
	public void remove(ProductReplyVO vo) {
		String query = "delete from P_REPLY where rno=?";
		
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);	
		){
			pstmt.setInt(1, vo.getRno());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	public boolean prCheck(String id, int pno) {
		boolean result = false;
		String query = "SELECT DECODE(COUNT(*), 1, 'TRUE', 'FALSE') AS result FROM shop_prcheck WHERE id=? AND pno=?";
		
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, id);
			pstmt.setInt(2, pno);
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


	public void updateCommentCount(String id, int pno) {
	    String query1 = "SELECT COUNT FROM shop_prcheck WHERE id = ? AND pno = ?";
	    String query2 = "UPDATE shop_prcheck SET count = count - 1 WHERE id = ? AND pno = ?";
	    String query3 = "DELETE FROM shop_prcheck WHERE id = ? AND pno = ? AND count = 1";

	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement pstmt1 = conn.prepareStatement(query1);
	         PreparedStatement pstmt2 = conn.prepareStatement(query2);
	         PreparedStatement pstmt3 = conn.prepareStatement(query3)
	    ){

	        pstmt1.setString(1, id);
	        pstmt1.setInt(2, pno);
	        ResultSet rs = pstmt1.executeQuery();

	        if (rs.next()) {
	            int count = rs.getInt("COUNT");

	            if (count == 1) {
	                pstmt3.setString(1, id);
	                pstmt3.setInt(2, pno);
	                pstmt3.executeUpdate();
	            } else if (count > 1) {
	                pstmt2.setString(1, id);
	                pstmt2.setInt(2, pno);
	                pstmt2.executeUpdate();
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}



}

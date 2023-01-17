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
	public List<ProductReplyVO> p_list(String id) {
		List<ProductReplyVO> p_list = new ArrayList<ProductReplyVO>();
		String query = "select SHOP_PRODUCT.name,SHOP_PRODUCT.pno, P_REPLY.rno, "
				+ "P_REPLY.reply, P_REPLY.writer, P_REPLY.replyDate, P_REPLY.modifyDate from SHOP_PRODUCT right OUTER JOIN P_REPLY on SHOP_PRODUCT.pno=P_REPLY.pno where id=?";
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, id);
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

}

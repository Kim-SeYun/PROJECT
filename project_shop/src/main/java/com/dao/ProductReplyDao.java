package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.common.ConnectionUtil;
import com.domain.ProductReplyVO;
import com.domain.ProductVO;

public class ProductReplyDao {
	
	private DataSource dataSource;
	
	public ProductReplyDao() {
		dataSource = ConnectionUtil.getDataSource();
	}
	
	
	
	public List<ProductReplyVO> p_list(ProductVO productVO) {
		List<ProductReplyVO> p_list = new ArrayList<ProductReplyVO>();
		String query = "select SHOP_PRODUCT.name, P_REPLY.rno, P_REPLY.reply, P_REPLY.writer, P_REPLY.replyDate, P_REPLY.modifyDate from SHOP_PRODUCT right OUTER JOIN P_REPLY on SHOP_PRODUCT.pno=P_REPLY.pno where name=?";
		
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, productVO.getName());
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

}
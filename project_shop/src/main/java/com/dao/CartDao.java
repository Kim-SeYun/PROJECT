package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.common.ConnectionUtil;
import com.domain.CartVO;

public class CartDao {
	
	private DataSource dataSource;
	
	public CartDao() {
		dataSource = ConnectionUtil.getDataSource();
	}
	
	public List<CartVO> allList(String id){
		String query = "select M.id, p.Name, c.CART_CNT, p.price from shop_cart C inner join shop_product P on P.pno = C.pno inner join shop_member M on C.ID = M.ID where m.id=?";
		List<CartVO> list = new ArrayList<CartVO>();
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				
				while(rs.next()) {
					CartVO vo = CartVO.builder()
							.cart_id(rs.getInt("cart_id"))
							.pno(rs.getInt("pno"))
							.cart_cnt(rs.getInt("cart_cnt"))
							.regdate(rs.getDate("regdate"))
							.build();
					list.add(vo);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

}

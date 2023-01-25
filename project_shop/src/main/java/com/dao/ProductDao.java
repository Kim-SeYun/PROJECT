package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.common.ConnectionUtil;
import com.domain.Category;
import com.domain.ProductVO;

public class ProductDao {
	
private DataSource dataSource;
	
	public ProductDao() {
		dataSource = ConnectionUtil.getDataSource();
	}
	
	// 상품목록
		public List<ProductVO> selectAll() {
			String query = "select * from SHOP_PRODUCT order by pno desc";
			List<ProductVO> list = new ArrayList();
			try (
					Connection conn = dataSource.getConnection();
					PreparedStatement pstmt = conn.prepareStatement(query);
					ResultSet rs = pstmt.executeQuery();
				){
					while(rs.next()) {
						ProductVO vo = ProductVO.builder()
								.pno(rs.getInt("pno"))
								.name(rs.getString("name"))
								.price(rs.getInt("price"))
								.info(rs.getString("info"))
							.build();
						list.add(vo);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list;
		}
		
		// 상품상세
		public ProductVO selectOne(String name) {
			ProductVO vo = null;
			String query = "select * from SHOP_PRODUCT where name=?";
			try (
					Connection conn = dataSource.getConnection();
					PreparedStatement pstmt = conn.prepareStatement(query);
				){
					pstmt.setString(1, name);
					try(ResultSet rs = pstmt.executeQuery();) {
						if(rs.next()) {
							vo = ProductVO.builder()
								.pno(rs.getInt("pno"))
								.name(rs.getString("name"))
								.price(rs.getInt("price"))
								.info(rs.getString("info"))
								.weight(rs.getString("weight"))
								.cid(rs.getString("cid"))
								.build();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return vo;
			
		}
		
		// 카테고리
//		public List<Category> categoryList(String cid){
//			String query = "select p.pno, c.cname, p.NAME, p.PRICE, p.INFO, p.WEIGHT from SHOP_PRODUCT  p inner join shop_category c on c.cid = p.cid where c.cid=?";
//			List<Category> categoryList = new ArrayList<Category>();
//			
//			try (
//				Connection conn = dataSource.getConnection();
//				PreparedStatement pstmt = conn.prepareStatement(query);
//			){
//				pstmt.setString(1, cid);
//				pstmt.executeUpdate();
//				try(ResultSet rs = pstmt.executeQuery();){
//					while(rs.next()) {
//						Category category = Category.builder()
//								.cid(rs.getString("cid"))
//								.cname(rs.getString("cname"))
//								.build();
//						categoryList.add(category);
//					}
//				}
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			return categoryList;
//		}
		
		public List<Category> categoryList(){
			String query = "select * from shop_category";
			List<Category> categoryList = new ArrayList<Category>();
			
			try (
				Connection conn = dataSource.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query);
				ResultSet rs = pstmt.executeQuery();
			){
				while(rs.next()) {
					Category category = Category.builder()
							.cid(rs.getString("cid"))
							.cname(rs.getString("cname"))
							.build();
					categoryList.add(category);
				}
			
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return categoryList;
		}
		
		

}
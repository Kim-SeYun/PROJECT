package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		
		// 상품 상세
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
		
//		public List<Category> categoryList(){
//			String query = "select * from shop_category";
//			List<Category> categoryList = new ArrayList<Category>();
//			
//			try (
//				Connection conn = dataSource.getConnection();
//				PreparedStatement pstmt = conn.prepareStatement(query);
//				ResultSet rs = pstmt.executeQuery();
//			){
//				while(rs.next()) {
//					Category category = Category.builder()
//							.cid(rs.getString("cid"))
//							.cname(rs.getString("cname"))
//							.build();
//					categoryList.add(category);
//				}
//			
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			return categoryList;
//		}
		
		public Map<String, List<?>> categoryList(String cid){
			String query = "select * from shop_category";
			String query2 = "select p.pno, c.cname, p.NAME, p.PRICE, p.INFO, p.WEIGHT from SHOP_PRODUCT  p inner join shop_category c on c.cid = p.cid where c.cid=?";
			Map<String, List<?>> map = new HashMap<String, List<?>>();
			List<Category> categoryList = new ArrayList<Category>();
			List<ProductVO> productList = new ArrayList<>();
			
			try(Connection conn = dataSource.getConnection();){
				try (
						PreparedStatement pstmt = conn.prepareStatement(query);
						PreparedStatement pstmt2 = conn.prepareStatement(query2);
				){
					conn.setAutoCommit(false);
					
					pstmt2.setString(1, cid);
					try(ResultSet rs = pstmt2.executeQuery()){
						while(rs.next()) {
							ProductVO vo = ProductVO.builder()
									.pno(rs.getInt("pno"))
									.name(rs.getString("name"))
									.price(rs.getInt("price"))
									.info(rs.getString("info"))
									.weight(rs.getString("weight"))
									.cname(rs.getString("cname")).build();
							productList.add(vo);
						}
					}
					
					try(ResultSet rs = pstmt.executeQuery();){
						while(rs.next()) {
							Category category = Category.builder()
									.cid(rs.getString("cid"))
									.cname(rs.getString("cname"))
									.build();
							categoryList.add(category);
						}
					}
					map.put("categoryList", categoryList);
					map.put("productList", productList);
					conn.commit();
				} catch (Exception e) {
					conn.rollback();
					e.printStackTrace();
				} finally {
					conn.setAutoCommit(true);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return map;
		}
		
		public void addProduct(ProductVO vo) {
			String query = "insert into shop_product(pno, name, price, info, weight, cid, imageFileName) values(SHOP_PNO_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?)";
			try (
					Connection conn = dataSource.getConnection();
					PreparedStatement pstmt = conn.prepareStatement(query);
				){
					pstmt.setString(1, vo.getName());
					pstmt.setInt(2, vo.getPrice());
					pstmt.setString(3, vo.getInfo());
					pstmt.setString(4, vo.getWeight());
					pstmt.setString(5, vo.getCid());
					pstmt.setString(6, vo.getImageFileName());
					pstmt.executeUpdate();
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			
		}
		


		
		
		
		
		
		

}
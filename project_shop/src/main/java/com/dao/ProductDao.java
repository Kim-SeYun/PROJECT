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
import com.domain.ProductReplyVO;
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
								.weight(rs.getString("weight"))
								.cid(rs.getString("cid"))
								.imageFileName(rs.getString("imageFileName"))
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
								.imageFileName(rs.getString("imageFileName"))
								.build();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return vo;
			
		}
		

		
		public Map<String, List<?>> categoryList(String cid){
			String query = "select * from shop_category";
			String query2 = "select p.pno, c.cname, p.NAME, p.PRICE, p.INFO, p.WEIGHT, p.imageFileName from SHOP_PRODUCT  p inner join shop_category c on c.cid = p.cid where c.cid=?";
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
									.imageFileName(rs.getString("imageFileName"))
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
		
		public int addProduct(ProductVO vo) {
		    String query = "insert into shop_product(pno, name, price, info, weight, cid, imageFileName) values(SHOP_PNO_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?)";
		    int productNo = 0;
		    
		    try (Connection conn = dataSource.getConnection();
		         PreparedStatement pstmt = conn.prepareStatement(query)) {
		        pstmt.setString(1, vo.getName());
		        pstmt.setInt(2, vo.getPrice());
		        pstmt.setString(3, vo.getInfo());
		        pstmt.setString(4, vo.getWeight());
		        pstmt.setString(5, vo.getCid());
		        pstmt.setString(6, vo.getImageFileName());
		        pstmt.executeUpdate();
		        
		        // 시퀀스 값을 가져와서 변수에 저장
		        String selectSeqQuery = "SELECT SHOP_PNO_SEQ.CURRVAL AS PRODUCT_NO FROM DUAL";
		        try (PreparedStatement selectStmt = conn.prepareStatement(selectSeqQuery)) {
		            ResultSet rs = selectStmt.executeQuery();
		            if (rs.next()) {
		                productNo = rs.getInt("PRODUCT_NO");
		            }
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    
		    return productNo;
		}


		public void remove(int pno) {
			String query = "delete from shop_product where pno=?";
			try (
					Connection conn = dataSource.getConnection();
					PreparedStatement pstmt = conn.prepareStatement(query);	
					){
					pstmt.setInt(1, pno);
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		
		public void modProduct(ProductVO vo) {
			String imageFileName = vo.getImageFileName();
			int pno = vo.getPno();
			String query = "update shop_product set price=?, info=?";
			String query2 = "update shop_cart set price=?";
			String query3 = "";
			if(imageFileName!=null) {
				query += ",imageFileName=? where pno=?";
				query2 += ",imageFileName=? where pno=?";
				query3 += "update shop_order set imageFileName=? where pno=?";
			} else {
				query += "where pno=?";
				query2 += "where pno=?";
			}
			try (
				Connection conn = dataSource.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query);
				PreparedStatement pstmt2 = conn.prepareStatement(query2);
				PreparedStatement pstmt3 = imageFileName != null ? conn.prepareStatement(query3) : null;
				
			){
				pstmt.setInt(1, vo.getPrice());
				pstmt.setString(2, vo.getInfo());
				pstmt2.setInt(1, vo.getPrice());
				
				if(imageFileName!=null) {
					pstmt.setString(3, imageFileName);
					pstmt.setInt(4, pno);
					pstmt2.setString(2, imageFileName);
					pstmt2.setInt(3, pno);
					pstmt3.setString(1, imageFileName);
					pstmt3.setInt(2, pno);
					pstmt3.executeUpdate();
					
				} else {
					pstmt.setInt(3, pno);
					pstmt2.setInt(2, pno);
				}
				pstmt.executeUpdate();
				pstmt2.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		

}
package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.common.ConnectionUtil;
import com.domain.CartVO;
import com.domain.OrderVO;

public class CartDao {
	
	private DataSource dataSource;
	
	public CartDao() {
		dataSource = ConnectionUtil.getDataSource();
	}
	
	public List<CartVO> allList(String id){
		String query = "select M.id, p.Name, c.CART_CNT, p.price, p.pno, p.imageFileName from shop_cart C inner join shop_product P on P.pno = C.pno inner join shop_member M on C.ID = M.ID where m.id=?";
		List<CartVO> list = new ArrayList<CartVO>();
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				
				while(rs.next()) {
					CartVO vo = CartVO.builder()
							.id(rs.getString("id"))
							.pno(rs.getInt("pno"))
							.name(rs.getString("name"))
							.price(rs.getInt("price"))
							.cart_cnt(rs.getInt("cart_cnt"))
							.imageFileName(rs.getString("imageFileName"))
							.build();
					list.add(vo);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public boolean checkCart(CartVO vo) {
		boolean result = false;
		String query = "select decode(count(*),1,'TRUE','FALSE') as result from shop_cart where id=? and pno=?";
		
		try (
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			pstmt.setString(1, vo.getId());
			pstmt.setInt(2, vo.getPno());
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
	
	public void addCart(CartVO vo) {
		String query = "INSERT INTO SHOP_CART(CART_ID, ID, PNO, CART_CNT) VALUES(SHOP_CART_ID_SEQ.NEXTVAL, ?, ?, ?)";
		String query2 = "update SHOP_CART set CART_CNT = CART_CNT+? where id=? and pno=?";
		try(Connection conn = dataSource.getConnection();){
			try (
				PreparedStatement pstmt = conn.prepareStatement(query);
				PreparedStatement pstmt2 = conn.prepareStatement(query2);
			){
				conn.setAutoCommit(false);
				if(checkCart(vo) == false) {
					pstmt.setString(1, vo.getId());
					pstmt.setInt(2, vo.getPno());
					pstmt.setInt(3, vo.getCart_cnt());
					pstmt.executeUpdate();
					conn.commit();
				
				} else {
					pstmt2.setInt(1, vo.getCart_cnt());
					pstmt2.setString(2, vo.getId());
					pstmt2.setInt(3, vo.getPno());
					pstmt2.executeUpdate();
					conn.commit();
				}
				
			} catch (Exception e) {
				conn.rollback();
				e.printStackTrace();
			} finally {
				conn.setAutoCommit(true);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void delAllCart(String id) {
		String query = "delete from shop_cart where id=?";
		try( 
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
				
		){
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void delCheckCart(String id, String[] list) {
		String query = "delete from shop_cart where id=? and pno=?";
		try( 
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
		){
			for(int i=0; i<list.length; i++) {
				int pno = Integer.parseInt(list[i]);
				pstmt.setString(1, id);
				pstmt.setInt(2, pno);
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateCount(CartVO vo) {
		String query = "update shop_cart set cart_cnt = ? where id=? and pno=?";
		try( 
			Connection conn = dataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);
			){
			
				pstmt.setInt(1, vo.getCart_cnt());
				pstmt.setString(2, vo.getId());
				pstmt.setInt(3, vo.getPno());
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}		
		
	}
	
	public void orderCheck(String id, String[] list) {
		String query1 = "insert into shop_order(order_id, id, pno, order_cnt) values(shop_order_seq.nextval, ?, ? , (SELECT CART_CNT FROM SHOP_CART WHERE ID = ? AND PNO = ?))";
		String query2 = "delete from shop_cart where id=? and pno=?";
		try(Connection conn = dataSource.getConnection();){
			try (
					PreparedStatement pstmt = conn.prepareStatement(query1);
					PreparedStatement pstmt2 = conn.prepareStatement(query2);
			){
				for(int i=0; i<list.length; i++) {
					int pno = Integer.parseInt(list[i]);
					
					conn.setAutoCommit(false);
					pstmt.setString(1, id);
					pstmt.setInt(2, pno);
					pstmt.setString(3, id);
					pstmt.setInt(4, pno);
					pstmt.executeUpdate();
					
					pstmt2.setString(1, id);
					pstmt2.setInt(2, pno);
					pstmt2.executeUpdate();
					conn.commit();
				}
			} catch (Exception e) {
				conn.rollback();
				e.printStackTrace();
			} finally {
				conn.setAutoCommit(true);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	public List<OrderVO> orderList(String id) {
		List<OrderVO> list = new ArrayList<>();
		String query = "SELECT M.id, P.pno, P.name, SUM(O.order_cnt) AS order_cnt, P.price, p.imageFileName," +
	    	    "TO_CHAR(O.regDate, 'YYYY-MM-DD HH24:MI:SS') AS regDate " +
	    	    "FROM SHOP_ORDER O " +
	    	    "INNER JOIN shop_product P ON P.pno = O.pno " +
	    	    "INNER JOIN shop_member M ON O.id = M.id " +
	    	    "WHERE M.id = ? " +
	    	    "GROUP BY M.id, P.pno, P.name, P.price, p.imageFileName, TO_CHAR(O.regDate, 'YYYY-MM-DD HH24:MI:SS') " +
	    	    "ORDER BY regDate DESC";
		try (
				Connection conn = dataSource.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query);
			){
				pstmt.setString(1, id);
				try(ResultSet rs = pstmt.executeQuery();) {
					while(rs.next()) {
						OrderVO vo = OrderVO.builder()
								.id(rs.getString("id"))
								.pno(rs.getInt("pno"))
								.name(rs.getString("name"))
								.order_cnt(rs.getInt("order_cnt"))
								.price(rs.getString("price"))
								.regDate(rs.getString("regDate"))
								.imageFileName(rs.getString("imageFileName"))
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

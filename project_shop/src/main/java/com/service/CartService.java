package com.service;

import java.util.List;

import com.dao.CartDao;
import com.domain.CartVO;
import com.domain.OrderVO;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class CartService {
	
	private CartDao dao;
	
	public List<CartVO> cartList(String id){
		return dao.allList(id);
	}
	
	public void addCart(CartVO vo) {
		dao.addCart(vo);
	}
	
	public void delAllCart(String id) {
		dao.delAllCart(id);
	}
	
	public void delCheckCart(String id, String[] list) {
		dao.delCheckCart(id, list);
	}
	
	public void updateCount(CartVO vo) {
		dao.updateCount(vo);
	}
	
	public void orderCheck(String id, String[] list) {
		dao.orderCheck(id, list);
	}

	public List<OrderVO> orderList(String id) {
		return dao.orderList(id);
	}

}

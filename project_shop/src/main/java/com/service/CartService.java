package com.service;

import java.util.List;

import com.dao.CartDao;
import com.domain.CartVO;

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

}

package com.service;

import java.util.List;

import com.dao.ProductDao;
import com.domain.BoardVO;
import com.domain.ProductVO;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class ProductService {
	
	private ProductDao dao;

	public List<ProductVO> productList() {
		return dao.selectAll();
	}
	
	public ProductVO findProduct(String name) {
		return dao.selectOne(name);
	}


}
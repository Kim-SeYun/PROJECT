package com.service;

import java.util.List;
import java.util.Map;

import com.dao.ProductDao;
import com.domain.Category;
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

	public Map<String, List<?>> categoryList(String cid){
		return dao.categoryList(cid);
	}
	
	public int addProduct(ProductVO vo) {
	   return dao.addProduct(vo);
	}

	public void remove(int pno) {
		dao.remove(pno);
	}

	public void modProduct(ProductVO vo) {
		dao.modProduct(vo);
	}

}
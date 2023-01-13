package com.service;

import java.util.List;

import com.dao.ProductReplyDao;
import com.domain.ProductReplyVO;

public class ProductReplyService{
	private ProductReplyDao dao;
	
	public ProductReplyService(ProductReplyDao dao) {
		this.dao = dao;
	}
	
	public List<ProductReplyVO> list(String name) {
		return dao.p_list(name);
	}
	
	public void writer(ProductReplyVO vo) {
		dao.write(vo);
	}
}

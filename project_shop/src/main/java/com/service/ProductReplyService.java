package com.service;

import java.util.List;

import com.dao.ProductReplyDao;
import com.domain.ProductReplyVO;
import com.domain.ProductVO;
import com.domain.ReplyVO;

public class ProductReplyService {
	
	private ProductReplyDao dao;
	
	public ProductReplyService(ProductReplyDao dao) {
		this.dao = dao;
	}
	
	public List<ProductReplyVO> list(ProductVO productVO) {
		return dao.p_list(productVO);
	}
	


}

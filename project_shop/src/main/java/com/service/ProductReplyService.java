package com.service;

import java.util.List;

import com.dao.ProductReplyDao;
import com.domain.ProductDTO;
import com.domain.ProductReplyVO;
import com.domain.ProductVO;
import com.domain.ReplyVO;

public class ProductReplyService {
	
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
	
	public void remove(ProductReplyVO vo) {
		dao.remove(vo);
	}

	public boolean prCheck(String id, int pno) {
	    return dao.prCheck(id, pno);
	}

	public void updateCommentCount(String id, int pno) {
		dao.updateCommentCount(id, pno);
	}
		
}

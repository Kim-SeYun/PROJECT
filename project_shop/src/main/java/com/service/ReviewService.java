package com.service;

import java.util.List;

import com.dao.ReviewDao;
import com.domain.ProductDTO;
import com.domain.ReviewVO;
import com.domain.ProductVO;
import com.domain.ReplyVO;

public class ReviewService {
	
	private ReviewDao dao;
	
	public ReviewService(ReviewDao dao) {
		this.dao = dao;
	}
	
	public List<ReviewVO> list(String name) {
		return dao.p_list(name);
	}
	
	public void writer(ReviewVO vo) {
		dao.write(vo);
	}
}

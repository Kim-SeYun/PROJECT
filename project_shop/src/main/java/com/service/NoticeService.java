package com.service;

import java.util.List;

import com.dao.NoticeDao;
import com.domain.Criteria;
import com.domain.NoticeVO;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class NoticeService {
	
	private NoticeDao dao;
	
	public List<NoticeVO> noticeList(Criteria criteria) {
		return dao.selectAll(criteria);
	}
	
	public NoticeVO findNotice(int bno) {
		return dao.selectOne(bno);
	}
	
	public int addNotice(NoticeVO vo) {
		return dao.insertNotice(vo);
	}
	
	public void modNotice(NoticeVO vo) {
		dao.updateNotice(vo);
	}
	
	public void removeNotice(int bno) {
		dao.deleteNotice(bno);
	}
	
}
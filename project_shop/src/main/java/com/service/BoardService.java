package com.service;

import java.util.List;

import com.dao.BoardDao;
import com.domain.BoardVO;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class BoardService {

	private BoardDao dao;

	public List<BoardVO> boardList() {
		return dao.selectAll();
	}
	
	public int addBoard(BoardVO vo) {
		return dao.insertBoard(vo);
	}
	
	public BoardVO findBoard(int bno) {
		return dao.selectOne(bno);
	}
	
	public void modBoard(BoardVO vo) {
		dao.updateBoard(vo);
	}
	
	public void removeBoard(int bno) {
		dao.deleteBoard(bno);
	}
}

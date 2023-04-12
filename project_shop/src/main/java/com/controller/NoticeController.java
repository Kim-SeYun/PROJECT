package com.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.common.FileUpload;
import com.dao.NoticeDao;
import com.domain.Criteria;
import com.domain.NoticeVO;
import com.domain.Pagination;
import com.service.NoticeService;

@WebServlet("/notice/*")
public class NoticeController extends HttpServlet {
	
	private NoticeService service;
	private FileUpload multiReq;
	
	@Override
	public void init() throws ServletException {
		NoticeDao dao = new NoticeDao();
		service = new NoticeService(dao);
		multiReq = new FileUpload("notice/");
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		String contextPath = request.getContextPath();
		final String PRIFIX = "/WEB-INF/views/notice/";
		final String SUFFIX = ".jsp";
		
		RequestDispatcher rd = null;
		String nextPage = null;
		
		// 글목록
		if(pathInfo==null || pathInfo.equals("/") || pathInfo.equals("/list")) {
			Criteria criteria = new Criteria();
			NoticeDao dao = new NoticeDao();
			String paramPageNum = request.getParameter("pageNum");
			if(paramPageNum != null) {
				criteria.setPageNum(Integer.parseInt(paramPageNum));
			}
			List<NoticeVO> noticeList = service.noticeList(criteria);
			int totalCount = dao.getTotalCount();
			Pagination pagination = new Pagination(criteria, totalCount);
			request.setAttribute("p", pagination);
			request.setAttribute("list", noticeList);
			nextPage = "list";
		}
		

		
		// 글상세	
		else if(pathInfo.equals("/detail")) {
			String parambno = request.getParameter("bno");
			int bno = Integer.parseInt(parambno);
			NoticeVO notice = service.findNotice(bno);
			request.setAttribute("notice", notice);
			nextPage = "detail";
		}
		
		// 글쓰기폼
		else if(pathInfo.equals("/writeForm")) {
			nextPage = "writeForm";
		}
		
		// 글쓰기처리
		else if(pathInfo.equals("/write")) {
			Map<String, String> req = multiReq.getMultipartRequest(request);
			String imageFileName = req.get("imageFileName");
			
			NoticeVO vo = NoticeVO.builder()
					.title(req.get("title"))
					.content(req.get("content"))
					.writer(req.get("writer"))
					.imageFileName(req.get("imageFileName"))
					.build();
			int noticeNO = service.addNotice(vo);

			// 이미지파일을 첨부한 경우
			if(imageFileName!=null && imageFileName.length()>0) {
				multiReq.uploadImage(noticeNO, imageFileName);
			}
			response.sendRedirect(contextPath+"/notice");
			return;
		}
		
		// 글수정 처리
		else if(pathInfo.equals("/modNotice")) {
			Map<String, String> req = multiReq.getMultipartRequest(request);
			String paramBno = req.get("bno");
			int bno = Integer.parseInt(paramBno);
			String title = req.get("title");
			String content = req.get("content");
			String imageFileName = req.get("imageFileName");
			String pageNum = req.get("pageNum");
			
			NoticeVO vo = NoticeVO.builder()
					.bno(bno)
					.title(title)
					.content(content)
					.imageFileName(imageFileName)
					.build();
			service.modNotice(vo);
			
			if(imageFileName!=null) { // 이미지 파일이 있을 때
				String originFileName = req.get("originFileName");
				// 새로운 이미지 업로드
				multiReq.uploadImage(bno, imageFileName);
				// 기존 이미지 삭제
				if(originFileName!=null) {
					multiReq.deleteOriginImage(bno, originFileName);
				}
			} 
			response.sendRedirect(contextPath+"/notice/detail?bno=" + bno +"&pageNum=" + pageNum);
			return;
		}
		
		// 글삭제 처리
		else if(pathInfo.equals("/removeNotice")) {
			Map<String, String> req = multiReq.getMultipartRequest(request);
			String paramBno = req.get("bno");
			int bno = Integer.parseInt(paramBno);
			service.removeNotice(bno);
			multiReq.deleteAllImage(bno);
			response.sendRedirect(contextPath+"/notice");
			return;
		}
		
		else {
			System.out.println("존재하지 않는 페이지");
		}
		
		rd = request.getRequestDispatcher(PRIFIX+nextPage+SUFFIX);
		rd.forward(request, response);
	}
	

}
package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.ReviewDao;
import com.domain.ReviewVO;
import com.google.gson.Gson;
import com.service.ReviewService;

@WebServlet("/productReply/*")
public class ReviewController extends HttpServlet{
	
	private ReviewService service;
	private ReviewService service2;
	private Gson gson;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		ServletContext sc = config.getServletContext();
		//service = (ProductReplyService) sc.getAttribute("productReplyService");
		service = new ReviewService(new ReviewDao());
		service2 = (ReviewService) sc.getAttribute("productReplyService");
		gson = new Gson();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		String pathInfo = request.getPathInfo();
		String contextPath = request.getContextPath();
		
		if(pathInfo.equals("/list")) {
			String name = request.getParameter("name");
			List<ReviewVO> list = service.list(name);
			out.print(gson.toJson(list));
		}
		else if(pathInfo.equals("/write")) {
			String paramPno = request.getParameter("pno");
			System.out.println(paramPno);
			
			long currentTime = System.currentTimeMillis();
			HttpSession session = request.getSession(false);
			if(session.getAttribute("lastWriting")!=null) { // 마지막에 글을 쓴 시간이 있다면
				long lastWriting = (long) session.getAttribute("lastWriting");
				if(currentTime-lastWriting < 10000) {
					out.print(gson.toJson("도배하지마세요"));
					return;
				}
			}
			// 마지막에 글을 쓴 시간이 없다면
			session.setAttribute("lastWriting", currentTime);
			
			ReviewVO vo = ReviewVO.builder()
							.pno(Integer.parseInt("pno"))
							.reply(request.getParameter("reply"))
							.writer(request.getParameter("writer"))
							.build();
			System.out.println(paramPno);
			service.writer(vo);
			String result = gson.toJson("댓글 등록 성공");
			out.print(result);
		}
	}
}

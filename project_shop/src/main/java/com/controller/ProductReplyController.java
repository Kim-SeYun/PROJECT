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

import com.dao.ProductReplyDao;
import com.domain.ProductReplyVO;
import com.google.gson.Gson;
import com.service.ProductReplyService;

@WebServlet("/productReply/*")
public class ProductReplyController extends HttpServlet{
	
	private ProductReplyService service;
	private Gson gson;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		ServletContext sc = config.getServletContext();
		//service = (ProductReplyService) sc.getAttribute("productReplyService");
		service = new ProductReplyService(new ProductReplyDao());
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
			List<ProductReplyVO> list = service.list(name);
			out.print(gson.toJson(list));
		}
		
		else if(pathInfo.equals("/write")) {
			String paramPno = request.getParameter("pno");
			
			long currentTime = System.currentTimeMillis();
			HttpSession session = request.getSession(false);
			if(session.getAttribute("lastWriting")!=null) {
				long lastWriting = (long) session.getAttribute("lastWriting");
				if(currentTime-lastWriting < 10000) {
					out.print(gson.toJson("도배금지"));
					return;
				}
			}
			
			session.setAttribute("lastWriting", currentTime);
			
			ProductReplyVO vo = ProductReplyVO.builder()
							.pno(Integer.parseInt(paramPno))
							.reply(request.getParameter("reply"))
							.writer(request.getParameter("writer"))
							.build();

			service.writer(vo);
			String result = gson.toJson("댓글 등록 성공");
			out.print(result);
		}
		else if(pathInfo.equals("/remove")) {
			String paramRno = request.getParameter("rno");
			ProductReplyVO vo = ProductReplyVO.builder()
					.rno(Integer.parseInt(paramRno))
					.build();
			
			service.remove(vo);
			String result = gson.toJson("댓글 삭제 성공");
			out.print(result);
		}
	}
	
	
}

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

import com.dao.ProductReplyDao;
import com.domain.ProductDTO;
import com.domain.ProductReplyVO;
import com.domain.ProductVO;
import com.google.gson.Gson;
import com.service.ProductReplyService;
import com.service.ReplyService;

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
	}
}

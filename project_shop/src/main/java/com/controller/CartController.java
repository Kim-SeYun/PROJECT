package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;

import com.dao.CartDao;
import com.domain.CartVO;
import com.google.gson.Gson;
import com.service.CartService;


@WebServlet("/cart/*")
public class CartController extends HttpServlet {
       
	private CartService service;
	private Gson gson;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		ServletContext sc = config.getServletContext();
		CartDao dao = new CartDao();
		service = new CartService(dao);
		gson = new Gson();
	}
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		String pathInfo = request.getPathInfo();
		String contextPath = request.getContextPath();
		final String PRIFIX = "/WEB-INF/views/cart/";
		final String SUFFIX = ".jsp";
		
		RequestDispatcher rd = null;
		String nextPage = null;
		
		// 카트목록
		if(pathInfo.equals("/list")) {
			String id = request.getParameter("id");
			System.out.println(id);
			List<CartVO> cartList = service.cartList(id);
			request.setAttribute("list", cartList);
			out.print(gson.toJson(cartList));
			nextPage = "list";
		}
		else {
			System.out.println("페이지를 찾을 수 없음");
			return;
		}
		
		rd = request.getRequestDispatcher(PRIFIX+nextPage+SUFFIX);
		rd.forward(request, response);
	}

}

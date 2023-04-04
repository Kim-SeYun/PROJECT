package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.common.FileUpload;
import com.dao.ProductDao;
import com.domain.ProductVO;
import com.google.gson.Gson;
import com.service.ProductService;

@WebServlet("/product/*")
public class ProductController extends HttpServlet {
	
	private ProductService service;
	private FileUpload multiReq;
	private Gson gson;
	
	@Override
	public void init() throws ServletException {
		ProductDao dao = new ProductDao();
		service = new ProductService(dao);
		multiReq = new FileUpload("product/");
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
		String pathInfo = request.getPathInfo();
		String contextPath = request.getContextPath();
		PrintWriter out = response.getWriter();
		final String PRIFIX = "/WEB-INF/views/product/";
		final String SUFFIX = ".jsp";
		
		RequestDispatcher rd = null;
		String nextPage = null;
		
		// 상품목록
		if(pathInfo==null || pathInfo.equals("/") || pathInfo.equals("/list")) {
			List<ProductVO> productList = service.productList();
			request.setAttribute("list", productList);
			String cid = request.getParameter("cid");
			Map<String, List<?>> map = service.categoryList(cid);
			request.setAttribute("category", map.get("categoryList"));
			request.setAttribute("products", map.get("productList"));
			nextPage = "list";
		}
		
		// 상품상세
		else if(pathInfo.equals("/detail")) {
			String name = request.getParameter("name");
			ProductVO product = service.findProduct(name);
			request.setAttribute("product", product);
			nextPage = "detail";
		}
		
		// 베스트상품
		else if(pathInfo.equals("/best")) {
			nextPage = "best";
		}
		
		// 세일상품
		else if(pathInfo.equals("/sale")) {
			nextPage = "sale";
		}
		
		// 관리자페이지
		else if(pathInfo.equals("/adminPage")) {
			List<ProductVO> productList = service.productList();
			request.setAttribute("productList", productList);
			nextPage = "adminPage";
		}

		else if(pathInfo.equals("/managePro")){
			nextPage = "managePro";
		}
		
		// 상품등록
		else if (pathInfo.equals("/addProduct")) {
		    Map<String, String> req = multiReq.getMultipartRequest(request);
		    String imageFileName = req.get("imageFileName");
		    String name = req.get("name");
		    String paramprice = req.get("price");
		    int price = Integer.parseInt(paramprice);
		    String weight = req.get("weight");
		    String info = req.get("info");
		    String cid = req.get("cid");

		    ProductVO vo = ProductVO.builder()
		            .name(name)
		            .price(price)
		            .weight(weight)
		            .info(info)
		            .cid(cid)
		            .imageFileName(imageFileName)
		            .build();

		    int productNo = service.addProduct(vo);

		    if (imageFileName != null && imageFileName.length() > 0) {
		    	multiReq.uploadImage(productNo, imageFileName);
		    }

		    response.sendRedirect(contextPath + "/product");
		    return;
		}
		
		// 상품삭제
		else if(pathInfo.equals("/remove")) {
			String paramPno = request.getParameter("pno");
			int pno = Integer.parseInt(paramPno);
			service.remove(pno);
			multiReq.deleteAllImage(pno);
			String result = gson.toJson("삭제 성공");
			out.print(result);
			return;
		}
		
		// 관리자페이지 상품 수정
		else if(pathInfo.equals("/modify")) {
			String imageFileName = request.getParameter("imageFileName");
			String cid = request.getParameter("cid");
			String weight = request.getParameter("weight");
			String info = request.getParameter("info");
			String priceP = request.getParameter("price");
			int price = Integer.parseInt(priceP);
			String name = request.getParameter("name");
			String paramPno = request.getParameter("pno");
			int pno = Integer.parseInt(paramPno);

			ProductVO vo = ProductVO.builder()
					.pno(pno)
					.name(name)
					.price(price)
					.weight(weight)
					.info(info)
					.cid(cid)
					.imageFileName(imageFileName)
					.build();
			request.setAttribute("productList", vo);
			nextPage = "modify";
		}
		
		
		else {
			System.out.println("존재하지 않는 페이지");
		}
		
		rd = request.getRequestDispatcher(PRIFIX+nextPage+SUFFIX);
		rd.forward(request, response);
	}
	

}
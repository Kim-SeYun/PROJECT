package com.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.MemberDao;
import com.domain.AuthVO;
import com.domain.MemberVO;
import com.domain.MemberVO.MemberGrade;
import com.google.gson.Gson;
import com.service.MemberService;

@WebServlet("/member/*")
public class MemberController extends HttpServlet {
	
	private MemberService service;
	private MemberService sv;
	private Gson gson;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		service = new MemberService(new MemberDao());
		ServletContext sc = config.getServletContext();
		sv = (MemberService) sc.getAttribute("idCheck");
		gson = new Gson();
		
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
		final String PRIFIX = "/WEB-INF/views/member/";
		final String SUFFIX = ".jsp";
		
		RequestDispatcher rd = null;
		String nextPage = null;
		
		
		// 회원가입 폼
		if(pathInfo.equals("/joinForm")) {
			nextPage = "joinForm";
		}
		
		// 회원가입 처리
		else if(pathInfo.equals("/join")) {
			String id = request.getParameter("id");
			String pwd = (String) request.getAttribute("pwd");
			String pwdck = request.getParameter("pwdck");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String day = request.getParameter("day");
			String gender = request.getParameter("gender");
			String address = request.getParameter("address1")+" "+request.getParameter("address2");
			
			MemberVO vo = MemberVO.builder()
					.id(id)
					.pwd(pwd)
					.name(name)
					.email(email)
					.year(year)
					.month(month)
					.day(day)
					.gender(gender)
					.address(address)
					.build();
			service.memberJoin(vo);
			request.setAttribute("id", id);
			nextPage = "joinCheck";
		}
		
		// 로그인폼
		else if(pathInfo.equals("/loginForm")) {
			nextPage = "loginForm";
		}
		
		// 로그인처리
		else if(pathInfo.equals("/login")) {
			String id = request.getParameter("id");
			String pwd = (String) request.getAttribute("pwd");
			MemberVO vo = MemberVO.builder()
					.id(id)
					.pwd(pwd)
					.build();

			
			if(service.loginService(vo)) {
				HttpSession session = request.getSession();
				
				// 회원 권한 설정
				MemberGrade grade = service.getMemberGrade(vo.getId()); // 등급조회
				AuthVO authVO = new AuthVO();
				authVO.setId(vo.getId()); // 아이디
				authVO.setGrade(grade); // 등급
				session.setAttribute("auth", authVO); // 세션 데이터 바인딩
				
				
				String userURI = (String) session.getAttribute("userURI");
				if(userURI!=null) {
					session.removeAttribute("userURI");
					response.sendRedirect(userURI);
					return;
				}
				response.sendRedirect(contextPath+"/product");
				return;
			} else {
				System.out.println("MemberController.login : 아이디 또는 비밀번호 불일치");
			}
		}
		
		// 로그아웃 처리
		else if(pathInfo.equals("/logout")) {
			HttpSession session = request.getSession(false);
			session = request.getSession(false);
			session.removeAttribute("auth");
			response.sendRedirect(contextPath+"/product");
			return;
		}
		
		// 마이페이지
		else if(pathInfo.equals("/myPage")) {
			HttpSession session = request.getSession(false);
			AuthVO auth = (AuthVO) session.getAttribute("auth");
			MemberVO info = service.memberInfo(auth.getId());
			request.setAttribute("info", info);
			nextPage = "myPage";
		}
		
		// 회원정보수정
		else if(pathInfo.equals("/modMember")) {
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String day = request.getParameter("day");
			String gender = request.getParameter("gender");
			String address = request.getParameter("modAddress");
			MemberVO vo = MemberVO.builder()
					.id(id)
					.email(email)
					.year(year)
					.month(month)
					.day(day)
					.gender(gender)
					.address(address)
					.build();
			service.modMember(vo);

			response.sendRedirect(contextPath+"/member/myPage");
			return;
		} 
		
		else {
			System.out.println("페이지를 찾을 수 없음");
			return;
		}
		
		rd = request.getRequestDispatcher(PRIFIX+nextPage+SUFFIX);
		rd.forward(request, response);
	}

}
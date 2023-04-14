package com.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
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
	private Gson gson;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		service = new MemberService(new MemberDao());
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
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
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
					.phone(phone)
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
		
		else if(pathInfo.equals("/idCheck")) {
			int result = 0;
			String id = request.getParameter("id");
			if(service.idCheckService(id)) {
				result = 1;
			}
			out.print(gson.toJson(result));
			return;
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
			    String message = "아이디 또는 비밀번호가 일치하지 않습니다.";
			    request.setAttribute("message", message);
			    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/member/loginForm.jsp");
			    dispatcher.forward(request, response);
			    return;
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
		
		else if(pathInfo.equals("/findIdForm")) {
			nextPage = "findIdForm";
		}
		
		else if(pathInfo.equals("/findPwdForm")) {
			nextPage = "findPwdForm";
		}
		
		else if(pathInfo.equals("/findId")) {
		    String name = request.getParameter("name");
		    String phone = request.getParameter("phone");
		    MemberVO vo = MemberVO.builder()
		            .name(name)
		            .phone(phone)
		            .build();
		    String foundId = service.findId(vo);

		    if(foundId != null) {
				String result = gson.toJson(foundId);
				out.print(result);
				
		    } else {
				String result = gson.toJson(false);
				out.print(result);
		    }
		    return;
		}
		
		else if(pathInfo.equals("/checkInfo")) {
		    String name = request.getParameter("name");
		    String phone = request.getParameter("phone");
		    MemberVO vo = MemberVO.builder()
		            .name(name)
		            .phone(phone)
		            .build();

		    if(service.checkInfo(vo)) { // 정보가 있으면
				String result = gson.toJson(true);
				out.print(result);
				
		    } else {
				String result = gson.toJson(false);
				out.print(result);
		    }
		    return;
		}
		
		
		
		else if(pathInfo.equals("/sendCertificationNumber")) {
		    String certificationNumber = String.format("%06d", (int) (Math.random() * 1000000));
		    System.out.println(certificationNumber);
		    String result = gson.toJson(certificationNumber);
		    out.print(result);
		    return;
		}
		
		else if(pathInfo.equals("/doChangePwd")) {
			String id = request.getParameter("id");
			String pwd = (String) request.getAttribute("pwd");
			MemberVO vo = MemberVO.builder()
					.id(id)
					.pwd(pwd)
					.build();
			service.doChangePwd(vo);
		    String result = gson.toJson(true);
		    out.print(result);
		    return;
		
		}


		else if(pathInfo.equals("/findPwd")) {
		    String id = request.getParameter("id");
		    String phone = request.getParameter("phone");
		    MemberVO vo = MemberVO.builder()
		            .id(id)
		            .phone(phone)
		            .build();

		    if(service.findPwd(vo)) { // 정보가 있으면
				String result = gson.toJson(true);
				out.print(result);
				
		    } else {
				String result = gson.toJson(false);
				out.print(result);
		    }
		    return;
		}
		
		else if(pathInfo.equals("/changePwd")) {
			nextPage = "changePwdForm";
		}
		
		
		
		else if(pathInfo.equals("/idCheck")) {
			int result = 0;
			String id = request.getParameter("id");
			if(service.idCheckService(id)) {
				result = 1;
			}
			out.print(gson.toJson(result));
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
		
		else if(pathInfo.equals("/idCheckForm")) {
			nextPage = "idCheckForm";
		}
		
		// 주문내역
		else if(pathInfo.equals("/orderList")) {
			nextPage = "orderList";
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
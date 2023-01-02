<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../layout/header.jsp" %>  
	<form action="${contextPath}/member/loginForm" method="post">
	
		<h1>${id}님 가입이 완료되었습니다.</h1>
	
		<button class="btn btn-primary" style="float: right;">로그인</button>
	</form>
<%@ include file="../layout/footer.jsp" %>  
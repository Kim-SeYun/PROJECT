<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../layout/header.jsp" %>  

	<div style="margin: 200px auto 0; text-align: center; width: 50%">
		<form action="${contextPath}/member/loginForm" method="post">
			<h1 style="margin-bottom: 50px;">${id}님 가입이 완료되었습니다.</h1>
			<button class="btn btn-primary" style="float: right; margin-right: 150px;">로그인</button>
		</form>
	</div>
	
<%@ include file="../layout/footer.jsp" %>  
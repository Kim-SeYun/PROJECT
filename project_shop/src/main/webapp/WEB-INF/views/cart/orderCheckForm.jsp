<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../layout/header.jsp" %>  
	<form action="${contextPath}/cart/orderList" method="post">
	
		<h1>${auth.id}님 주문이 완료되었습니다.</h1>
	
		<button class="btn btn-primary" style="float: right;">주문내역 확인</button>
	</form>
	
<%@ include file="../layout/footer.jsp" %>  

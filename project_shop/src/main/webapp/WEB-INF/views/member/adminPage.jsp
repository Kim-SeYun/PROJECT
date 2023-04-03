<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${contextPath}/resources/js/member/join.js"></script>  
 
<div class="container">
	<h1>관리자페이지</h1>
	
	<form action="${contextPath}/product/managePro">
		<button class="btn btn-primary">상품등록</button>
	</form>

</div>
<%@ include file="../layout/footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="auth" value="${sessionScope.auth}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 연습</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js" integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
	const contextPath = "${contextPath}"
	let auth={
		id : "${auth.id}",
		grade : "${auth.grade}"
	};
</script>
<script src="${contextPath}/resources/js/common.js"></script>  
<style>
	li {list-style: none;}
	ul {margin:0;padding:0;}
</style>
</head>
<body>
	
<nav class="navbar navbar-expand-sm bg-light navbar-dark justify-content-between">
		<a href="${contextPath}/product/list"><img src="${contextPath}/resources/images/LOGO.png" alt="LOGO" width="150" /></a>
  <ul class="nav nav-pills">
    <li class="nav-item">
      <a class="nav-link" href="${contextPath}/product/list">SHOP</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${contextPath}/board/list">Q&A</a>
    </li>
     <li class="nav-item">
    <a class="nav-link" href="${contextPath}/notice/list">NOTICE</a>
  </li>
  </ul>
  <!-- 로그인,로그아웃,회원가입 -->
  <ul class="navbar-nav">
	<c:if test="${empty auth}"> <!-- 세션값이 없을 때 -->
    <li class="nav-item">
      <a class="nav-link" style="color: black;" href="${contextPath}/member/joinForm">회원가입</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" style="color: black;" href="${contextPath}/member/loginForm">로그인</a>
    </li>
    </c:if>
    
    <c:if test="${not empty auth}"> <!-- 세션값이 있을 때 -->
   	<li class="nav-item">
   		<span class="nav-link" style="color: black;"><b>${auth.id}님 안녕하세요</b></span>
   	</li>
    <li class="nav-item">
      <a class="nav-link" style="color: black;" href="${contextPath}/member/myPage">마이페이지</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" style="color: black;" href="${contextPath}/cart/list">장바구니</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" style="color: black;" href="${contextPath}/member/logout">로그아웃</a>
    </li>
	</c:if>
  </ul>

</nav>




<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    .navbar-brand img {
        height: 40px;
        margin-top: -10px;
    }

    .nav-link {
        font-size: 14px;
        font-weight: bold;
        color: #333;
    }

    .nav-link:hover {
        color: #00aaff;
    }

    .nav-link.active {
        color: #00aaff;
    }
    
</style>
</head>
<body>
	


<div class="container" style="background-color: #FFFFFF; ">
    <div class="row">
        <div class="col-sm-2" style="margin-top: 35px;">
            <a href="${contextPath}/product/list">
                <img src="${contextPath}/resources/images/LOGO.png" alt="LOGO" width="150" />
            </a>
        </div>	
		<div class="col-sm-7" style="margin-top: 50px;">
		  <ul class="nav nav-pills justify-content-center">
		    <li class="nav-item col-sm-2">
		      <a class="nav-link" href="${contextPath}/product/list">SHOP</a>
		    </li>
		    <li class="nav-item col-sm-2">
		      <a class="nav-link" href="${contextPath}/board/list">Q&A</a>
		    </li>
		    <li class="nav-item col-sm-2">
		      <a class="nav-link" href="${contextPath}/notice/list">NOTICE</a>
		    </li>
		  </ul>
		</div>


        <div class="col-sm-3" style="margin-top: 50px;">	
            <ul class="navbar-nav">
                <c:if test="${empty auth}"> <!-- 세션값이 없을 때 -->
                    <div class="row justify-content-center" >
                    	<div class="col-sm-4">
                        <li class="nav-item">
                            <a class="nav-link" href="${contextPath}/member/joinForm">회원가입</a>
                        </li>
                        </div>
                        <div class="col-sm-4">
                        <li class="nav-item">
                            <a class="nav-link" href="${contextPath}/member/loginForm">로그인</a>
                        </li>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty auth}"> <!-- 세션값이 있을 때 -->
				    <div class="row justify-content-center">
				        <div class="col-sm-4">
				            <li class="nav-item dropdown">
				                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
				                   aria-haspopup="true" aria-expanded="false">
				                    <b>${auth.id}님</b>
				                </a>
				                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
				                    <a class="dropdown-item" href="${contextPath}/member/myPage">MyPage</a>
				                    <a class="dropdown-item adminPage" href="${contextPath}/product/adminPage">상품관리</a>
				                    <a class="dropdown-item" href="${contextPath}/member/logout">로그아웃</a>
				                </div>
				            </li>
				        </div>
				        <div class="col-sm-3">
				            <li class="nav-item">
					            <a href="${contextPath}/cart/list">
					                <img src="${contextPath}/resources/images/Cart.png" alt="LOGO" width="30" />
					            </a>				           
				            </li>
				        </div>

				    </div>
				</c:if>

            </ul>
        </div> 
    </div>
</div>
    <hr/>







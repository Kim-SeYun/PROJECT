<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>  
<script src="${contextPath}/resources/js/product/list.js"></script> 
<h1>PRODUCT</h1>
	<ul class="nav nav-pills justify-content-center">
    <li class="nav-item">
      <a class="nav-link" href="${contextPath}/product/ALL">ALL</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${contextPath}/product/BEST">BEST</a>
    </li>
     <li class="nav-item">
    <a class="nav-link" href="${contextPath}/product/SALE">SALE</a>
  </li>
  </ul>
<div class="container my-3">
	<form id="listForm">
	<div class="container" style="margin-top:30px">
	
	
	 	<div class="row">
		    <div class="col-sm-3">
		    	<a href="${contextPath}/product/detail"><img src="${contextPath}/resources/images/사과.jpg" alt="사과" width="200" /></a><br>
		    	<td>사과</td><br>
		    	<td>1500원</td><br><br>
			</div>
		    <div class="col-sm-3">
		    	<a href="${contextPath}/product/detail"><img src="${contextPath}/resources/images/바나나.jpg" alt="바나나" width="200" /></a><br>
				<td>바나나</td><br>
				<td>2000원</td>
			</div>
			<div class="col-sm-3">
		    	<a href="${contextPath}/product/detail"><img src="${contextPath}/resources/images/크로와상.jpg" alt="크로와상" width="200" /></a><br>
				<td>크로와상</td><br>
				<td>3000원</td>
			</div>
			<div class="col-sm-3">
		    	<a href="${contextPath}/product/detail"><img src="${contextPath}/resources/images/오렌지쥬스.jpg" alt="오렌지쥬스" width="200" /></a><br>
				<td>오렌지쥬스</td><br>
				<td>2000원</td>
			</div>
			<div class="col-sm-3">
		    	<a href="${contextPath}/product/detail"><img src="${contextPath}/resources/images/채소세트.jpg" alt="채소세트" width="200" /></a><br>
				<td>채소세트</td><br>
				<td>4000원</td>
			</div>
			<div class="col-sm-3">
		    	<a href="${contextPath}/product/detail"><img src="${contextPath}/resources/images/쿠키.jpg" alt="쿠키" width="200" /></a><br>
				<td>쿠키</td><br>
				<td>5000원</td>
			</div>
			<div class="col-sm-3">
		    	<a href="${contextPath}/product/detail"><img src="${contextPath}/resources/images/소고기.jpg" alt="소고기" width="200" /></a><br>
				<td>소고기</td><br>
				<td>30000원</td>
			</div>
			<div class="col-sm-3">
		    	<a href="${contextPath}/product/detail"><img src="${contextPath}/resources/images/계란.jpg" alt="계란" width="200" /></a><br>
				<td>계란</td><br>
				<td>6000원</td><br><br>
			</div>
	    </div>
 	</div>
 	</form>



<%@ include file="../layout/footer.jsp" %> 
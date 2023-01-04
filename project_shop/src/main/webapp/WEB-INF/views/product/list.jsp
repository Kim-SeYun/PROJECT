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
	 	<c:forEach items="${list}" var="p">
		    <div class="col-sm-3">
		    	<div><a href="${contextPath}/product/detail"><img src="${contextPath}/resources/images/${p.name}.jpg" alt="${p.name}" width="200" /></div>
		    	<div  class="name">${p.name}</a></div>
		    	<div>1500원</div><br>
			</div>
	 	
	 	</c:forEach>
		   
	    </div> 
 	</div>
 	</form>



<%@ include file="../layout/footer.jsp" %> 
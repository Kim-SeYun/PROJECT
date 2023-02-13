<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>  
<script src="${contextPath}/resources/js/product/list.js"></script> 
<h1>ALL</h1>
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
  <button class="pm" style="float: right;">상품관리</button>
  


<div class="container" style="margin-top:30px; margin-left: 298px;">
  <div class="row">
    <div class="col-sm-3">
      
      <h3>CATEGORY</h3><br> 
      
      <ul class="list-group">
		  <li class="list-group-item ${cid==c.cid ? 'list-group-item-primary':''}">
		  	<a href="${contextPath}/product/list">전체</a>
		  </li>
		  <c:forEach items="${category}" var="c">
		  <li class="list-group-item ${cid==c.cid ? 'list-group-item-primary':''}">
		  	<a href="${contextPath}/product/list?cid=${c.cid}">${c.cname}</a>
		  </li>
		  </c:forEach>
		</ul>		
		
    </div>
    
    <div class="col-sm-8">
      <form id="productForm">
	 	<div class="row">
	 	<c:choose>
	 		<c:when test="${empty products}">
		<c:forEach items="${list}" var="p"> 
		    <div class="col-sm-4">
		    	<div><a href="${p.name}" class="name"><img src="${contextPath}/resources/images/${p.name}.png" alt="${p.name}" width="200" /></div>
		    	<div>${p.name}</a></div>
		    	<div><fmt:formatNumber value="${p.price}" pattern="#,###원"/></div>
		    	<div><input type="hidden" value="1" class="cartCnt"></div>
		    	<button type="button" id="button" value="${p.pno}" class="btn btn-outline-info cartBtn"  style="float: right; margin-right: 23px; margin-bottom: 35px">Cart</button>
			</div>
	 	</c:forEach> 
	 	</c:when>
	 	<c:otherwise>
	 	<c:forEach items="${products}" var="p">
		    <div class="col-sm-4">
		    	<div><a href="${p.name}" class="name"><img src="${contextPath}/resources/images/${p.name}.png" alt="${p.name}" width="200" /></div>
		    	<div>${p.name}</a></div>
		    	<div><fmt:formatNumber value="${p.price}" pattern="#,###원"/></div>
		    	<div><input type="hidden" value="1" class="cartCnt"></div>
		    	<button type="button" id="button" value="${p.pno}" class="btn btn-outline-info cartBtn"  style="float: right; margin-right: 23px; margin-bottom: 35px">Cart</button>
			</div>
	 	</c:forEach>
	 	</c:otherwise>
	 	</c:choose>
 	</div>
 	</form>
    </div>
  </div>
</div>


<%@ include file="../layout/footer.jsp" %> 

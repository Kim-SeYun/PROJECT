<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>  
<script src="${contextPath}/resources/js/product/list.js"></script> 

<style>
	img {
	max-width: 100%;
	max-height: 100%;
	display: block;
	margin: 0 auto;	
	}
</style>

<div class="container">
  <div class="row">
    <div class="col-sm-3">
      
<div style="margin-top: 100px;">
    <h3>CATEGORY</h3><br> 
    <ul class="list-group">
        <li class="list-group-item ${cid=='all' ? 'list-group-item-primary':''}">
            <a href="${contextPath}/product/list">전체</a>
        </li>
        <c:forEach items="${category}" var="c">
        <li class="list-group-item ${cid==c.cid ? 'list-group-item-primary':''}">
            <a href="${contextPath}/product/list?cid=${c.cid}">${c.cname}</a>
        </li>
        </c:forEach>
    </ul> 
    
</div>

		
    </div>
    
    <div class="col-sm-8">
      <form id="productForm" style="margin-top: 100px;">
	 	<div class="row">
	 	<c:choose>
	 		<c:when test="${empty products}">
	 		<h1>${message}</h1>  
		<c:forEach items="${list}" var="p"> 
		    <div class="col-sm-4">
		    	<div><a href="${p.name}" class="name"><img src="${contextPath}/fileDownload?no=${p.pno}&imageFileName=${p.imageFileName}&path=product" alt="${p.name}" width="200" height="150"/></div>
		    	<div style="margin-left: 5%;">${p.name}</a></div>
		    	<div style="margin-left: 5%;"><fmt:formatNumber value="${p.price}" pattern="#,###원"/></div>
		    	<div><input type="hidden" value="1" class="cartCnt"></div>
		    	<input type="hidden" value="${p.weight}">
		    	<input type="hidden" value="${p.imageFileName}">
		    	<input type="hidden" value="${p.name}">
		    	<input type="hidden" value="${p.price}">
		    	<button type="button" id="button" value="${p.pno}" class="btn btn-outline-info cartBtn"  style="float: right; margin-right: 5%; margin-bottom: 35px">Cart</button>
			</div>
	 	</c:forEach> 
	 	</c:when>
	 	<c:otherwise>
	 	<c:forEach items="${products}" var="p">
			<div class="col-sm-4">
			    <div><a href="${p.name}" class="name"><img src="${contextPath}/fileDownload?no=${p.pno}&imageFileName=${p.imageFileName}&path=product" alt="${p.name}" width="200" /></div>
			    <div style="margin-left: 5%;">${p.name}</a></div>
			    <div style="margin-left: 5%;"><fmt:formatNumber value="${p.price}" pattern="#,###원"/></div>
			    <div><input type="hidden" value="1" class="cartCnt"></div>
			    <div>
				    <input type="hidden" value="${p.price}" name="price">
				    <button type="button" id="button" value="${p.pno}" class="btn btn-outline-info cartBtn"  style="float: right; margin-right: 5%; margin-bottom: 35px">Cart</button>
				</div>
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
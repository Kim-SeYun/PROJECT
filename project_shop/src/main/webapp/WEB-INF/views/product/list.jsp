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
  


<div class="container" style="margin-top:30px; margin-left: 298px;">
  <div class="row">
    <div class="col-sm-3">
      
      <h3>CATEGORY</h3><br>
      <ul class="nav nav-pills flex-column">
        <li class="nav-item">
          <a class="nav-link" href="#">채소/과일</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">정육/계란</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">커피/음료</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">간식/베이커리</a>
        </li>
      </ul>
      
    </div>
    
    <div class="col-sm-8">
      <form id="productForm">
	 	<div class="row">
	 	<c:forEach items="${list}" var="p">
		    <div class="col-sm-4">
		    	<div><a href="${p.name}" class="name"><img src="${contextPath}/resources/images/${p.name}.png" alt="${p.name}" width="200" /></div>
		    	<div>${p.name}</a></div>
		    	<div>${p.price}원</div>
		    	<button type="button" id="button" value="${p.pno}" class="btn btn-outline-info cartBtn"  style="float: right; margin-right: 23px; margin-bottom: 35px">Cart</button>
			</div>
	 	</c:forEach>
 	</div>
 	</form>
    </div>
  </div>
</div>


<%@ include file="../layout/footer.jsp" %> 

<!-- <script>
$(function(){
	$('.cartBtn').on('click', function(){
		let num = $('#button').attr('value')
		alert(num)
	})
})
</script> -->
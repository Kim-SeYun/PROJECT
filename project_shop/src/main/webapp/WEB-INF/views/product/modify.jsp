<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../layout/header.jsp" %>  
<script src="${contextPath}/resources/js/product/modify.js"></script>

<style>
.preview img {
  width: 400px;
  height: 250px;
  object-fit: cover;
}
</style>
  
	<div class="jumbotron">
		<h1>상품수정</h1>
	</div>
	
	<form id="modForm" class="container" action="${contextPath}/product/modProduct" method="post" enctype="multipart/form-data">
		<div class="form-group">
		    상품번호 <input type="text" class="form-control" name="pno" value="${productList.pno}" readonly="readonly">
		</div>
		<div class="form-group">
		    상품명 <input type="text" class="form-control" name="name" value="${productList.name}" readonly="readonly">
		</div>
		<div class="form-group">
		    가격 <input type="text" class="form-control" name="price" value="${productList.price}">
		</div>
		<div class="form-group">
		    중량X수량 <input type="text" class="form-control" name="weight" value="${productList.weight}" readonly="readonly">
		</div>
		<div class="form-group">
		    상품설명 <input type="text" class="form-control" name="info" value="${productList.info}">
		</div>
		<div class="form-group">
		    카테고리 
		    <select class="form-control" name="cid" disabled>
		        <option value="Vegetables/Fruits" ${productList.cid == 'Vegetables/Fruits' ? 'selected' : ''}>채소/과일</option>
		        <option value="Meat/Eggs" ${productList.cid == 'Meat/Eggs' ? 'selected' : ''}>정육/계란</option>
		        <option value="coffee/beverage" ${productList.cid == 'coffee/beverage' ? 'selected' : ''}>커피/음료</option>
		        <option value="Snack/Bakery" ${productList.cid == 'Snack/Bakery' ? 'selected' : ''}>간식/베이커리</option>
		    </select>
		</div>
		<div class="form-group">
		  <input type="hidden" name="originFileName" value="${productList.imageFileName}">
		  첨부파일 <input type="file" class="form-control" name="imageFileName" value="${productList.imageFileName}"><br>
		  <div class="preview">
		    <img src="${contextPath}/fileDownload?no=${productList.pno}&imageFileName=${productList.imageFileName}&path=product">
		  </div>
		</div>
		<button class="btn btn-primary modify">상품수정</button>
		<button class="btn btn-secondary">취소</button>
	</form>

<%@ include file="../layout/footer.jsp" %>  
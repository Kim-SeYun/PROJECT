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
  
	<h1 style="margin-top: 5%; text-align: center;">상품수정</h1>
	
	<form id="modForm" class="container" style="margin-top: 3%;" action="${contextPath}/product/modProduct" method="post" enctype="multipart/form-data">
		<div class="form-group">
		    상품번호 <input type="text" class="form-control" name="pno" value="${productList.pno}" readonly="readonly">
		</div>
		<div class="form-group">
		    상품명 <input type="text" class="form-control" name="name" value="${productList.name}" readonly="readonly">
		</div>
		<div class="form-group">
		    가격 <input type="number" class="form-control" name="price" value="${productList.price}" required>
		</div>
		<div class="form-group">
		    중량X수량 <input type="text" class="form-control" name="weight" value="${productList.weight}" readonly="readonly">
		</div>
		<div class="form-group">
		    상품설명 <textarea class="form-control" name="info" required>${productList.info}</textarea>
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
		<div style="overflow: hidden">
		  <a href="${contextPath}/product/adminPage" class="btn btn-secondary float-right">취소</a>
		  <button class="btn btn-primary float-right mr-2">상품수정</button>
		</div>
	</form>

<%@ include file="../layout/footer.jsp" %>  
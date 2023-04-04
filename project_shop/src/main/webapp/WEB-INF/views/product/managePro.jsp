<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../layout/header.jsp" %>  
  
	<div class="jumbotron">
		<h1>상품등록</h1>
	</div>
	
	<form class="container" action="${contextPath}/product/addProduct" method="post" enctype="multipart/form-data">
		<div class="form-group">
			상품명 <input type="text" class="form-control" name="name">
		</div>
		<div class="form-group">
			가격 <input type="text" class="form-control" name="price">
		</div>
		<div class="form-group">
			중량X수량 <input type="text" class="form-control" name="weight">
		</div>
		<div class="form-group">
			상품설명 <input type="text" class="form-control" name="info">
		</div>
		<div class="form-group">
		
			카테고리 <select class="form-control" name="cid">
				<option value="Vegetables/Fruits">채소/과일</option>
				<option value="Meat/Eggs">정육/계란</option>
				<option value="coffee/beverage">커피/음료</option>
				<option value="Snack/Bakery">간식/베이커리</option>
			</select>
		</div>
		<div class="form-group">
			첨부파일 <input type="file" class="form-control" name="imageFileName">
		</div>
		<button class="btn btn-primary">상품등록</button>
	</form>

<%@ include file="../layout/footer.jsp" %>  
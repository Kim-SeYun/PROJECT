<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../layout/header.jsp" %>  

<h1 style="margin-top: 5%; text-align: center;">상품등록</h1>
	
<form class="container" style="margin-top: 3%;" action="${contextPath}/product/addProduct" method="post" enctype="multipart/form-data">
	<div class="form-group">
		상품명 <input type="text" class="form-control" name="name" required>
	</div>
	<div class="form-group">
		가격 <input type="number" class="form-control" name="price" required>
	</div>
	<div class="form-group">
		중량X수량 <input type="text" class="form-control" name="weight" required>
	</div>
	<div class="form-group">
		상품설명 <input type="text" class="form-control" name="info" required>
	</div>
	<div class="form-group">
		카테고리 <select class="form-control" name="cid" required>
			<option value="Vegetables/Fruits">채소/과일</option>
			<option value="Meat/Eggs">정육/계란</option>
			<option value="coffee/beverage">커피/음료</option>
			<option value="Snack/Bakery">간식/베이커리</option>
		</select>
	</div>
	<div class="form-group">
		 <input type="hidden" name="originFileName" value="${productList.imageFileName}" >
		  첨부파일 <input type="file" class="form-control" name="imageFileName" id="imageFileName" onchange="previewImage(this);" required><br>
		<img id="preview" style="max-width: 200px; max-height: 200px;">
	</div>
<div style="overflow: hidden">
  <a href="${contextPath}/product/adminPage" class="btn btn-secondary float-right">취소</a>
  <button class="btn btn-primary float-right mr-2">상품등록</button>
</div>

	
</form>

<%@ include file="../layout/footer.jsp" %>  
<script>
function previewImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#preview').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
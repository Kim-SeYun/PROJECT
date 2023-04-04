<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${contextPath}/resources/js/member/join.js"></script>  
 
<div class="container">
	<h1>관리자페이지</h1>
	
	<form action="${contextPath}/product/managePro">
		<button class="btn btn-primary">상품등록</button>
	</form>
	
<h1>Product List</h1>
<table style="border-collapse: collapse; width: 100%; border: 1px solid #ddd;">
	<thead>
		<tr style="background-color: #f5f5f5;" class="text-center">
			<th style="padding: 10px; border: 1px solid #ddd;">상품번호</th>
			<th style="padding: 10px; border: 1px solid #ddd;">상품명</th>
			<th style="padding: 10px; border: 1px solid #ddd;">가격</th>
			<th style="padding: 10px; border: 1px solid #ddd;">상세정보</th>
			<th style="padding: 10px; border: 1px solid #ddd;">무게</th>
			<th style="padding: 10px; border: 1px solid #ddd;">분류</th>
			<th style="padding: 10px; border: 1px solid #ddd;">이미지</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="product" items="${productList}">
			<tr style="text-align: center;">
				<td style="padding: 10px; border: 1px solid #ddd;">${product.pno}</td>
				<td style="padding: 10px; border: 1px solid #ddd;">${product.name}</td>
				<td style="padding: 10px; border: 1px solid #ddd;">${product.price}</td>
				<td style="padding: 10px; border: 1px solid #ddd;">${product.info}</td>
				<td style="padding: 10px; border: 1px solid #ddd;">${product.weight}</td>
				<td style="padding: 10px; border: 1px solid #ddd;">${product.cid}</td>
				<td style="padding: 10px; border: 1px solid #ddd;"><img src="${contextPath}/fileDownload?no=${product.pno}&imageFileName=${product.imageFileName}&path=product" alt="${product.name}" style="width: 100px; height: 70px;"></td>
				
				<td style="padding: 10px; border: 1px solid #ddd;">
					<input type="hidden" value="${product.pno}">
					<input type="hidden" value="${product.name}">
					<input type="hidden" value="${product.price}">
					<input type="hidden" value="${product.info}">
					<input type="hidden" value="${product.weight}">
					<input type="hidden" value="${product.cid}">
					<input type="hidden" value="${product.imageFileName}">
					<input type="button" class="btn btn-outline-info product_modBtn" value="수정">
				</td>
				<td style="padding: 10px; border: 1px solid #ddd;">
					<input type="hidden" value="${product.pno}">
					<input type="button" class="btn btn-outline-danger product_delBtn" value="삭제">
				</td>			
			</tr>
		</c:forEach>
	</tbody>
</table>
	

</div>
<%@ include file="../layout/footer.jsp" %>

<script>
$('.product_delBtn').on('click', function() {
    var pno = $(this).prev().val();
    $.ajax({
        type : 'post',
        url : `${contextPath}/product/remove`,
        data : {pno : pno},
        success : function(result) {
            alert("상품이 삭제되었습니다.")
            location.assign("/project_shop/product/adminPage")
        },
        error : function(xhr, status, error) {
            console.error(xhr.responseText);
            alert("삭제 실패")
        }
    })
});


	
$('.product_modBtn').on('click', function() {
	  $('<form/>').attr('method', 'get')
	    .attr('action', '${contextPath}/product/modify')
	    .append("<input type='hidden' value='"+$(this).prev().prev().prev().prev().prev().prev().prev().val()+"' name='pno'>") 
	    .append("<input type='hidden' value='"+$(this).prev().prev().prev().prev().prev().prev().val()+"' name='name'>")
	    .append("<input type='hidden' value='"+$(this).prev().prev().prev().prev().prev().val()+"' name='price'>")
	    .append("<input type='hidden' value='"+$(this).prev().prev().prev().prev().val()+"' name='info'>")
	    .append("<input type='hidden' value='"+$(this).prev().prev().prev().val()+"' name='weight'>")
	    .append("<input type='hidden' value='"+$(this).prev().prev().val()+"' name='cid'>")
	    .append("<input type='hidden' value='"+$(this).prev().val()+"' name='imageFileName'>") 
	    .appendTo('body')
	    .submit();
	});



</script>
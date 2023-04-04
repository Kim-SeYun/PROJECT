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
		<tr style="background-color: #f5f5f5;">
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
				<td style="padding: 10px; border: 1px solid #ddd;"><img src="${contextPath}/fileDownload?no=${product.pno}&imageFileName=${product.imageFileName}&path=product" alt="${product.name}" style="max-width: 100px; max-height: 100px;"></td>
				
				<td>
					<form action="/product/edit/${product.pno}">
						<button type="submit">수정</button>
					</form>
				</td>
				<td>
					<form action="/product/delete/${product.pno}">
						<button type="submit">삭제</button>
					</form>
				</td>			
			</tr>
		</c:forEach>
	</tbody>
</table>


	

</div>
<%@ include file="../layout/footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %> 


<h1>장바구니</h1>

<div class="container my-3">
	<form id="cartForm">
		<table class="table">
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>갯수</th>
				<th>개당가격</th>
				<th>총액</th>
			</tr>
			<c:forEach items="${list}" var="c">
			<tr>
				<td>${c.pno}</td>
				<td>${c.name}</td>
				<td>${c.price}</td>
				<td>${c.cart_cnt}</td>
				<td>null</td>
			</tr>
			</c:forEach>
		</table>
	</form>
	
</div>


<%@ include file="../layout/footer.jsp" %> 
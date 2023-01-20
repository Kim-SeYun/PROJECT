<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../layout/header.jsp" %>  
<script src="${contextPath}/resources/js/product/list.js"></script> 
<script src="${contextPath}/resources/js/cart/list.js"></script>
	<h1>장바구니입니다.</h1>
<div class="container my-3">
	<form id="cartForm">
		<c:if test="${empty list}">
			<h1>장바구니에 담긴 상품이 없습니다.</h1>
		</c:if>
		<c:if test="${not empty list}">
			<table class="table">
			<div>
				<button type="button" class="btn btn-outline-dark float-right delAllCart">전체삭제</button>
				<button type="button" class="btn btn-outline-dark float-right delCheckCart">선택삭제</button>
			</div>
				<tr>
					<th>번호</th>
					<th>이미지</th>
					<th>상품명</th>
					<th>가격</th>
					<th>수량</th>
					<th>합계</th>
					<th><input type="checkbox" class="cartAllCheckBox"></th>
				</tr>
				<c:forEach items="${list}" var="b">
				<tr>	
					<td>
						<c:set var="cno" value="${cno+1}"/>
						<c:out value="${cno}"/>
					</td>
					<td><a href="${b.name}" class="name"><img src="${contextPath}/resources/images/${b.name}.png" alt="${b.name}" width="100"/></a></td>
					<td><a href="${b.name}" class="name">${b.name}</a></td>
					<td><fmt:formatNumber value="${b.price}" pattern="#,###원"/></td>
					<td>
						<button type="button" class="c_minus">-</button>
					    <input type="text" class="cartCnt" name="cartCnt" value="${b.cart_cnt}" readonly="readonly"/>
					    <button type="button" class="c_plus">+</button>
					</td>
					
					<td><fmt:formatNumber value="${b.price * b.cart_cnt}" pattern="#,###원"/></td>
					<td><input type="checkbox" name="chk" class="cartCheckBox" value="${b.pno}"></td>
				</tr>
				<c:set var="total" value="${total + b.price*b.cart_cnt}"/>
				</c:forEach>
			</table>
			<div class="form-group" align="right">
				합계금액 : <input type="text" class="form-control" value="<fmt:formatNumber value="${total}" pattern="#,###원"/>" style="width:130px; height:30px;font-size:15px;text-align:right;font-weight : bold ;" readonly="readonly">
				<%-- <c:out value="${total}원"></c:out> --%>
			</div>
			<div>
				<button type="button" class="btn btn-info float-right toBuyForm">주문하기</button>
			</div>
		</c:if>	
	</form>
</div>	
	
<%@ include file="../layout/footer.jsp" %>  
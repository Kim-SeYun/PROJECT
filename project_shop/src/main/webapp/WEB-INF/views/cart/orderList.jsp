<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<h1>주문내역</h1>
	
<div class="col-sm-3">
	<ul class="nav nav-pills flex-column">
		<li class="nav-item">
			<a class="nav-link" href="${contextPath}/member/myPage">개인정보수정</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${contextPath}/cart/orderList">주문내역</a>
		</li>
	</ul>
</div>
       
<div class="container my-3">
	<form id = "orderForm">
		<c:if test="${empty info}">
			<h1>주문내역이 없습니다.</h1>
		</c:if>
		<c:if test = "${not empty info}">
			<table class="table">
				<tr>
					<th>주문날짜</th>
					<th>번호</th>
					<th>이미지</th>
					<th>상품명</th>
					<th>가격</th>
					<th>수량</th>
					<th>합계</th>
				</tr>
				
				<c:forEach items="${info}" var="b">
				<tr>	
					<td>
						${b.regDate}
					</td>
					<td>
						<c:set var="cno" value="${cno+1}"/>
						<c:out value="${cno}"/>
					</td>
					<td><a href="${contextPath}/product/detail?name=${b.name}" class="name"><img src="${contextPath}/resources/images/${b.name}.png" alt="${b.name}" width="100"/></a></td>
					<td><a href="${contextPath}/product/detail?name=${b.name}" class="name">${b.name}</a></td>
					<td><fmt:formatNumber value="${b.price}" pattern="#,###원"/></td>
					<td>${b.order_cnt}</td>		
					<td><fmt:formatNumber value="${b.price * b.order_cnt}" pattern="#,###원"/></td>
					<input type="hidden" value="${b.price * b.order_cnt}" name="hdPrice" class="hdPrice">
				</tr>
				<c:set var="total" value="${total + b.price*b.order_cnt}"/>
				</c:forEach>
			</table>
			<div class="form-group" align="right">
				주문금액 : <input type="text" name="totalPrice" class="form-control totalPrice" value="<fmt:formatNumber value="${total}" pattern="#,###원"/>" style="width:130px; height:30px;font-size:15px;text-align:right;font-weight : bold ;" readonly="readonly">
				<input type="hidden" class="hdTotal" value="${total}">
			</div> 
		</c:if>			
	</form>

</div>    
    
    
<%@ include file="../layout/footer.jsp" %>
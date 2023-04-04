<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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
  <form id="orderForm">
  
    <c:if test="${empty info}">
      <h1>주문내역이 없습니다.</h1>
    </c:if>
    
    <c:if test="${not empty info}">
      <c:set var="prevDate" value="" />
      <c:forEach items="${info}" var="b" varStatus="status">
        <c:if test="${status.index == 0 || b.regDate ne prevDate}">
          <c:if test="${status.index > 0}">
            </tbody>
            <tr>
              <td colspan="6" align="right">주문금액 :</td>
              <td>
                <input type="text" name="totalPrice" class="form-control totalPrice" value="<fmt:formatNumber value='${total}' pattern='#,###원'/>" style="width:130px; height:30px;font-size:15px;text-align:right;font-weight : bold ;" readonly="readonly">
                <input type="hidden" class="hdTotal" value="${total}">
              </td>
            </tr>
          </c:if>
          <table class="table">
            <thead>
              <tr>
                <th>주문날짜</th>
                <th>이미지</th>
                <th>상품명</th>
                <th>가격</th>
                <th>수량</th>
                <th>합계</th>
              </tr>
            </thead>
            <tbody>
              <c:set var="total" value="0" />
            </tbody>
        </c:if>
        
        <tr>
          <td>${b.regDate}</td>
          <td>
            <a href="${contextPath}/product/detail?name=${b.name}" class="name">
              <img src="${contextPath}/fileDownload?no=${b.pno}&imageFileName=${b.imageFileName}&path=product" alt="${b.name}" width="100" height="60"/>
            </a>
          </td>
          <td>
            <a href="${contextPath}/product/detail?name=${b.name}" class="name">${b.name}</a>
          </td>
          <td>
            <fmt:formatNumber value="${b.price}" pattern="#,###원" />
          </td>
          <td>${b.order_cnt}</td>
          <td>
            <fmt:formatNumber value="${b.price * b.order_cnt}" pattern="#,###원" />
          </td>
        </tr>
        
          
        
        <c:set var="total" value="${total + b.price * b.order_cnt}" />
        <c:set var="prevDate" value="${b.regDate}" />
        <c:if test="${status.last}">
          </tbody>
          <tr>
            <td colspan="6" align="right">주문금액 :</td>
            <td>
              <input type="text" name="totalPrice" class="form-control totalPrice" value="<fmt:formatNumber value='${total}' pattern='#,###원'/>" style="width:130px; height:30px;font-size:15px;text-align:right;font-weight : bold ;" readonly="readonly">
              <input type="hidden" class="hdTotal" value="${total}">
            </td>
          </tr>
        </c:if>
      </c:forEach>
      </table> 
    </c:if>
  </form>
</div>


  
    
    
<%@ include file="../layout/footer.jsp" %>
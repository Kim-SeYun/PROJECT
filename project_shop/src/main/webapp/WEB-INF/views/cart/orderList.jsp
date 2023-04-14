<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 


<div class="container">
<div class="row">
    <div class="col-sm-2" style="margin-top: 3%;">
    <h1>MyPage</h1>
      <ul class="nav nav-pills flex-column">
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/member/myPage">개인정보수정</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/cart/orderList">주문내역</a>
        </li>
      </ul>
    </div>
       
<div class="col-sm-10" style="margin-top: 11.5%;">
  <form id="orderForm" style="margin-top: -50px;">
  
    <c:if test="${empty info}">
	<div style="margin: 200px auto 0; text-align: center; width: 50%">
	    <h1 style="margin-bottom: 50px;">주문내역이 없습니다.</h1>
	</div>      
    </c:if>
    
    
    
    <c:if test="${not empty info}">
      <c:set var="prevDate" value="" />
      <c:forEach items="${info}" var="b" varStatus="status">
        <c:if test="${status.index == 0 || b.regDate ne prevDate}">
          <c:if test="${status.index > 0}">
            <tr>
              <td colspan="6" align="right">주문금액 :</td>
              <td>
                <input type="text" name="totalPrice" class="form-control totalPrice" value="<fmt:formatNumber value='${total}' pattern='#,###원'/>" style="width:130px; height:30px;font-size:15px;text-align:right;font-weight : bold ;" readonly="readonly">
                <input type="hidden" class="hdTotal" value="${total}">
              </td>
            </tr>
          </c:if>
	
          <table class="table">
			<th colspan="7" style="border: 0;">
			    <span style="background-color: #FFFFFF; padding: 5px 10px; border-radius: 10px;">
			        <span style="display: inline-block; color: black; font-family: Arial, sans-serif; font-weight: bold; margin-right: 5px;">
			            <b>주문일자 :</b>
			        </span>
			        <span style="display: inline-block; border-radius: 10px; padding: 5px 10px; background-color: #F5F5F5;">
			            ${b.regDate}
			        </span>
			    </span>
			</th>
              <tr>
                <th>번호</th>
                <th>이미지</th>
                <th>상품명</th>
                <th>가격</th>
                <th>중량</th>
                <th>수량</th>
                <th>합계</th>
              </tr>
              <c:set var="total" value="0" />
              <c:set var="cno" value="0" />
      </c:if>
      
        <tr>
          <td>
			<c:set var="cno" value="${cno+1}"/>
			<c:out value="${cno}"/>
		  </td>
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
          <td>${b.weight}</td>
          <td>${b.order_cnt}</td>
          <td>
            <fmt:formatNumber value="${b.price * b.order_cnt}" pattern="#,###원" />
          </td>
        <c:set var="total" value="${total + b.price * b.order_cnt}" />
        <c:set var="prevDate" value="${b.regDate}" />
        <c:if test="${status.last}">
          <tr>
            <td colspan="6" align="right">주문금액 :</td>
            <td>
              <input type="text" name="totalPrice" class="form-control totalPrice" value="<fmt:formatNumber value='${total}' pattern='#,###원'/>" style="width:130px; height:30px;font-size:15px;text-align:right;font-weight : bold ;" readonly="readonly">
              <input type="hidden" class="hdTotal" value="${total}">
            </td>
          </tr>
        </c:if>
        </tr>
        
          
        
      </c:forEach>
      </table> 
    </c:if>
  </form>
</div>

</div>

</div>

  
    
    
<%@ include file="../layout/footer.jsp" %>
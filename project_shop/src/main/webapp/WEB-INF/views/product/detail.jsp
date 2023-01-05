<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<br><br>
<div class="container" style="margin-top:30px">
  <div class="row">
    <div class="col-sm-4">
     
      <div class="fakeimg"><img src="${contextPath}/resources/images/${product.name}.png" alt="${product.name}" width="200" /><br></div>
      
    </div>
    <div class="col-sm-8">
      <h2>${product.name}</h2>
      <h5>${product.price}원</h5>
      <p>${product.weight}</p>
      <p>${product.info}</p>
    </div>
  </div>
</div>



<%@ include file="../layout/footer.jsp" %> 
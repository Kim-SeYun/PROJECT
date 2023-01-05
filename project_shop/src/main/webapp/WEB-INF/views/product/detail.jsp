<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>


<div class="container" style="margin-top:80px">
  <div class="row">
    <div class="col-sm-4">
     
      <div class="fakeimg"><img src="${contextPath}/resources/images/${product.name}.png" alt="${product.name}" width="200" /><br></div>
      
    </div>
    <div class="col-sm-8">
      <h2><b>${product.name}</b></h2>
      <hr align="left" style="border: solid 1px grey; width: 20%;">
      <font size="2em" color="grey">가격</font>
      <h5><p><b>${product.price}원</b></p></h5>
      <font size="2em" color="grey">중량X수량</font>
      <p><b><font size="3em">${product.weight}</b></p>
      <font size="2em" color="grey">상품설명</font>
      <p><b>${product.info}</b></p>
    </div>
  </div>
</div>



<%@ include file="../layout/footer.jsp" %> 
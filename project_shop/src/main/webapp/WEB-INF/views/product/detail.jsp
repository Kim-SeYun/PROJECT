<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<script src="${contextPath}/resources/js/reply/ProductReply.js"></script>
<script src="${contextPath}/resources/js/product/detail.js"></script>
<script src="${contextPath}/resources/js/product/list.js"></script> 
<div class="container" style="margin-top:80px">
  <div class="row">
    <div class="col-sm-4">
     
      <div class="fakeimg"><img src="${contextPath}/resources/images/${product.name}.png" alt="${product.name}" width="300"/><br></div>
      
    </div>
    <div class="col-sm-8">
      <h2><b>${product.name}</b></h2>
      <hr align="left" style="border: solid 1px grey; width: 20%;">
      <font size="2em" color="grey">가격</font>
      <h5><p><b><fmt:formatNumber value="${product.price}" pattern="#,###원"/></b></p></h5>
      <font size="2em" color="grey">중량X수량</font>
      <p><b><font size="3em">${product.weight}</b></p>
      <font size="2em" color="grey">상품설명</font>
      <p><b>${product.info}</b></p>
      <div>
      	<button type="button" class="btn btn-outline-secondary minus">-</button>
		<input type="text" class="cartCnt" name="cartCnt" value="${list.cart_cnt}1" readonly="readonly" style="width: 40px; height: 38px; text-align: center;"/>
		<button type="button" class="btn btn-outline-secondary plus">+</button>
	</div>
      <button type="button" id="button" value="${product.pno}" class="btn btn-outline-info cartBtn">Cart</button>
    </div>
  </div>
</div>
<input type="hidden" name="pno" value="${product.pno}">

<div class="productReplyForm">
		<table class="table">
			<tr>
				<th colspan="2">
					<ul class="d-flex justify-content-between">
						<li>리뷰를 작성해주세요</li>
						<li class="form-inline">작성자 : <input type="text" class="reply_writer form-control ml-2" value="${auth.id}" readonly="readonly"></li>
					</ul>
				</th>
			</tr>
			<tr>
				<td class="col-1 text-center"><b>내용</b></td>
				<td>
					<textarea rows="5" class="form-control reply_content"></textarea>
				</td>
			</tr>
			<tr class="text-right">
				<td colspan="2"><button class="btn btn-light reply_write">댓글등록</button></td>
			</tr>
		</table>
	</div>
	<div class="productReplyList">
		<div class="card">
		  <div class="card-header bg-dark text-white">댓글목록</div>
		  <div class="card-body">
		  	<ul class="list-group list-group-flush">
		  		<li>여기 있음</li>
			</ul>
			
		  </div>
		</div>
	</div>
	<div class="modal fade productReplyBtn" id="reply">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">댓글 등록</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        Modal body..
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>


<%@ include file="../layout/footer.jsp" %> 
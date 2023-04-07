<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${contextPath}/resources/js/member/join.js"></script>  
 
<div class="container">
	<h1>MyPage</h1>
	
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
    
	<form id="viewForm" class="container" action="${contextPath}/member/modMember" method="post">
		<div class="form-group">
			<h5><b>아이디</b></h5>
			<input type="text" class="form-control" name="id" value="${info.id}" style="width:300px; height:30px;font-size:20px;" readonly="readonly">
		</div>
		<div class="form-group">
			<h5><b>이름</b></h5>
			<input type="text" class="form-control" name="name" value="${info.name}" style="width:300px; height:30px;font-size:20px;" readonly="readonly">
		</div>
		<div class="form-group">
			<h5><b>이메일</b></h5>
			<input type="email" class="form-control" name="email" value="${info.email}" pattern="[A-Za-z0-9_]*[@]{1}[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}" title="EX) example@example.com" style="width:300px; height:30px;font-size:20px;" required readonly="readonly">
		</div>
		
 		<div class="form-group">
			<h4>생년월일</h4>
			<select class="form-control" id="year" name="year" style="width:300px; height:30px;font-size:13px;" required readonly="readonly">
				  <option value="${info.year}" hidden>${info.year}</option>
				  <c:forEach var="year" begin="1920" end="2023">
				    <option value="${year}">${year}</option>
				  </c:forEach>			
			</select>
			<select class="form-control" id="month" name="month" style="width:300px; height:30px;font-size:13px;" required readonly="readonly">
				<option value="${info.month}" hidden>${info.month}</option>
				<c:forEach var="month" begin="1" end="12">
				<c:choose>
				    <c:when test="${month lt 10 }">
				        <option value="0${month}">0${month}</option>
				    </c:when>
				    <c:otherwise>
				        <option value="${month}">${month}</option>
				    </c:otherwise>
				</c:choose>
				</c:forEach>	
			</select>
			<select class="form-control" id="day" name="day" style="width:300px; height:30px;font-size:13px;" required readonly="readonly">
				<option value="${info.day}" hidden>${info.day}</option>
				<c:forEach var="day" begin="1" end="31">
				<c:choose>
				    <c:when test="${day lt 10 }">
				        <option value="0${day}">0${day}</option>
				    </c:when>
				    <c:otherwise>
				        <option value="${day}">${day}</option>
				    </c:otherwise>
				</c:choose>
				</c:forEach>	
			</select>
		</div> 	
		
		<div class="form-group">
			<h5><b>성별</b></h5>
				<select class="form-control" name="gender" style="width:300px; height:30px;font-size:13px;" required readonly="readonly">
					<option value="${info.gender}" hidden>${info.gender}</option>
					<option value="남자">남자</option>
					<option value="여자">여자</option>
				</select>
		</div>
		<div class="form-group originAddr">
			 <h5><b>주소</b></h5>
			<input type="text" class="form-control" id="address" name="address" value="${info.address}" style="width:300px; height:30px;font-size:13px;" required readonly="readonly">
		</div>
		
		<div class="form-group modAddr">
			<h5><b>주소</b></h5>
            <input type="button" id="postcode_button" onclick="open_Postcode()" value="우편번호 찾기" style="width:300px; height:30px;font-size:13px;">
            <input type="text" class="form-control" name="modAddress" id="road_address" value="${info.address}" placeholder="도로명 주소(상세)" style="width:300px; height:30px;font-size:13px;">
		</div>
		
		<div>
			<button type="button" class="btn btn-info float-right toModForm">수정하기</button>
		</div>
		<div class="viewMode">
			<input type="submit" class="btn btn-primary float-right" value="수정"> 
			<button type="button" class="btn btn-secondary float-right backViewMode">취소</button>			
		</div>
	</form>
</div>
<%@ include file="../layout/footer.jsp" %>
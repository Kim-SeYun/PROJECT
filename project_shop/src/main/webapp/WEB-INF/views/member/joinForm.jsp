<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<script src="${contextPath}/resources/js/member/join.js"></script> 
	
<form class="container" action="${contextPath}/member/join" method="post" onsubmit="return checked()">
	<div class="container" align="center">
		<div class="jumbotron">
			<h2>회원 기본 정보</h2>
		</div>
		<div class="form-group">
			<h4>아이디</h4>
			<input type="text" class="form-control" name="id" value="" pattern="[a-zA-Z0-9]{4,12}" title="4~12자의 영문 대소문자, 숫자만 입력하세요"  style="width:300px; height:30px;font-size:20px;" required>
			<input type="button" onclick="idCheck()" value="중복 확인">
		</div>
		<div class="form-group">	
			<h4>비밀번호</h4>
			<input type="password" class="form-control" id="pwd" name="pwd" onkeyup="check_pwd()" value="" pattern="[a-zA-Z0-9!~^]{4,12}" title="4~12자의 영문 대소문자, 숫자, 특수문자(!~^)만 입력하세요." style="width:300px; height:30px;font-size:20px;" required> 
		</div>
		<div class="form-group">
			<h4>비밀번호 확인</h4>
			<input type="password" class="form-control" id="pwd_check" name="pwd_check" onkeyup="check_pwd()" value="" maxlength="12" style="width:300px; height:30px;font-size:20px;" required> 
            <span id="pwd_check_msg"></span>
		</div>
		<div class="form-group">
			<h4>이름</h4>
			<input type="text" class="form-control" name="name" value="" pattern="[가-힣]{2,17}" title="EX) 홍길동" style="width:300px; height:30px;font-size:20px;" required> 
		</div>
		<div class="form-group">
			<h4>이메일</h4>
			<input type="email" class="form-control" name="email" value="" pattern="[A-Za-z0-9_]*[@]{1}[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}" title="EX) example@example.com" style="width:300px; height:30px;font-size:20px;" required> 
		</div>
		<div class="form-group">
			<h4>생년월일</h4>
			<select class="form-control" id="year" name="year" style="width:300px; height:30px;font-size:13px;" required>
				  <option value="">년</option>
				  <c:forEach var="year" begin="1920" end="2023">
				    <option value="${year}">${year}</option>
				  </c:forEach>			
			</select>
			<select class="form-control" id="month" name="month" style="width:300px; height:30px;font-size:13px;" required>
				<option value="">월</option>
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
			<select class="form-control" id="day" name="day" style="width:300px; height:30px;font-size:13px;" required>
				<option value="">일</option>
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
			</select>
		</div>
		<div class="form-group">
			<h4>성별</h4>
			<!-- 남자<input type="radio" class="form-control" name="gender" value="남자" checked="checked" style="width:70px; height:30px;font-size:20px;"> 
            여자<input type="radio" class="form-control" name="gender" value="여자" style="width:70px; height:30px;font-size:20px;"> --> 
			<select class="form-control" name="gender" style="width:300px; height:30px;font-size:13px;" required>
				<option value="남자">남자</option>
				<option value="여자">여자</option>
			</select>
		</div>
		
		<div class="form-group">
			<h4>주소</h4>
			<input type="text" id="postcode" placeholder="우편번호" readonly > 
            <input type="button" id="postcode_button" onclick="open_Postcode()" value="우편번호 찾기"><br> 
            <input type="text" name="address1" id="road_address" placeholder="도로 주소" readonly>
            <input type="text" id="addr" name="address2" placeholder="상세 주소"><br> 
		</div>
	</div>
	
	<div class="form-group" align="center"> 
		<input type="submit" value="회원가입"> 
		<input type="reset" class="reset" value="다시 입력"> 
	</div> 
</form>
<%@ include file="../layout/footer.jsp" %>  
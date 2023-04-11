<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<script src="${contextPath}/resources/js/member/join.js"></script> 

	
<form action="${contextPath}/member/join" method="post" onsubmit="return checked()">
	<div class="container" >
		<h2><b>회원가입</b></h2>
	<div class="col-sm-12">
		<div class="form-group">
	<div class="row">
		<div class="col-sm-3">
			<h4>아이디</h4>
		</div>
		<div class="col-sm-6">
			<input type="text" class="form-control" name="id" id="id" value="" maxlength="12" onkeyup="check_id()" pattern="[a-zA-Z0-9]{4,12}" title="4~12자의 영문 대소문자, 숫자만 입력하세요" style="font-size:20px;" required>
		</div>
		<!-- 아이디 중복 체크 여부 -->
		<div class="col-sm-1">
			<input type="button" class="form-control checkId" style="width:100px; height:43px;" value="중복확인">
		</div>
		<input type="hidden" id="idDuplication" name="idDuplication" value=""/>
		<span id="id_check_msg"></span>
	</div>
</div>
		<div class="form-group">
			<div class="row">
				<div class="col-sm-3">
	    			<h4>비밀번호</h4>
	    		</div>
	    		<div class="col-sm-6">
					<input type="password" class="form-control" id="pwd" name="pwd" onkeyup="check_pwd()" value="" maxlength="16" pattern="[a-zA-Z0-9!~^]{4,16}" title="4~16자의 영문 대소문자, 숫자, 특수문자(!~^)만 입력하세요." style="font-size:20px;" required>
				</div>
			</div> 
		</div>
		<div class="form-group">
			<div class="row">
				<div class="col-sm-3">
					<h4>비밀번호 확인</h4>
				</div>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="pwd_check" name="pwd_check" onkeyup="check_pwd()" value="" maxlength="16" style="font-size:20px;" required> 
            	</div>
            <span id="pwd_check_msg"></span>
            </div>
		</div>
		<div class="form-group">
			<div class="row">
				<div class="col-sm-3">
					<h4>이름</h4>
				</div>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="name" value="" pattern="[가-힣]{2,17}" title="EX) 홍길동" style="font-size:20px;" required> 
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="row">
				<div class="col-sm-3">
					<h4>이메일</h4>
				</div>
				<div class="col-sm-6">
					<input type="email" class="form-control" name="email" value="" pattern="[A-Za-z0-9_]*[@]{1}[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}" title="EX) example@example.com" style="font-size:20px;" required>
				</div>
			</div> 
		</div>
		<div class="form-group">
			<div class="row">
				<div class="col-sm-3">
					<h4>생년월일</h4>
				</div>
				<div class="col-sm-2">
					<select class="form-control" id="year" name="year" style="font-size:20px;" required>
						  <option value="">년</option>
						  <c:forEach var="year" begin="1920" end="2023">
						    <option value="${year}">${year}</option>
						  </c:forEach>			
					</select>
				</div>
				<div class="col-sm-2">
					<select class="form-control" id="month" name="month" style="font-size:20px;" required>
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
				</div>
				<div class="col-sm-2">
					<select class="form-control" id="day" name="day" style="font-size:20px;" required>
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
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="row">
				<div class="col-sm-3">
					<h4>성별</h4>
				</div>
				<div class="col-sm-6">
					<select class="form-control" name="gender" class="form-control" style="font-size:20px;" required>
						<option value="남자">남자</option>
						<option value="여자">여자</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<div class="row">
				<div class="col-sm-3">
					<h4>주소</h4>
				</div>
				<div class="col-sm-6">
		            <input type="text" class="form-control" name="address1" id="road_address" placeholder="도로 주소" style="font-size:20px;"  readonly>
		            <input type="text" class="form-control" id="addr" name="address2" style="font-size:20px;" placeholder="상세 주소" required><br> 
		        </div>
		        <div class="col-sm-2">
		            <input type="button" class="form-control" id="postcode_button" onclick="open_Postcode()" style="width:100px; height:43px;" value="주소검색"><br>
		        </div> 
			</div>
		</div>
	</div>
	</div>
	
	<div class="form-group" align="center"> 
		<input type="submit" class="form-control" style="width:100px; height:43px; display:inline;" value="회원가입"> 
		<input type="reset" class="reset form-control" style="width:100px; height:43px; display:inline;" value="다시 입력"> 
	</div> 
</form>
<%@ include file="../layout/footer.jsp" %>  
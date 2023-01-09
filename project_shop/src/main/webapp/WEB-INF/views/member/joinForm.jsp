<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %> 
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
			<input type="text" class="form-control" name="year" id="year" value="" placeholder="YYYY" maxlength="4" pattern="[0-9]{4}" title="네 자리 수로 입력하세요." style="width:70px; height:30px; font-size:20px; " required>년 
            <input type="text" class="form-control" name="month" id="month" value="" placeholder="MM" maxlength="2" pattern="[0-9]{2}" title="두 자리 수로 입력하세요." style="width:70px; height:30px; font-size:20px; " required>월 
            <input type="text" class="form-control" name="day" id="day" value="" placeholder="DD" maxlength="2" pattern="[0-9]{2}" title="두 자리 수로 입력하세요." style="width:70px; height:30px; font-size:20px; " required>일 
		</div>
		<div class="form-group">
			<h4>성별</h4>
			남자<input type="radio" class="form-control" name="gender" value="남자" checked="checked" style="width:70px; height:30px;font-size:20px;"> 
            여자<input type="radio" class="form-control" name="gender" value="여자" style="width:70px; height:30px;font-size:20px;"> 
		</div>
		<div class="form-group">
			<h4>주소</h4>
			<input type="text" class="form-control" name="address" placeholder="도로명 또는 지번 주소" style="width:300px; height:30px;font-size:20px;" required>
		</div>
	</div>
	
<!--
	<table align="center" cellspacing="1"> 
        <tr> 
          <th colspan="2">회원 기본 정보</th> 
        </tr> 
        <tr> 
          <th>아이디</th> 
          <td> 
            <input type="text" name="id" value="" size="15" pattern="[a-zA-Z0-9]{4,12}" title="4~12자의 영문 대소문자, 숫자만 입력하세요" required/><button>중복확인</button>
          </td> 
        </tr> 
        <tr> 
          <th>비밀변호</th> 
          <td> 
            <input type="password" id="pwd" name="pwd" onkeyup="check_pwd()" value="" size="15" pattern="[a-zA-Z0-9!~^]{4,12}" title="4~12자의 영문 대소문자, 숫자, 특수문자(!~^)만 입력하세요." required/> 
          </td> 
        </tr> 
        <tr> 
          <th>비밀번호확인</th> 
          <td> 
            <input type="password" id="pwd_check" name="pwd_check" onkeyup="check_pwd()" value="" maxlength="12" size="15" required> 
            <span id="pwd_check_msg"></span> 
          </td> 
        </tr> 
        <tr> 
          <th>이름</th> 
          <td> 
            <input type="text" name="name" value="" size="20" pattern="[가-힣]{2,17}" title="EX) 홍길동" required> 
          </td> 
        </tr> 
        <tr> 
          <th>이메일</th> 
          <td> 
            <input type="email" name="email" value="" size="20" pattern="[A-Za-z0-9_]*[@]{1}[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}" title="EX) example@example.com" required> 
          </td> 
        </tr>
        <tr> 
          <th>생년월일</th> 
          <td> 
            <input type="text" name="year" id="year" value="" size="4" placeholder="YYYY" maxlength="4" pattern="[0-9]{4}" title="네 자리 수로 입력하세요.">년 
            <input type="text" name="month" id="month" value="" size="2" placeholder="MM" maxlength="2" pattern="[0-9]{2}" title="두 자리 수로 입력하세요.">월 
            <input type="text" name="day" id="day" value="" size="2" placeholder="DD" maxlength="2" pattern="[0-9]{2}" title="두 자리 수로 입력하세요.">일 
          </td> 
        </tr> 
		<tr> 
          <th>성별</th> 
          <td> 
            남자<input type="radio" name="gender" value="남자" checked="checked"> 
            여자<input type="radio" name="gender" value="여자"> 
          </td> 
        </tr> 
        <tr> 
          <th>주소</th> 
          <td>
            <input type="text" name="address" placeholder="도로명 또는 지번 주소"><br> 
          </td> 
        </tr> 
	</table>  
-->
      
      <div class="form-group" align="center"> 
        <br>
        <input type="submit" value="회원가입"> 
        <input type="reset" class="reset" value="다시 입력"> 
      </div> 
    </form> 

<%@ include file="../layout/footer.jsp" %>  
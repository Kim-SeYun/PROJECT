<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>  

<div class="container">
	<div class="jumbotron">
		<h1>Sign Up</h1>
	</div>
	
	<form action="${contextPath}/member/join" method="post" id="submit" onsubmit="return test()">
		<div class="form-group">
			<h5><b>아이디</b></h5>
			<input type="text" class="form-control user_name" name="id" height="60">
			<button type="button" class="form-control idCheck" onclick="idCheck()">중복검사</button>
		</div>
		<div class="form-group">
			<h5><b>비밀번호</b></h5>
	        <input type="password" class="form-control" name="pwd">
		</div>
		<div class="form-group">
			<h5><b>비밀번호 확인</b></h5>
			<input type="password" class="form-control" name="pwck">
		</div>
		<div class="form-group">
			<h5><b>이름</b></h5>
			<input type="text" class="form-control" name="name">
		</div>
		<div class="form-group">
			<h5><b>이메일</b></h5>
			<input type="text" class="form-control" name="email">
		</div>
		<div class="form-group">
			<h5><b>생년월일</b></h5>
			<div >
               <div class="birth_day">
                 <input type="text" name="year" class="form-control" placeholder="YYYY">
                 <span class="bar"></span>
                 <input type="text" name="month" class="form-control" placeholder="MM">
                 <span class="bar"></span>
                 <input type="text" name="day" class="form-control" placeholder="DD">
               </div>
             
             </div>
		</div>
		
		<!-- <div class="form-group">
			<h5><b>성별</b></h5>
			<form>
				<select id="gender" name="gender" class="custom-select mb-3" aria-label="성별">
					<option value selected>선택안함</option>
					<option value="M">남자</option>
					<option value="F">여자</option>
				</select>
			</form>
		</div> -->
		<div>
			<h5><b>성별</b></h5>
			<input type="text" name="gender" class="form-control">
		</div>
		<div class="form-group">
			<h5><b>주소</b></h5> 
			<input type="text" class="form-control" name="address"><br>
			<input type="text" class="form-control" name="address">
		</div>
		<button class="btn btn-primary" style="float: right;">가입하기</button>
	</form>
</div>

<%@ include file="../layout/footer.jsp" %>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../layout/header.jsp" %>  
<style>
		body {
			font-family: 'Nanum Gothic', sans-serif;
		}
		.con {
			max-width: 500px;
			margin: 0 auto;
			padding: 50px;
			background-color: #FFFFFF;
			border-radius: 10px;
			text-align: center;
		}
		h1 {
			color: black;
			font-weight: bold;
			font-size: 1.5rem;
			margin-bottom: 50px;
		}
		input[type="text"], input[type="password"] {
		  display: block;
		  width: 90%;
		  padding: 10px;
		  margin: 0 auto 20px auto; /* 수평 중앙 정렬을 위해 margin 값을 수정합니다. */
		  border-radius: 5px;
		  border: 1px solid #EAEAEA;
		  font-size: 1.2rem;
		  color: #444444;
		  text-align: center; /* 입력 요소를 가운데 정렬합니다. */
		}

		button[type="submit"] {
		  background-color: #bd6abc; /* 배경을 흰색으로 설정합니다. */
		  color: #FFFFFF;
		  width: 90%;
		  padding: 10px;
		  border: 1px solid white; /* 테두리를 회색으로 설정합니다. */
		  border-radius: 5px;
		  font-size: 1.2rem;
		  cursor: pointer;
		  transition: background-color 0.3s ease-in-out;
		}

		button[type="button"] {
		  background-color: white; /* 배경을 흰색으로 설정합니다. */
		  color: #bd6abc;
		  width: 90%;
		  padding: 10px;
		  border: 1px solid #bd6abc; /* 테두리를 회색으로 설정합니다. */
		  border-radius: 5px;
		  font-size: 1.2rem;
		  cursor: pointer;
		  transition: background-color 0.3s ease-in-out;
		}

	</style>  
<div class="container con">
		<h1>로그인</h1>
		<form action="${contextPath}/member/login" method="post">
			<input type="text" id="id" name="id" placeholder="아이디를 입력해주세요" required>
			<input type="password" id="pwd" name="pwd" placeholder="비밀번호를 입력해주세요" required>
			<br>
			<button type="submit">로그인</button>
			<br><br>
			<a href="${contextPath}/member/joinForm"><button type="button">회원가입</button></a>
		</form>
	</div>

<%@ include file="../layout/footer.jsp" %>  
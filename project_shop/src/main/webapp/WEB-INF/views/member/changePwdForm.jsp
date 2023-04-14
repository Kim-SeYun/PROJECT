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
		input[type="text"], input[type="tel"], input[type="password"] {
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

		a.join {
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
    <h1>비밀번호 변경</h1>
    <form id="changePwdForm" action="${contextPath}/member/doChangePwd" method="post">
        <div class="form-group">
            <label for="pwd">새 비밀번호</label>
            <input type="password" id="pwd" name="pwd" class="form-control" placeholder="새 비밀번호를 입력하세요" required>
        </div>
        <div class="form-group">
            <label for="passwordConfirm">새 비밀번호 확인</label>
            <input type="password" id="pwdCheck" name="pwdCheck" class="form-control" placeholder="새 비밀번호를 다시 입력하세요" required>
        </div>
        <input type="hidden" id="id" name="id" value="${id}">
        <button type="submit" class="btn btn-primary">비밀번호 변경</button>
    </form>
</div>


<%@ include file="../layout/footer.jsp" %>  
<script>
	let urlParams = new URLSearchParams(window.location.search);
	let id = urlParams.get('id');
	document.getElementById('id').value = id;
	
	$(document).ready(function() {
	    $("#changePwdForm").submit(function(event) {
	        // 폼 전송을 중지
	        event.preventDefault();

	        // 입력된 비밀번호 가져오기
	        var pwd = $("#pwd").val();
	        var pwdCheck = $("#pwdCheck").val();
	        var id = $("#id").val();
	        
	        // 비밀번호와 비밀번호 확인이 일치하는지 확인
			if(pwd !== pwdCheck) {
			    alert("입력한 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			    $("#pwd").val("");
			    $("#pwdCheck").val("");
			    return;
			}


	        // 서버에 데이터 전송하기
	        $.ajax({
	            type: "POST",
	            url: "${contextPath}/member/doChangePwd",
	            data: {
	                pwd: pwd,
	                id: id
	            },
	            success: function(result) {
	                alert('비밀번호가 변경되었습니다.')
	                window.location.href = "${contextPath}/member/loginForm";
	                
	            },
	            error: function(xhr, status, error) {
	                console.error(xhr.responseText);
	            }
	        });
	    });
	});

</script>

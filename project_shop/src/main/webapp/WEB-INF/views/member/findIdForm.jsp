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
	    <h1>아이디 찾기</h1>
	        <div class="form-group">
	            <label for="name">이름</label>
	            <input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요" required>
	        </div>
	        <div class="form-group">
	            <label for="phone">휴대폰 번호</label>
	            <input type="tel" id="phone" name="phone" class="form-control" placeholder="'-'를 제외하고 입력하세요" pattern="[0-9]{10,11}" required>
		        <button type="button" id="sendCertificationBtn" class="btn btn-info">인증번호 전송</button>
		        <button type="button" id="resendCertificationBtn" class="btn btn-info" disabled>재전송</button>
	        </div>
	        <div class="form-group">
	            <label for="certification">인증번호</label>
	            <input type="text" id="certification" name="certification" class="form-control" placeholder="인증번호를 입력하세요" required disabled>
	            <input type="hidden" id="check" name="check" class="form-control">
	        </div>       
	        <button type="button" id="checkCertificationBtn" class="btn btn-primary" disabled>인증번호 확인</button>
	</div>

<%@ include file="../layout/footer.jsp" %>

<script>

$(document).ready(function() {
	$("#resendCertificationBtn").hide();
});

$('#sendCertificationBtn').on('click', function() {
	
        // 입력된 이름과 전화번호 가져오기
        var name = $("#name").val();
        var phone = $("#phone").val();

        // 서버에 데이터 전송하기
        $.ajax({
            type: "POST",
            url: "${contextPath}/member/checkInfo",
            data: {
                name: name,
                phone: phone
            },
            success: function(result) {
            	if (result == true) {
            		$("#sendCertificationBtn").hide();
            		$("#resendCertificationBtn").show();
                	$("#sendCertificationBtn").prop("disabled", true);
                	$("#resendCertificationBtn").prop("disabled", false);
                	$("#checkCertificationBtn").prop("disabled", false);
                	$("#certification").prop("disabled", false);
                	$("#name").prop("disabled", true);
                	$("#phone").prop("disabled", true);
                	
                	$.ajax({
                		type: "POST",
                		url: "${contextPath}/member/sendCertificationNumber",
                		async: false,
                		success: function(result) {
                			alert("인증번호가 발송되었습니다. 인증번호를 입력해주세요.");
                			$("#check").val(result);
                			
                		},
                        error: function(xhr, status, error) {
                            console.error(xhr.responseText);
                        }
                	});
                } else {
                    alert("입력 정보를 다시 확인해주세요.");
                    $("#name").val("");
    			    $("#phone").val("");
    			    return;
                }
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    });

$('#checkCertificationBtn').on('click', function() {
	  var certificationNumber = $('#certification').val(); // 입력한 인증번호
	  var checkNumber = $('#check').val(); // hidden input의 인증번호
      var name = $("#name").val();
      var phone = $("#phone").val();

	  if(certificationNumber === checkNumber) { // 인증번호가 일치하면
		  alert('인증되었습니다.')
	  
	        $.ajax({
	            type: "POST",
	            url: "${contextPath}/member/findId",
	            data: {
	                name: name,
	                phone: phone
	            },
	            success: function(result) {
					window.location.href = '${contextPath}/member/idCheckForm?id=' + result;
	            },
	            error: function(xhr, status, error) {
	                console.error(xhr.responseText);
	            }
	        });			
	  
	  } else { // 인증번호가 일치하지 않으면
	    alert('인증번호가 일치하지 않습니다.'); // 경고창 띄우기
	  }
	});
	
$('#resendCertificationBtn').on('click', function() {
    var name = $("#name").val();
    var phone = $("#phone").val();
    
    $.ajax({
        type: "POST",
        url: "${contextPath}/member/sendCertificationNumber",
        async: false,
        success: function(result) {
            alert("인증번호가 재전송되었습니다. 인증번호를 입력해주세요.");
            $("#check").val(result);
            
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText);
        }
    });
});
	
</script>



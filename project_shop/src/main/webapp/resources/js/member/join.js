function open_Postcode(){  
  new daum.Postcode({ 
    oncomplete: function(data) { 
 
       document.getElementById("road_address").value = data.roadAddress;
  } 
}).open(); 
} 

$(function() {
	$('.checkId').on('click', function(){
	var userId = document.getElementById('id').value;
	var idReg = /^[A-za-z0-9]{4,12}$/g;
	if(userId != '' && idReg.test(userId) ) {
		$.ajax({
			type : 'get',
			url : `${contextPath}/member/idCheck`,
			data : {id : userId},
			success : function(result) {
				if(result == 1 && userId.length > 3) {
					/*document.getElementById('id_check_msg').innerHTML = "<font color=red>이미 사용중인 아이디 입니다. </font>";*/
					// alert('이미 사용중인 아이디입니다.')
					document.getElementById('id_check_msg').innerHTML = "<font color=red>이미 사용중인 아이디입니다.</font>";
					// document.getElementById('id').value = "";
					document.getElementById('idDuplication').value = "idUncheck";
				} else if(result == 0 && userId.length > 3) {
					// alert('사용할 수 있는 아이디입니다.');
					document.getElementById('id_check_msg').innerHTML = "<font color=blue>사용할 수 있는 아이디입니다.</font>";
					document.getElementById('idDuplication').value = "idChecked";
				} else if(!idReg.test(userId.val())) {
					alert('오류')
				}else {
					alert('네 자리 이상 작성해주세요. ');
					document.getElementById('idDuplication').value = "idUncheck";
				} 
			},
			error : function() {
				alert('중복확인 실패')
			}
		})
		} else if(!idReg.test(userId)){
			document.getElementById('id_check_msg').innerHTML = "<font color=red>4~12자의 영문 대소문자, 숫자만 입력하세요.</font>";
			document.getElementById('idDuplication').value = "idUncheck";
			
		} else {
			alert('아이디를 입력하세요')
			document.getElementById('id_check_msg').innerHTML = "";
			document.getElementById('idDuplication').value = "idUncheck";
		} 
		 
	})
})


$(function() {
	$('.viewMode').hide();
	$('.modAddr').hide();
	
	let viewForm = $('#viewForm');
	
	let pwdObj = $('input[name="pwd"]');
	let emailObj = $('input[name="email"]');
	let yearObj = $('select[name="year"]');
	let monthObj = $('select[name="month"]');
	let dayObj = $('select[name="day"]');
	let genderObj = $('select[name="gender"]');
	let addressObj = $('input[name="address"]');
	
	let pwdVal = pwdObj.val();
	let emailVal = emailObj.val();
	let yearVal = yearObj.val();
	let monthVal = monthObj.val();
	let dayVal = dayObj.val();
	let genderVal = genderObj.val();
	let addressVal = addressObj.val(); 
	
	// 수정모드
	$('.toModForm').on('click', function(){
		
		$('input[name="pwd"],input[name="email"]').attr("readonly",false);
		$('select[name="year"],select[name="month"],select[name="day"]').attr("readonly",false);
		$('select[name="gender"],input[name="address"]').attr("readonly",false);
		$('.originAddr').hide();
		$('.modAddr').show();
		$('.toModForm').hide();
		$('.viewMode').show();
	});
	
/*	// 수정 처리
	$('.modify').on('click', function(){
		viewForm.attr({
			"action" : `${contextPath}/member/modMember`,
			"method" : "post"
		}).submit();
		alert("수정이 완료되었습니다.")
	});*/
	
	// 뷰모드
	$('.backViewMode').on('click', function(){
		$('input[name="pwd"],input[name="email"]').attr("readonly",true);
		$('select[name="year"],select[name="month"],select[name="day"]').attr("readonly",true);
		$('select[name="gender"],input[name="address"]').attr("readonly",true);
		$('.viewMode').hide();
		$('.toModForm').show();
		$('.modAddr').hide();
		$('.originAddr').show();
		pwdObj.val(pwdVal); // 수정전 내용 복원
		emailObj.val(emailVal);
		yearObj.val(yearVal);
		monthObj.val(monthVal);
		dayObj.val(dayVal);
		genderObj.val(genderVal);
		addressObj.val(addressVal);
	});
	
	// 다시입력
	$('.reset').on('click', function() {
		document.getElementById('pwd_check_msg').innerHTML = ""; 
	});
	
});

function check_pwd(){  //비밀번호 확인 
    var pwd = document.getElementById('pwd').value; 
    var pwd_check = document.getElementById('pwd_check').value; 
 
    if (pwd!=pwd_check) { 
      document.getElementById('pwd_check_msg').innerHTML = "<font color=red>비밀번호가 일치하지 않습니다.</font>"; 
    } 
    else { 
        document.getElementById('pwd_check_msg').innerHTML = "<font color=blue>비밀번호가 일치합니다.</font>"; 
    } 
    
    if (pwd_check=="") { 
      document.getElementById('pwd_check_msg').innerHTML = ""; 
    } 
 }
 
  
 
function check_id(){  //아이디 중복 확인 
    var id = document.getElementById('id').value;  
    
    if (id=="") { 
      document.getElementById('idDuplication').value = ""; 
    }
    
	$("#id").on("propertychange change keyup paste input", function(){
		document.getElementById('idDuplication').value = "idUncheck";
		document.getElementById('id_check_msg').innerHTML = "";
	});     
	     
}



 
function checked(){  //form 유효성 검사 

var pwd = document.getElementById('pwd'); 
var pwd_check = document.getElementById('pwd_check'); 

if(document.getElementById('idDuplication').value == "idUncheck" || document.getElementById('idDuplication').value == "") {
	alert("아이디 중복체크를 해주세요.")
	return false;
}

if (pwd.value != pwd_check.value) {  //비밀번호 확인 
  alert("비밀번호가 일치하지 않습니다. 다시 입력해 주세요."); 
  pwd_check.focus(); 
  return false; 
}  

if (document.getElementById('postcode').value=="") { //주소 확인 
  alert("주소를 입력해주세요."); 
  document.getElementById('postcode_button').focus(); 
  return false; 
} 

if(document.getElementById('addr').value=="") {
	alert("상세주소를 입력해주세요.")
	document.getElementById('addr').focus();
	return false; 
}
else { 
  return true; 
}

}

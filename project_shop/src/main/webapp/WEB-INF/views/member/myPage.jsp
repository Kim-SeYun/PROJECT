<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<script src="${contextPath}/resources/js/member/join.js"></script>  
<div class="container">
	<div class="jumbotron">
		<h1>MyPage</h1>
	</div>
	
	 <div class="col-sm-3">
      <ul class="nav nav-pills flex-column">
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/member/myPage">개인정보수정</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">주문내역</a>
        </li>
      </ul>
    </div>
    
	<form id="viewForm">
		<div class="form-group">
			<h5><b>아이디</b></h5>
			<input type="text" class="form-control" name="id" value="${info.id}" readonly="readonly">
		</div>
		<div class="form-group">
			<h5><b>비밀번호 변경</b></h5>
	        <input type="password" class="form-control" name="pwd" value="****" readonly="readonly">
		</div>
		<div class="form-group">
			<h5><b>이름</b></h5>
			<input type="text" class="form-control" name="name" value="${info.name}" readonly="readonly">
		</div>
		<div class="form-group">
			<h5><b>이메일</b></h5>
			<input type="email" class="form-control" name="email" value="${info.email}" readonly="readonly">
		</div>
		<div class="form-group">
			<h5><b>생년월일</b></h5>
			<div>
               <div class="form-group">
                 <input type="text" name="year" id="year" class="form-control" placeholder="YYYY" value="${info.year}" readonly="readonly">
                 <span class="bar"></span>
                 <input type="text" name="month" id="month" class="form-control" placeholder="MM" value="${info.month}" readonly="readonly">
                 <span class="bar"></span>
                 <input type="text" name="day" id="day" class="form-control" placeholder="DD" value="${info.day}" readonly="readonly">
               </div>
             </div>
		</div>
		<div class="form-group">
			<h5><b>성별</b></h5>
			<c:if test="${info.gender eq '남자'}">
				남자<input type="radio" name="gender" value="남자" checked="checked"> 
            	여자<input type="radio" name="gender" value="여자">
			</c:if>
			<c:if test="${info.gender eq '여자'}">
				남자<input type="radio" name="gender" value="남자"> 
            	여자<input type="radio" name="gender" value="여자" checked="checked">
			</c:if>
		</div>
		<div class="form-group">
			<h5><b>주소</b></h5> 
			<input type="text" class="form-control" name="address" value="${info.address}" readonly="readonly">
		</div>
		<div>
			<button type="button" class="btn btn-info float-right toModForm">수정하기</button>
		</div>
		<div class="viewMode">
			<button type="button" class="btn btn-primary float-right modify" >수정</button>
			<button type="button" class="btn btn-secondary float-right backViewMode">취소</button>			
		</div>
	</form>
</div>
<%@ include file="../layout/footer.jsp" %>
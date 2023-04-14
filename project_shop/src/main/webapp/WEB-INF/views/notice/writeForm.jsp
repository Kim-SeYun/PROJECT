<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>  
<style>
.preview img {
    max-width: 500px;
    max-height: 500px;
    height: auto;
}


</style>
<div class="container">
	<div class="jumbotron">
		<h1>Write</h1>
	</div>
	
	<form action="${contextPath}/notice/write" method="post" enctype="multipart/form-data">
		<div class="form-group">
			제목 <input type="text" class="form-control" name="title" required>
		</div>
		<div class="form-group">
			내용 <textarea rows="10" class="form-control" name="content" required></textarea>
		</div>
		<div class="form-group">
			첨부파일 <input type="file" class="form-control" name="imageFileName">
		</div>
		<div class="preview"></div>
		<div class="form-group">
			작성자 <input type="text" class="form-control" name="writer" value="${auth.id}" readonly="readonly" style="background-color: white;" >
		</div>
		<div style="overflow: hidden">
			<a href="${contextPath}/notice/list" class="btn btn-secondary float-right">취소</a>
			<button class="btn btn-primary float-right mr-2">작성하기</button>
		</div>		
	</form>
</div>
<%@ include file="../layout/footer.jsp" %> 
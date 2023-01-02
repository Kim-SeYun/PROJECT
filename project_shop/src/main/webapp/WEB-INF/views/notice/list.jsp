<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>  
<script src="${contextPath}/resources/js/notice/list.js"></script>  
<h1>NOTICE</h1>
<a href="${contextPath}/notice/writeForm" class="btn btn-dark noticeWrite"  style="float: right;">Write</a>
<div class="container my-3">
	<form id="listForm">
		<table class="table">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:forEach items="${list}" var="b">
			<tr>
				<td>
					${b.bno}
				</td>
				<td>
					<a href="${b.bno}" class="title">${b.title}</a>
				</td>
				<td>${b.writer}</td>
				<td>${b.writeDate}</td>
			</tr>
			</c:forEach>
		</table>
	</form>
	
</div>


<%@ include file="../layout/footer.jsp" %> 
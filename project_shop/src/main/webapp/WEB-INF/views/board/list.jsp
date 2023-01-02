<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../layout/header.jsp" %>  
<script src="${contextPath}/resources/js/board/list.js"></script>  
<h1>Q&A</h1>
<a href="${contextPath}/board/writeForm" class="btn btn-dark boardWrite"  style="float: right;">Write</a>
<br><br>
<div class="container my-3">
	<form id="listForm">
		<table class="table">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>답변여부</th>
			</tr>
			<c:forEach items="${list}" var="b">
			<tr>
				<td>
					${b.bno}
				</td>
				<td>
					<a href="${b.bno}" class="title">${b.title} 
					<b>${b.replyCount != 0 ? '['+= b.replyCount+=']' : ''}</b></a>
				</td>
				<td>${b.writer}</td>
				<td>${b.writeDate}</td>
				<td>${b.replyCount != 0 ? 'O' : 'X'}</td>
			</tr>
			</c:forEach>
		</table>
	</form>
	
</div>

<%@ include file="../layout/footer.jsp" %>  
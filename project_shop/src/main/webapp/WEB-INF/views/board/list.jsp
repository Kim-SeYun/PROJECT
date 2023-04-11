<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>  
<script src="${contextPath}/resources/js/board/list.js"></script>
  
<div class="container my-3">
<h1>Q&A</h1>
<a href="${contextPath}/board/writeForm" class="btn btn-dark boardWrite" style="float: right; margin-right: 0px;">Write</a>
<br><br>
	<form id="listForm">
	<input type="hidden" value="${param.pageNum}" name="pageNum">
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
	<ul class="pagination d-flex justify-content-center">
		<c:if test="${p.prev}">
	  		<li class="page-item"><a class="page-link" href="?pageNum =${p.startPage-1}">Previous</a></li>
		</c:if>
	  
	  <c:forEach begin="${p.startPage}" end="${p.endPage}" var="pageBtn">
		  <li class="page-item ${pageBtn==param.pageNum or (pageBtn==1 and param.pageNum==null) ? 'active' : ''}">
		 	 <a class="page-link" href="?pageNum=${pageBtn}">${pageBtn}</a>
		  </li>
	  </c:forEach>
	  <c:if test="${p.next}">
		  <li class="page-item"><a class="page-link" href="?pageNum=${p.endPage+1}">Next</a></li>
	  </c:if>
	</ul>
</div>

<%@ include file="../layout/footer.jsp" %>  
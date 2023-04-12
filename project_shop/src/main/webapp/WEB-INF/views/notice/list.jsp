<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>  
<script src="${contextPath}/resources/js/notice/list.js"></script>  

<style>
	.noticeWrite {
		background-color: #bd6abc; 
		color: #FFFFFF; 
		border: 1px solid white;
	}
	
	.noticeWrite:hover {
	  background-color: #FFFFFF;
	  color: #bd6abc;
	  border: 1px solid #bd6abc;
	  
}
</style>

<div class="container my-3">
<h1 style="margin-top: 5%; text-align: center;">NOTICE</h1>
<a href="${contextPath}/notice/writeForm" class="btn noticeWrite" style="float: right; margin-right: 0px;">Write</a>
<br><br>

	<form id="listForm">
		<input type="hidden" value="${param.pageNum}" name="pageNum">
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
	
	<ul class="pagination d-flex justify-content-center">
	    <c:if test="${p.prev}">
	        <li class="page-item"><a class="page-link" href="?pageNum=${p.startPage-1}">Previous</a></li>
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
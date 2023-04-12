<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<script src="${contextPath}/resources/js/notice/detail.js"></script> 

<div class="container">
	<h2 style="margin-top: 5%; text-align: center;">NOTICE</h2>
	<form id="viewForm" enctype="multipart/form-data">
		<table class="table" style="margin-top: 5%;">
			<tr>
				<th>글번호</th>
				<td>
					${notice.bno}
					<input type="hidden" name="bno" value="${notice.bno}">
				</td>
				<th>조회수</th>
				<td>000</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${notice.writer}</td>
				<th>작성일</th>
				<td>${notice.writeDate}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">
				<input type="text" name="title" class="form-control" value="${notice.title}" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<textarea rows="10" name="content" class="form-control" readonly="readonly">${notice.content}</textarea>
				</td>
			</tr>
			<tr>
				<th>첨부이미지</th>
				<td colspan="3">
					<input type="file" name="imageFileName" class="form-control viewMode">
					<div class="my-2">
					<c:if test="${not empty notice.imageFileName}">
						<input type="hidden" name="originFileName" value="${notice.imageFileName}">
						<div class="preview">
							<img class="originImg" src="${contextPath}/fileDownload?no=${notice.bno}&imageFileName=${notice.imageFileName}&path=notice">
						</div>
					</c:if>
					<c:if test="${empty notice.imageFileName}">
					<div class="preview">
						<p>등록된 이미지가 없습니다.</p>
					</div>
					</c:if>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4" class="text-center">
					<c:if test="${auth.id eq notice.writer or auth.grade eq 'ROLE_ADMIN'}">
						<button type="button" class="btn btn-info toModForm">수정하기</button>
						<button type="button" class="btn btn-secondary remove">삭제</button>
					</c:if>
					<button type="button" class="btn btn-success toList">목록</button>
				</td>
			</tr>
			<tr class="viewMode">
				<c:if test="${auth.id eq notice.writer or auth.grade eq 'ROLE_ADMIN'}">
					<td colspan="4" class="text-center">
						<input type="hidden" name="pageNum" value="">
						<button type="button" class="btn btn-primary modify">수정</button>
						<button type="button" class="btn btn-secondary backViewMode">취소</button>
					</td>
				</c:if>
			</tr>
		</table>
	</form>
</div>

<%@ include file="../layout/footer.jsp" %>  
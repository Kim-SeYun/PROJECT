let productReply = {
	
	list : function(name) {
		console.log(name)
		console.log('댓글목록')
		$.ajax({
			type : 'get',
			url : `${contextPath}/productReply/list`,
			data : {name : name}, 
			success : function(productReplyList) {
				console.log(productReplyList)
				productList(productReplyList);
			},
			error : function() {
				alert('댓글목록 조회 실패');
			} 			
		}); // ajax end
	}
	
	
};

function productList(productReplyList) {
	
	if(auth.grade != 'ROLE_ADMIN') {
		$('.productReplyForm').hide();
		$('.productReplyBtn').hide();
	}
	
	let output = '';
	for(let p of productReplyList) {
			output += 
				`<li class="list-group-item d-flex justify-content-between">
					<div>
						<p>${p.reply}</p>
						<span class="badge badge-info">${p.writer}</span>
						<span class="badge badge-warning">${p.replyDate}</span>
					</div>`
			if(p.writer==auth.id) { // 로그인한 사용자
				output+=`
				<div class="align-self-center" data-rno="${p.rno}">
					<button class="btn btn-sm btn-primary reply_modBtn">수정</button>
					<button class="btn btn-sm btn-danger reply_delBtn">삭제</button>
				</div>
				`;
	    	}
	    	if(auth.grade=='ROLE_ADMIN' && p.writer != 'admin') {
				output+=`
				<div class="align-self-center" data-rno="${p.rno}">
					<button class="btn btn-sm btn-danger reply_delBtn">삭제</button>
				</div>
				`;
	}
		}
	output += `</li>`;
	$('.productReplyList ul').html(output);
}
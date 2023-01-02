let replyService = {
	
	list : function(bno) {
		console.log('댓글목록')
		$.ajax({
			type : 'get',
			url : `${contextPath}/reply/list`,
			data : {bno : bno}, 
			success : function(replyList) {
				replyListRender(replyList);
			},
			error : function() {
				alert('댓글목록 조회 실패');
			} 			
		}); // ajax end
	},
	
	detail : function() {
		console.log('댓글조회')
	},
	
	write : function(replyVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/reply/write`,
			data : replyVO, 
			success : function(result) {
				$('.reply_content').val('');
				$('#feedback').find('.modal-body').html(result);
				$('#feedback').modal('show');
				replyService.list(replyVO.bno);
			},
			error : function(){
				alert('댓글 등록 에러');
			}
			
		}); // ajax end
	},
	
	modify : function() {
		console.log('댓글수정')
	},
	
	remove : function(replyVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/reply/remove`,
			data : replyVO,
			success : function(result) {
				$('#feedback').find('.modal-body').html(result);
				$('#feedback').modal('show');
				replyService.list(replyVO.bno)
			},
			error : function() {
				alert('댓글 삭제 에러')
			}
			
		}); // ajax end
		console.log('댓글삭제')
	}
};

// 댓글 화면 렌더링
function replyListRender(replyList) {
	
	if(auth.grade != 'ROLE_ADMIN') {
		$('.replyForm').hide();
		$('.replyBtn').hide();
	}
	
	let output = '';
	for(let r of replyList) {
			output += 
				`<li class="list-group-item d-flex justify-content-between">
					<div>
						<p>${r.reply}</p>
						<span class="badge badge-info">${r.writer}</span>
						<span class="badge badge-warning">${r.replyDate}</span>
					</div>`
			if(r.writer==auth.id) { // 로그인한 사용자
				output+=`
				<div class="align-self-center" data-rno="${r.rno}">
					<button class="btn btn-sm btn-primary reply_modBtn">수정</button>
					<button class="btn btn-sm btn-danger reply_delBtn">삭제</button>
				</div>
				`;
	    	}
	    	if(auth.grade=='ROLE_ADMIN' && r.writer != 'admin') {
				output+=`
				<div class="align-self-center" data-rno="${r.rno}">
					<button class="btn btn-sm btn-danger reply_delBtn">삭제</button>
				</div>
				`;
	}
		}
	output += `</li>`;
	$('.replyList ul').html(output);
}
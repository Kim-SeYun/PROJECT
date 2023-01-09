let productReply = {
	
	list : function(name) {
		console.log('댓글목록')
		$.ajax({
			type : 'get',
			url : `${contextPath}/productReply/p_list`,
			data : {name : name}, 
			success : function(list) {
				replyListRender(list);
			},
			error : function() {
				alert('댓글목록 조회 실패');
			} 			
		}); // ajax end
	}
}
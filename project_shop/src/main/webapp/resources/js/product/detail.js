
$(function(){
	let name = new URLSearchParams(location.search).get('name');
	productReply.list(name);
	
	// 댓글 쓰기
	$('.reply_write').on('click', function(){
		let write = $('.reply_writer').val()
		let reply = $('.reply_content').val()
		
		let productReplyVO = {
			pno : pno,
			reply : reply,
			writer : writer
		}
		productReplyService.write(productReplyVO);
		
		
	});
})

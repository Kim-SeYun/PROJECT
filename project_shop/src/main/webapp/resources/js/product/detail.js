
$(function(){
	let name = new URLSearchParams(location.search).get('name');
	productReply.list(name);
	
	let pno = $('input[name="pno"]').val();
	
	// 리뷰 쓰기
	$('.reply_write').on('click', function(){
		let writer = $('.reply_writer').val()
		let reply = $('.reply_content').val()
		
		let productReplyVO = {
			pno : pno,
			reply : reply,
			writer : writer
		}
		productReply.write(productReplyVO);
		productReply.list(name);		
		
	});
})

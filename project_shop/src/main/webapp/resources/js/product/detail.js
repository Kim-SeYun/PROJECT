
$(function(){
	let name = new URLSearchParams(location.search).get('name');
	productReply.list(name);
	console.log(name)
	
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
	
	$('.productReplyList').on('click','.p_reply_delBtn', function() {
		let rno = $(this).closest('div').data('rno');
		
		let productReplyVO = {
			pno : pno,
			rno : rno
		}
		productReply.remove(productReplyVO);
		productReply.list(name);
	});
	
	let n = 0;
	let price = $('.price').val();
	let total = price * 1;
	$('.totalPrice').val(total.toLocaleString('ko-KR')+"원");
	
	$('.plus').on('click', function(){
	    let count = Number($('.cartCnt:eq('+n+')').val()) + 1;
	    $('.cartCnt:eq('+n+')').val(count);
	    
	    let total = count * price;
	    $('.totalPrice').val(total.toLocaleString('ko-KR')+"원");
	});
	
	$('.minus').click(function(){ 
	    let count = Number($('.cartCnt:eq('+n+')').val()) - 1;
	    if(count < 1) {
	        count = 1;
	    }
	    $('.cartCnt:eq('+n+')').val(count);
	    
	    let total = count * price;
	    $('.totalPrice').val(total.toLocaleString('ko-KR')+"원");
	});
	
})

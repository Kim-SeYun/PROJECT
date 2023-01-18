
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
	
	$('.plus').on('click', function(){
		//let count = $('input[name="num"]').val();
		//console.log(count)
		//var n = $('.plus').index(this);
		//console.log(n)
		var n = 0
		var num = $(".num:eq("+n+")").val();
    	console.log(num)
    	num = $(".num:eq("+n+")").val(num*1+1);
	})
	$('.minus').click(function(){ 
	var n = 0
    var num = $(".num:eq("+n+")").val();
    console.log(num)
    num = $(".num:eq("+n+")").val(num*1-1); 
  });
	
	
})

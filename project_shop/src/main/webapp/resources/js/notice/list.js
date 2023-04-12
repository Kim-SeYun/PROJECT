$(function(){

	$('.title').on('click',function(e){
		let listForm = $('#listForm')
		e.preventDefault();
		$('[name="bno"]').remove();
		//let bnoData = "<input type='hidden' name='bno' value='"+$(this).data('bno')+"'/>";
		let bnoData = "<input type='hidden' name='bno' value='"+$(this).attr('href')+"'/>";
		listForm.append(bnoData)
				.attr("action", `${contextPath}/notice/detail`)
				.submit();
	});
	
	
	if(auth.grade != 'ROLE_ADMIN') {
		$('.noticeWrite').hide();
	}
	
	
});
$(function(){

	$('.name').on('click',function(e){
		let productForm = $('#productForm')
		e.preventDefault();
		$('[name="pno"]').remove();
		let pnoData = "<input type='hidden' name='pno' value='"+$(this).attr('href')+"'/>";
		listForm.append(pnoData)
				.attr("action", `${contextPath}/product/detail`)
				.submit();
	});
	
	
});
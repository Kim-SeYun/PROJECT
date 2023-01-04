$(function(){

	$('.name').on('click',function(e){
		let productForm = $('#productForm')
		e.preventDefault();
		$('[name="pno"]').remove();
		let pnoName = "<input type='hidden' name='name' value='"+$(this).attr('href')+"'/>";
		productForm.append(pnoName)
				.attr("action", `${contextPath}/product/detail`)
				.submit();
	});
	
	
});
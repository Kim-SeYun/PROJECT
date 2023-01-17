$(function(){
	$('.name').on('click',function(e){
		let productForm = $('#productForm')
		e.preventDefault();
		$('[name="name"]').remove();
		let pnoName = "<input type='hidden' name='name' value='"+$(this).attr('href')+"'/>";
		console.log(pnoName)
		productForm.append(pnoName)
				.attr("action", `${contextPath}/product/detail`)
				.submit();
	});
	
	$('.cartBtn').on('click', function(e){
		let data = $(this).attr('value');
		alert(data)
		console.log(data)
	})
	
	
});
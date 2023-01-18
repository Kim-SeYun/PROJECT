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
		console.log(data)
		if(auth.id !=null && auth.id !=''){
			
			$.ajax({
				type : 'post',
				url : `${contextPath}/cart/addCart`,
				data : {id : auth.id, pno : data}, 
				success : function(result) {
					console.log(result)
					alert(result)
					location.assign("/project_shop/cart/list")
				},
				error : function() {
					alert('장바구니 담기 실패');
				} 			
			}); // ajax end
		} else {
			alert('로그인으로')
			location.assign("/project_shop/member/loginForm")
		}
		
	})
	
	
});
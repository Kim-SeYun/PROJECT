$(function(){

	$('.user_name').on('click',function(e){
		if($('.user_name').val() == '') {
			alert('아이디를 입력해주세요.')
			return;
		}
		
	});
});
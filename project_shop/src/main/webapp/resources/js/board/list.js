$(function(){

$('.title').on('click',function(e){
    let listForm = $('#listForm');
    e.preventDefault();
    $('[name="bno"]').remove();
    let bnoData = "<input type='hidden' name='bno' value='"+$(this).attr('href')+"'/>";

    listForm.append(bnoData)
        .attr("action", `${contextPath}/board/detail`)
        .submit();
});
	
	if(auth.grade != 'ROLE_ADMIN' && auth.grade != 'ROLE_MEMBER') {
		$('.boardWrite').hide();
	}
	
});
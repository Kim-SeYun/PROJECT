// 게시물 관련
$(function(){
	$('.viewMode').hide(); // 파일폼 숨김 / 수정,취소 버튼 숨김
	
	let viewForm = $('#viewForm');
	let titleObj = $('input[name="title"]');
	let contentObj = $('textarea[name="content"]');
	let imageFile = "${notice.imageFileName}";
	let pTag = $('.preview p').html();
	
	let originImg = $('.originImg').clone();
	let titleVal = titleObj.val();
	let contentVal = contentObj.val();
	
	// 수정모드
	$('.toModForm').on('click', function(){
		$('input[name="title"],textarea[name="content"]').attr("readonly",false);
		$('.viewMode').show();
		$(this).closest('tr').hide();
	});
	
	// 뷰모드
	$('.backViewMode').on('click', function(){
		$('input[name="title"],textarea[name="content"]').attr("readonly",true);
		$('.viewMode').hide();
		$(this).closest('tr').prev().show();
		$('.preview').html(originImg); // 수정전 이미지 복원
		$('input[type="file"]').val(''); // 파일폼 초기화
		titleObj.val(titleVal); // 수정전 제목 복원
		contentObj.val(contentVal); // 수정전 내용 복원
		if(imageFile==''||imageFile==null) {
			$('.preview').html(pTag);
		}
	});

	// 목록으로
	$('.toList').on('click', function(){
	    const urlSearchParams = new URLSearchParams(window.location.search);
	    const pageNum = urlSearchParams.get('pageNum') || 1;
	
		window.location.href = `${contextPath}/notice?pageNum=${pageNum || 1}`;
	
	});

	$('.modify').on('click', function(){
	    const pageNum = new URLSearchParams(window.location.search).get('pageNum') || 1;
	    viewForm.find('[name=pageNum]').val(pageNum); // pageNum 값을 hidden input 태그에 설정
	    viewForm.attr({
	        "action" : `${contextPath}/notice/modNotice`,
	        "method" : "post"
	    }).submit();
	});

	
	$('.remove').on('click', function(){
	  if (confirm('삭제하시겠습니까?')) {
	    viewForm.attr({
	      "action" : `${contextPath}/notice/removeNotice`,
	      "method" : "post"
	    }).submit();
	  }
	});
	
	
});
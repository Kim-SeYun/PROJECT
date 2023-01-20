
$(function(){
	
	
	$('.c_plus').on('click', function(){
		let count = $('.cartCnt').val();
		console.log(count)
		//var n = $('.plus').index(this);
		//console.log(n)
		var n = 0
		var num = $(".cartCnt:eq("+n+")").val();
    	num = $(".cartCnt:eq("+n+")").val(num*1+1);
	})
	
	$('.c_minus').click(function(){ 
		var n = 0
	    var num = $(".cartCnt:eq("+n+")").val();
	    num = $(".cartCnt:eq("+n+")").val(num*1-1); 
  });
  
  
  $('.name').on('click',function(e){
		let cartForm = $('#cartForm')
		e.preventDefault();
		$('[name="name"]').remove();
		//let bnoData = "<input type='hidden' name='bno' value='"+$(this).data('bno')+"'/>";
		let nameData = "<input type='hidden' name='name' value='"+$(this).attr('href')+"'/>";
		cartForm.append(nameData)
				.attr("action", `${contextPath}/product/detail`)
				.submit();
	});
	
	$('.delAllCart').on('click', function() {
		$.ajax({
			type : 'post',
			url : `${contextPath}/cart/delAllCart`,
			data : {id : auth.id},
			success : function() {
				alert("모든 상품이 삭제되었습니다.")
				location.assign("/project_shop/cart/list")
			},
			error : function() {
				alert("삭제 실패")
			}
		})
	});
	
	let pnoSet = new Set();
	$('.cartCheckBox').on('change', function(){
		let pno = $(this).val();
		let isChecked = $(this).prop('checked')
		if(isChecked) {
			pnoSet.add(pno)
		} else {
			pnoSet.delete(pno)
		}
	});
	
	$('.cartAllCheckBox').change(function(){
		let pno = $('.cartCheckBox').val();
	
	
	if($(".cartAllCheckBox").is(':checked')) {
		$("input[name=chk]").each(function(i,e){
			$(e).prop("checked", true);
			pnoSet.add($(e).val());
		})
		
	} else {
		/*$("input[name=chk]").prop("checked", false);*/
		$("input[name=chk]").each(function(i,e){
			$(e).prop("checked", false);
			pnoSet.delete($(e).val());
		})
		/*pnoSet.delete(pno)*/
	}
	console.log(pnoSet)
	})
	
	$('.delCheckCart').on('click', function(){
		if(pnoSet.size<=0) {
			alert('삭제할 상품을 선택하세요');
			return;
		}

		let pnoListStr = Array.from(pnoSet).join()
			
		$.ajax({
			type : 'post',
			url : `${contextPath}/cart/delCheckCart`,
			data : {data : pnoListStr, id : auth.id},
			success : function() {
				alert('선택한 상품이 삭제되었습니다.')
				location.assign("/project_shop/cart/list")
			},
			error : function() {
				alert('장바구니 삭제 실패')
			}
		})			
	})	
	
	

	
});	


$(document).on("click", "input:checkbox[name=chk]", function() {
	
	var chks = document.getElementsByName("chk");
	var chksChecked = 0;
	
	for(var i=0; i<chks.length; i++) {
		var chk = chks[i];
		
		if(chk.checked) {
			chksChecked++;
		}
	}
	
	if(chks.length == chksChecked){
		$(".cartAllCheckBox").prop("checked", true);
	}else{
		$(".cartAllCheckBox").prop("checked",false);
	}
	
	
})

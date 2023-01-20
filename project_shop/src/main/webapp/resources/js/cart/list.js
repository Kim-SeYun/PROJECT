
$(function(){
	
	
	$('.c_plus').on('click', function(){
		var num = $(this).prev().val()*1+1;
		$(this).prev().val(num);
		let pno = $(this).val();
		
		$.ajax({
			type : 'post',
			url : `${contextPath}/cart/updateCount`,
			data : {id : auth.id, cnt : num, pno : pno},
			success : function() {
				location.assign("/project_shop/cart/list")
			},
			error : function() {
				alert("수정 실패")
			}
		})
	})
		
	$('.c_minus').click(function(){ 
		var n = 0
	    var num = $(this).next().val()*1-1;
	    let pno = $(this).val();
	    if(num<=1) {
		num = 1;
	}	
	$(this).next().val(num);
	$.ajax({
			type : 'post',
			url : `${contextPath}/cart/updateCount`,
			data : {id : auth.id, cnt : num, pno : pno},
			success : function() {
				location.assign("/project_shop/cart/list")
			},
			error : function() {
				alert("수정 실패")
			}
		})
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
	
	$(".cartAllCheckBox").prop("checked", true);
	$("input[name=chk]").each(function(i,e){
		$(e).prop("checked", true);
		pnoSet.add($(e).val());
	})
	
	let fixtotal = Number($('.hdTotal').val());
	let total = Number($('.hdTotal').val());
	
	
	$('.cartCheckBox').on('change', function(){
		let pno = $(this).val()
		let change = $(this).prev().val();
		let isChecked = $(this).prop('checked')
		if(isChecked) {
			pnoSet.add(pno)
			total = total + change*1;
			$('.totalPrice').val(total.toLocaleString('ko-KR')+"원");
			
		} else {
			pnoSet.delete(pno)
			total = total - change;
			$('.totalPrice').val(total.toLocaleString('ko-KR')+"원");
		}
		
	});
	
	$('.cartAllCheckBox').change(function(){
	
		if($(".cartAllCheckBox").is(':checked')) {
			$("input[name=chk]").each(function(i,e){
				$(e).prop("checked", true);
				pnoSet.add($(e).val());
				total = fixtotal;
				$('.totalPrice').val(total.toLocaleString('ko-KR')+"원");
			})
			
		} else {
			
			$("input[name=chk]").each(function(i,e){
				$(e).prop("checked", false);
				pnoSet.delete($(e).val());
				total = 0;
				$('.totalPrice').val(total+"원");
			})
		}
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
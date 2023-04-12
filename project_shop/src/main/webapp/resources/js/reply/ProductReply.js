let productReply = {
	
	list : function(name) {
		console.log(name)
		console.log('댓글목록')
		$.ajax({
			type : 'get',
			url : `${contextPath}/productReply/list`,
			data : {name : name}, 
			success : function(productReplyList) {
				console.log(productReplyList)
				productList(productReplyList);
			},
			error : function() {
				alert('리뷰 목록 조회 실패');
			} 			
		}); // ajax end
	},
	
	write: function(productReplyVO) {
	    let pno = $('input[name="pno"]').val();
	    let content = $('.reply_content').val(); // 리뷰내용 가져오기
	    
	    if (content === "") {
	        alert("리뷰 내용을 입력해주세요.");
	        return;
	    }
	    
	
	    $.ajax({
	        type: 'post',
	        url: `${contextPath}/productReply/write`,
	        data: productReplyVO,
	        success: function(result) {
	            $('.reply_content').val('');

	
	            $.ajax({
	                type: 'post',
	                url: `${contextPath}/productReply/updateCommentCount`,
	                data: {pno: pno, id : auth.id},
	                success: function(result) {
	                    console.log('리뷰수(count) 값이 성공적으로 업데이트되었습니다.');
	                },
	                error: function() {
	                    alert('리뷰수(count) 업데이트 에러');
	                }
	            });
	            
	            $('#reply').find('.modal-body').html(result);
	            $('#reply').modal('show');
	        },
	        error: function() {
	            alert('리뷰 등록 에러');
	        }
	    });
	},

	
	remove : function(productReplyVO) {
		$.ajax({
			type : 'post',
			url : `${contextPath}/productReply/remove`,
			data : productReplyVO,
			success : function(result) {
				$('#reply').find('.modal-body').html(result);
				$('#reply').modal('show');
			},
			error : function() {
				alert('리뷰삭제 에러')
			}
			
		}); // ajax end
		console.log('리뷰 삭제')
	}
	
	
};

function productList(productReplyList) {	

    let pno = $('input[name="pno"]').val();
    
    if (auth.grade != 'ROLE_MEMBER') {
        $('.productReplyForm').hide();
        $('.productReplyBtn').hide();
    } else {
        $.ajax({
            url: `${contextPath}/productReply/prCheck`,
            type: 'GET',
            data : {id : auth.id, pno : pno},
            success: function(result) {
                if (result == 0) {
                    $('.productReplyForm').hide();
                    $('.productReplyBtn').hide();
                }
                
            }, 
            error : function() {
                alert('리뷰 에러')
            }
        });
    }

    
    let output = '';
    var productReplyListLength = productReplyList.length;
	output += `
	        <div class="card" style="width: 84%; margin-left: 8%;">
	            <div class="card-header" style="background-color: #7092bf; color: #FFFFFF; border: 1px solid white;">리뷰목록(${productReplyListLength})</div>
	                <div class="card-body">
	                    <ul class="list-group list-group-flush">`;
	for(let p of productReplyList) {
	    output += 
	        `<li class="list-group-item d-flex justify-content-between">
	            <div>
	                <p>${p.reply}</p>
	                <span class="badge badge-info">${p.writer}</span>
	                <span class="badge badge-warning">${p.replyDate}</span>
	            </div>`;
	    if(p.writer==auth.id || auth.grade=='ROLE_ADMIN') {
	        output+=`
	        <div class="align-self-center" data-rno="${p.rno}">
	            <button class="btn btn-sm btn-danger p_reply_delBtn">삭제</button>
	        </div>
	        `;
	    }
	    output += `</li>`;
	}
	output += `
	                </ul>
	            </div>
	        </div>
	`;
    
    $('.productReplyList div').html(output);
}

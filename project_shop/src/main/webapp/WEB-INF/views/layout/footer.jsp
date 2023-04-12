<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	footer{
	 width: 100%;
	}
</style>
    
 <footer style="padding-top: 30px; padding-bottom: 30px; margin-top: 60px;">
 	<hr/>
    <div class="container">
        <div class="row">
            <div class="col-md-2">
                <img src="${contextPath}/resources/images/LOGO.png" alt="로고" style="height: 100px;">
            </div>
            <div class="col-md-3" style="font-size: 13px;">
                <h5>로고마켓</h5>
                <p>로고마켓은 여러분의 라이프스타일에 맞는 다양한 상품을 제공합니다.</p>
            </div>
            <div class="col-md-3">
                 <h5>고객센터</h5>
                <ul class="list-unstyled" style="font-size: 13px;">
                    <li>전화번호: 02-1234-5678</li>
			          <li>이메일: help@logomarket.com</li>
			          <li>카카오톡 플러스친구: @logomarket</li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5>회사 정보</h5>
                <ul style="font-size: 13px;">
		          <li>상호: 로고마켓</li>
		          <li>대표자: 김철수</li>
		          <li>사업자등록번호: 123-45-67890</li>
		          <li>주소: 서울특별시 강남구 역삼동 123-45 6층</li>
		        </ul>
                
            </div>
        </div>
                <hr>
                   <p class="text-center" style="font-size: 12px;"> © 2023 Market LOGO Co., Ltd. All rights reserved.</p>
    </div>
</footer>
</body>

<script>
  function positionFooter() {
    var footerHeight = document.querySelector('footer').offsetHeight;
    var windowHeight = window.innerHeight;
    var bodyHeight = document.body.offsetHeight;

    if (bodyHeight < windowHeight) {
      document.querySelector('footer').style.position = "absolute";
      document.querySelector('footer').style.bottom = "0";
    } else {
      document.querySelector('footer').style.position = "relative";
      document.querySelector('footer').style.bottom = "auto";
    }
  }

  positionFooter();
  window.addEventListener("resize", positionFooter);
</script>
</html>
<%@page import="vo.CustomerDomain"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//작성자 : 정인호 
%>
<!DOCTYPE html>
<html lang="zxx">

<head>
	<meta charset="UTF-8">
	<meta name="description" content="Male_Fashion Template">
	<meta name="keywords" content="Male_Fashion, unica, creative, html">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Male-Fashion | Template</title>

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap"
		rel="stylesheet">

	<!-- Css Styles -->
	<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
	<link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
	<link rel="stylesheet" href="css/nice-select.css" type="text/css">
	<link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
	<link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
	<link rel="stylesheet" href="css/style.css" type="text/css">
</head>

<body>
<!-- 상단 메뉴바/ inc폴더안에 menu.jsp파일로 분리하여 불러오기  -->
<jsp:include page="/inc/menu.jsp"></jsp:include>

<!-- Contact Section Begin -->
<section class="contact spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-6 col-md-6">
				<div class="contact__text">
					<div class="section-title">
						<span>create Account</span>
						<h2>회원가입</h2>
						<p id="errorMessage"></p>
					</div>
				</div>
			</div>
			<div class="col-lg-6 col-md-6">
				<div class="checkout__order">
					<div class="row">
						<div class="col-lg-12">
							<input class="form-control my-2" id="id" type="text" placeholder="아이디">
							<input class="form-control my-2" id="pw" type="password" placeholder="패스워드">
							<input class="form-control my-2" id="pwcheck" type="password" placeholder="패스워드확인">
							<input class="form-control my-2" id="name" type="text" placeholder="이름">
							<input class="form-control my-2" id="phone" type="text" placeholder="전화번호">
							<div class="row">
								<div class="col-md-9">
									<textarea class="form-control my-2" rows="4" id="address" placeholder="기본배송지주소"></textarea>
								</div>
								<div class="col">
									<button type="button" onclick="findAddress()" class="btn btn-dark btn-sm mt-4 mr-1">주소찾기</button>
								</div>
							</div>
							<button id="createCustomerAccountBtn" type="button" class="site-btn">회원가입</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Contact Section End -->

<!-- footer + searchbar -->
<jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer + searchbar -->

<!-- Js Plugins -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/jquery.nicescroll.min.js"></script>
<script src="js/jquery.magnific-popup.min.js"></script>
<script src="js/jquery.countdown.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>
<script type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>

//회원가입 입력 유효성검사 후 진행
document.getElementById("createCustomerAccountBtn").addEventListener("click", function () {
	var id = document.getElementById("id").value;
	var pw = document.getElementById("pw").value;
	var name = document.getElementById("name").value;
	var phone = document.getElementById("phone").value;
	var address = document.getElementById("address").value;
	//정규식
	var idPattern = /^[A-Za-z][A-Za-z0-9]{3,}$/;
	var pwPattern = /^.{4,}$/;
	var namePattern = /^[가-힣]{2,}$/;
	var phonePattern = /^\d+-?\d*-?\d*$/;
	var addressPattern = /^.{10,}$/;
	//검사
	$('#errorMessage').text('');
	if (!id.match(idPattern)) {
		$('#errorMessage').append( "아이디는 4자리 이상이며, 첫 글자는 영문으로 시작하고 숫자와 영문 조합이어야 합니다.<br>");
	}
	if (!pw.match(pwPattern)) {
		$('#errorMessage').append( "패스워드는 4자리 이상이어야 합니다.<br>");
	}
	if (!name.match(namePattern)) {
		$('#errorMessage').append( "이름은 2자리 이상이며, 한글로만 입력해야 합니다.<br>");
	}
	if (!phone.match(phonePattern)) {
		$('#errorMessage').append( "전화번호는 4자리 이상이어야 하며, 숫자와 '-'만 입력 가능합니다.<br>");
	}
	if (!address.match(addressPattern)) {
		$('#errorMessage').append( "기본배송지 주소는 10자 이상이어야 합니다.<br>");
	}
	if ($('#pw').val() != $('#pwcheck').val()) {
		$('#errorMessage').append("비밀번호 확인이 일치하지 않습니다.<br>");
	}
	// 비밀번호 검사 후 post request;
	if ($('#errorMessage').text() != '') {
		alert('올바른 값을 입력해주세요.');
		return;
	} else {
		$('#errorMessage').text('');
		$.post("publicApiController.jsp",
			{
				//post비동기요청
				customerRequestTitle: "createCustomerAccount",
				id: $('#id').val(),
				pw: $('#pw').val(),
				name: $('#name').val(),
				phone: $('#phone').val(),
				address: $('#address').val()
			}, function () {
				alert('회원가입이 완료되었습니다.');
				location.href = "customerLogin.jsp"; // 로그인페이지로
			}
		).fail(function () {
			$('#pwAlert').text('사용할 수 없는 아이디 입니다.'); // 중복경고
		});
	}
});

//주소조회
function findAddress(){
	new daum.Postcode({
		oncomplete: function(data) {
			console.log(data);
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			// 우편번호와 주소 정보를 해당 필드에 넣는다. 안에 정의해야 작동함.
			$('#address').val(data.zonecode+' '+data.roadAddress+' '+data.buildingName+'  ');
		}
	}).open();
}
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>

</html>
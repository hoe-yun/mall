<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                            <span>customer login </span>
                            <h2>로그인</h2>
                            <p id="errorMsg"></p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="contact__form">
                       <div class="row">
                           <div class="col-lg-12">
                               <input type="text" id="customerId" placeholder="ID">
                           </div>
                           <div class="col-lg-12">
                               <input type="password" id="customerPw" placeholder="PW">
                               <button id="loginBtn" type="button" class="site-btn mr-5">로그인</button>
                               <a href="customerCreate.jsp" class="site-btn">회 원 가 입</a>
                               <br>
   							<button id="forgotPwBtn" type="button" class="btn btn-light my-5">I FORGOT PASSWORD</button>
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
    <script type="text/javascript">
    	$('#forgotPwBtn').click(function () {
			$('#errorMsg').text('비밀번호 분실시 관리자에게 문의바랍니다');
		});
    	
    	//로그인 시도
    	$('#loginBtn').click(function () {
			let customerId = $('#customerId').val();
			let customerPw = $('#customerPw').val();
			$.post("./customerApiController.jsp", 
				{
            		customerRequestTitle : "login",
            		customerId : customerId,
            		customerPw : customerPw
            	}, function() {
					alert('로그인 성공');
					location.href="./customerInfo.jsp"
				}).fail(function () {
					$('#errorMsg').text('로그인정보가 일치하지 않습니다.');
				});
		});
    	
    </script>
</body>

</html>
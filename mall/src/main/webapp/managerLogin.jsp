<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String msg1 = request.getParameter("msg");
	String msg2 = request.getParameter("msg2");
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
<link
	href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap"
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
						<span>manager login </span>
						<h2>로그인</h2>
					</div>
				</div>
			</div>
			<div class="col-lg-5 col-md-5">
				<div>
					<%
						if(msg1 != null){
					%>
							<h6 style="color:red">ID와 PW를 확인해주세요</h6>
					<%
						}else if(msg2 != null){
					%>
							<h6 style="color:red">권한이 없습니다. 로그인 해주세요.</h6>
					<%
						}
					%>
					<form action="./managerLoginAction.jsp">
						<div class="row">
							<div class="col-lg-12">
								<input class="form-control form-control-lg my-3" type="text"
									id="managerId" placeholder="ManagerID" name="id">
							</div>
							<div class="col-lg-12">
								<input class="form-control form-control-lg mb-4" type="password"
									id="managerPw" placeholder="ManagerPW" name="pw">
								<button id="loginBtn" type="submit" class="site-btn my-2 mr-2">LOG
									IN</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="col-lg-1 col-md-1"></div>
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
</body>
</html>
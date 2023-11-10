<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%@ page import="vo.*" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>관리자 페이지</title>

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
<%
	// session정보에 managerNo가 없으면 오류 메세지가 출력된 managerLogin.jsp로 이동
	if(session.getAttribute("managerNo") == null){
		String msg2 = "x";
		response.sendRedirect("./managerLogin.jsp?msg2="+msg2);
	}
%>
</head>
<body>
<!-- 상단 메뉴바/ inc폴더안에 menu.jsp파일로 분리하여 불러오기  -->
  <jsp:include page="/inc/menu.jsp"></jsp:include>
  
  <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>Management Page</h4>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
  
  	<!-- Management Section Begin -->
    <section class="latest spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h2>Welcome "ADMIN"</h2>
                        <span>Choose Menu</span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <div class="blog__item">
                        <div class="blog__item__pic set-bg" data-setbg="img/blog/blog-4.jpg"></div>
                        <div class="blog__item__text">
                            <span> Menu </span>
                            <h3>Goods Management</h3>
                            <a href="<%=request.getContextPath()%>/goodsManagementList.jsp"><span class="arrow_down"></span>Goods List</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <div class="blog__item">
                        <div class="blog__item__pic set-bg" data-setbg="img/blog/blog-6.jpg"></div>
                        <div class="blog__item__text">
                            <span> Menu </span>
                            <h3>Notice Management</h3>
                         	<a href="<%=request.getContextPath()%>/noticeList.jsp"><span class="arrow_down"></span>Add Notice</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <div class="blog__item">
                        <div class="blog__item__pic set-bg" data-setbg="img/blog/blog-2.jpg"></div>
                        <div class="blog__item__text">
                            <span> Menu </span>
                            <h3>Order Management</h3>
                            <a href="./managementOrderList.jsp"><span class="arrow_down"></span>Order List</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Management Section End -->

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
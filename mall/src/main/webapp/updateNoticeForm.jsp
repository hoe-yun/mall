<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="vo.Nostice" %>
<%@ page import="dao.NoticeDao" %>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>공지사항</title>

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
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	NoticeDao noticeDao = new NoticeDao();
	Nostice notice = noticeDao.noticeOne(noticeNo);
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
                        <h4>Notice</h4>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
	<!-- Contact Section Begin -->
    <section class="contact spad">
        <div class="container">
            <div class="row">
                 <div class="section-title">
                    <span>notice</span>
                    <h2>Edit Notice</h2>
                 </div>
                <div class="col-lg-12">
                    <div class="contact__form">
                        <form action="<%=request.getContextPath()%>/updateNoticeAction.jsp?noticeNo=<%=notice.getNoticeNo() %>">
                            <div class="row">
                                <div class="col-lg-6">
                                    <input type="text" value="<%=notice.getNoticeTitle() %>" name="noticeTitle">
                                </div>
                                <div class="col-lg-6">
                                    <input type="number" value="<%=notice.getNoticeNo() %>" name="noticeNo" readonly="readonly">
                                </div>
                             	<div class="col-lg-12">
                                    <textarea  name="noticeContent"><%=notice.getNoticeContent() %></textarea>
                                    <button type="submit" class="site-btn" style=float:right>Edit Notice</button>
                                </div>
                            </div>
                        </form>
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
</body>
</html>
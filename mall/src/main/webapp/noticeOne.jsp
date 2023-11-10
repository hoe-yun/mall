<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<!DOCTYPE html>
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
	int preNoticeNo = noticeNo -1;
	int nextNoticeNo = noticeNo +1;
	NoticeDao noticeDao = new NoticeDao();
	Nostice notice = noticeDao.noticeOne(noticeNo);
	Nostice preNotice = noticeDao.noticeOne(preNoticeNo);
	Nostice nextNotice = noticeDao.noticeOne(nextNoticeNo);	
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
	<br><br><br>
	<!-- Notice One Title Section Begin -->
	<div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2><%=notice.getNoticeTitle()%></h2>
                    <span>DATE <%=notice.getCreatedate() %></span>
                </div>
            </div>
        </div>
    </div>
	<!-- Notice One Title Section End -->
	
  	<br><br><br><br><br><br><br><br>
  	
	<!-- Notice One Content Section Begin -->
	<section class="blog-details spad">
        <div class="container">
          <div class="blog__details__quote">
               <i class="fa fa-quote-left"></i>
               <p><%=notice.getNoticeContent() %></p>
               <h6>_ ADMIN _</h6>
           </div>
           <div class="blog__details__option">
               <div class="row">
                   <div class="col-lg-6 col-md-6 col-sm-6">
                       <div class="blog__details__author">
                           <div class="blog__details__author__pic">
                               <img src="img/blog/details/blog-author.jpg" alt="">
                           </div>
                           <div class="blog__details__author__text">
                               <h5>Manager : ADMIN</h5>
                           </div>
                       </div>
                   </div>
                   <div class="col-lg-6 col-md-6 col-sm-6">
                       <div class="blog__details__tags">
                           <span>Last Update : <%=notice.getUpdatedate() %></span>
                       </div>
                   </div>
               </div>
                	<div>
                		<a href="<%=request.getContextPath()%>/noticeList.jsp" class="primary-btn" style=float:right>notice List</a>
          	 		</div>
          	 		<div>
          	 		<%
					if(session.getAttribute("managerNo") != null){
					%>	
          	 			<a href="<%=request.getContextPath()%>/updateNoticeForm.jsp?noticeNo=<%=noticeNo %>" class="primary-btn" style=float:right>notice edit</a>
					<%
					}
					%>
					</div>
           </div>
           <div class="blog__details__btns">
               <div class="row">
                   <div class="col-lg-6 col-md-6 col-sm-6">
                       <a href="<%=request.getContextPath()%>/noticeOne.jsp?noticeNo=<%
														                    		   if(preNotice.getNoticeTitle() == null ){
																							  out.print(notice.getNoticeNo());
																					   }else{
																							  out.print(preNotice.getNoticeNo());
																					   }
                       																 %>" class="blog__details__btns__item">
                           <p><span class="arrow_left"></span> 이전 공지 </p>
                           <h5><%
	                          	 if(preNotice.getNoticeTitle() == null){
	                      			out.print("(이전 공지가 없습니다.)");
	                      		 }else{
	                      			out.print(preNotice.getNoticeTitle());
	                      		 }
                           		%></h5>
                       </a>
                   </div>
                   <div class="col-lg-6 col-md-6 col-sm-6">
                       <a href=<%=request.getContextPath()%>/noticeOne.jsp?noticeNo=<%
                       																  if(nextNotice.getNoticeTitle() == null ){
                    	   																  out.print(notice.getNoticeNo());
                       																  }else{
                       																	  out.print(nextNotice.getNoticeNo());
                       																  }
                    	   															%> class="blog__details__btns__item blog__details__btns__item--next">
                       
                           <p> 다음 공지 <span class="arrow_right"></span></p>
                           <h5><%
                           		 if(nextNotice.getNoticeTitle() == null){
                           			out.print("(다음 공지가 없습니다.)");
                           		 }else{
                           			out.print(nextNotice.getNoticeTitle());
                           		 }
                           		%></h5>
                       </a>
                   </div>
               </div>
           </div> 
        </div>
    </section>
	<!-- Notice One section End -->
	
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
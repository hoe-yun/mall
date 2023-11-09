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
    <title>상품 리뷰</title>

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
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	int preReviewNo = reviewNo -1;
	int nextReviewNo = reviewNo +1;
	ReviewDao reviewDao = new ReviewDao();
	Review review = reviewDao.reviewOne(reviewNo);
	Review preReview = reviewDao.reviewOne(preReviewNo);
	Review nextReview = reviewDao.reviewOne(nextReviewNo);	
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
                        <h4>Review</h4>
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
                    <h2><%=review.getReviewContent()%></h2>
                    <span>DATE <%=review.getCreatedate() %></span>
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
               <p><%=review.getReviewContent() %></p>
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
                               <h5>ID:</h5>
                           </div>
                       </div>
                   </div>
                   <div class="col-lg-6 col-md-6 col-sm-6">
                       <div class="blog__details__tags">
                           <span>Last Update : <%=review.getUpdatedate() %></span>
                       </div>
                   </div>
               </div>
                	<div>
                		<a href="<%=request.getContextPath()%>/reviewList.jsp" class="primary-btn" style=float:right>리뷰목록</a>
          	 		</div>
          	 		<div>	
          	 			<a href="<%=request.getContextPath()%>/updateReviewForm.jsp?reviewNo=<%=reviewNo %>" class="primary-btn" style=float:right>수정하기</a>
					</div>
           </div>
           <div class="blog__details__btns">
               <div class="row">
                   <div class="col-lg-6 col-md-6 col-sm-6">
                       <a href="<%=request.getContextPath()%>/noticeOne.jsp?noticeNo=<%
														                    		   if(preReview.getReviewContent() == null ){
																							  out.print(review.getReviewNo());
																					   }else{
																							  out.print(preReview.getReviewNo());
																					   }
                       																 %>" class="blog__details__btns__item">
                           <p><span class="arrow_left"></span> 이전 공지 </p>
                           <h5><%
	                          	 if(preReview.getReviewContent() == null){
	                      			out.print("(이전 리뷰가 없습니다.)");
	                      		 }else{
	                      			out.print(preReview.getReviewContent());
	                      		 }
                           		%></h5>
                       </a>
                   </div>
                   <div class="col-lg-6 col-md-6 col-sm-6">
                       <a href=<%=request.getContextPath()%>/noticeOne.jsp?noticeNo=<%
                       																  if(nextReview.getReviewContent() == null ){
                    	   																  out.print(review.getReviewNo());
                       																  }else{
                       																	  out.print(nextReview.getReviewNo());
                       																  }
                    	   															%> class="blog__details__btns__item blog__details__btns__item--next">
                       
                           <p> 다음 공지 <span class="arrow_right"></span></p>
                           <h5><%
                           		 if(nextReview.getReviewContent() == null){
                           			out.print("(다음 리뷰가 없습니다.)");
                           		 }else{
                           			out.print(nextReview.getReviewContent());
                           		 }
                           		%></h5>
                       </a>
                   </div>
               </div>
           </div> 
        </div>
    </section>
	<!-- Notice One section End -->
	
    <!-- Footer Section Begin -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="footer__about">
                        <div class="footer__logo">
                            <a href="#"><img src="img/footer-logo.png" alt=""></a>
                        </div>
                        <p>The customer is at the heart of our unique business model, which includes design.</p>
                        <a href="#"><img src="img/payment.png" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-2 offset-lg-1 col-md-3 col-sm-6">
                    <div class="footer__widget">
                        <h6>Shopping</h6>
                        <ul>
                            <li><a href="#">Clothing Store</a></li>
                            <li><a href="#">Trending Shoes</a></li>
                            <li><a href="#">Accessories</a></li>
                            <li><a href="#">Sale</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-6">
                    <div class="footer__widget">
                        <h6>Shopping</h6>
                        <ul>
                            <li><a href="#">Contact Us</a></li>
                            <li><a href="#">Payment Methods</a></li>
                            <li><a href="#">Delivary</a></li>
                            <li><a href="#">Return & Exchanges</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 offset-lg-1 col-md-6 col-sm-6">
                    <div class="footer__widget">
                        <h6>NewLetter</h6>
                        <div class="footer__newslatter">
                            <p>Be the first to know about new arrivals, look books, sales & promos!</p>
                            <form action="#">
                                <input type="text" placeholder="Your email">
                                <button type="submit"><span class="icon_mail_alt"></span></button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="footer__copyright__text">
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        <p>Copyright ©
                            <script>
                                document.write(new Date().getFullYear());
                            </script>2020
                            All rights reserved | This template is made with <i class="fa fa-heart-o"
                            aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                        </p>
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer Section End -->

    <!-- Search Begin -->
    <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-switch">+</div>
            <form class="search-model-form">
                <input type="text" id="search-input" placeholder="Search here.....">
            </form>
        </div>
    </div>
    <!-- Search End -->  
  
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
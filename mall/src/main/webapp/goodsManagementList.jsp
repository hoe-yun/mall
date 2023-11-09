<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>상품 관리</title>

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
	// controller code
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	
	GoodsDao gDao = new GoodsDao();
	ArrayList<Goods> list = gDao.selectGoodsList(beginRow, rowPerPage);
	Goods goods = new Goods();
	int totalRow = gDao.goodsCNT();
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
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
                        <h4>Goods Management</h4>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Shopping Cart Section Begin -->
    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shopping__cart__table">
                        <table >
                            <thead>
                                <tr>
                                    <th>Goods</th>
                                    <th>Goods Memo</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                            	for(Goods g : list){
                            %>
                                <tr>
                                    <td class="product__cart__item">
                                        <div class="product__cart__item__pic" >
                                            <img src="img/product/<%=g.getGoodsTitle() %>.png" alt="" width="100px" height="100px">
                                        </div>
                                        <div class="product__cart__item__text">
                                            <h6><%=g.getGoodsTitle() %></h6>
                                            <h5>$<%=g.getGoodsPrice() %></h5>
                                        </div>
                                    </td>
                                    <td class="cart__close">
                                    	<%=g.getGoodsMemo() %>
                                    </td>
                                    <td class="col-lg-3">
                                    	<a href="<%=request.getContextPath()%>/delectGoodsImgAction.jsp?goodsNo=<%=g.getGoodsNo() %>" class="primary-btn">Delete</a>
                                    	<a href="<%=request.getContextPath()%>/updateGoodsForm.jsp?goodsNo=<%=g.getGoodsNo() %>" class="primary-btn">Edit</a>
                                    </td>
                                </tr>
                             <%
                            	}
                             %>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <a href="<%=request.getContextPath()%>/managerOne.jsp" class="primary-btn">Return Management</a>
                        </div>
                        <div>
                        	<span class="col-lg-2 col-md-6 col-sm-6">Page<%=currentPage %></span>
                        </div>
                        <div class="col-lg-5 col-md-6 col-sm-6">
                            <a href="<%=request.getContextPath()%>/insertGoodsForm.jsp" class="primary-btn" style=float:right>Add Goods</a>
                        </div>
                    </div>
                </div>
              <div class="col-lg-12">
        <div class="product__pagination">
            <a href="<%=request.getContextPath()%>/goodsManagementList.jsp?currentPage=<% 
            																			  out.print(currentPage-1);
            																			  if(currentPage-1 < 1){
            																				  out.print(currentPage);
            																			  }
            																										%>"><span class="arrow_left"></span></a>
          	<a href="<%=request.getContextPath()%>/goodsManagementList.jsp?currentPage=1">First</a>
          <%
          	for(int i=1; i<= lastPage; i=i+1){
          %>
          	<a href="<%=request.getContextPath()%>/goodsManagementList.jsp?currentPage=<%=i %>"><%=i %></a>
          <%
          	}
          %>
          	<a href="<%=request.getContextPath()%>/goodsManagementList.jsp?currentPage=<%=lastPage %>">Last</a>
            <a href="<%=request.getContextPath()%>/goodsManagementList.jsp?currentPage=<%
            																			  if(currentPage+1 > lastPage){
            																				  out.print(currentPage);
            																			  }else{
            																				  out.print(currentPage+1);
            																			  }
            																			  					%>"><span class="arrow_right"></span></a>
        </div>
    </div>
            </div>
        </div>
    </section>
    <!-- Shopping Cart Section End -->
	
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
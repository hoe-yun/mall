<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="">

<head>

    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>쇼핑몰 프로젝트</title>

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
	//controller code
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 8;
	int beginRow = (currentPage-1)*rowPerPage;
	
	GoodsDao gDao = new GoodsDao();
	ArrayList<Goods> list = gDao.selectGoodsList(beginRow, rowPerPage);
	
	int totalRow = gDao.goodsCNT();
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	
	GoodsImgDao iDao = new GoodsImgDao();
	
%>
</head>

<body>
<!-- 상단 메뉴바/ inc폴더안에 menu.jsp파일로 분리하여 불러오기  -->
  <jsp:include page="/inc/menu.jsp"></jsp:include>

    <!-- Hero Section Begin -->
    <section class="hero">
        <div class="hero__slider owl-carousel">
            <div class="hero__items set-bg" data-setbg="img/hero/hero-1.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-5 col-lg-7 col-md-8">
                            <div class="hero__text">
                                <h6>GDJ72 - 정인호, 정회윤, 정택민</h6>
                                <h2>JAVA를 이용한 쇼핑몰 프로젝트</h2>
                                <p></p>
                                <a href="./productList.jsp" class="primary-btn">상품리스트로 <span class="arrow_right"></span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hero__items set-bg" data-setbg="img/hero/hero-2.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-5 col-lg-7 col-md-8">
                            <div class="hero__text">
                                <h6>Summer Collection</h6>
                                <h2>Fall - Winter Collections 2030</h2>
                                <p>A specialist label creating luxury essentials. Ethically crafted with an unwavering
                                commitment to exceptional quality.</p>
                                <a href="./productList.jsp" class="primary-btn">Shop now <span class="arrow_right"></span></a>
                             </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Hero Section End -->

    <br><br>

    <!-- Product Section Begin -->
    <section class="product spad">
        <div class="container">
        <h3>Hot Product</h3><br><br>
            <div class="row product__filter">
            <%
            	for(Goods g : list){
            %>
                <div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix new-arrivals">
                    <div class="product__item">
                         <div class="product__item__pic set-bg" data-setbg="img/product/<%=iDao.selectGoodsImg(g.getGoodsNo()).getFilename() %>"
                                style="background-image: url(&quot;img/product/<%=g.getGoodsTitle() %>.png&quot;);">         
                         </div>
                         <div class="product__item__text">
                             <h6><%=g.getGoodsNo()%>.<%=g.getGoodsTitle() %></h6><span>품절여부 :<%=g.getSoldout()%></span>
                             <a href="./productDetail.jsp?goodsNo=<%=g.getGoodsNo()%>" class="add-cart" action="<%=request.getContextPath()%>/productDetail.jsp?goodsNo=<%=g.getGoodsNo()%>">+ 상세정보 보기</a>
                             <div class="rating">
                                 <i class="fa fa-star-o"></i>
                                 <i class="fa fa-star-o"></i>
                                 <i class="fa fa-star-o"></i>
                                 <i class="fa fa-star-o"></i>
                                 <i class="fa fa-star-o"></i>
                             </div>
                             <h5><%= g.getGoodsPrice() %></h5>
                             <div class="product__color__select">
                                 <label for="pc-4">
                                     <input type="radio" id="pc-4">
                                 </label>
                                 <label class="active black" for="pc-5">
                                     <input type="radio" id="pc-5">
                                 </label>
                                 <label class="grey" for="pc-6">
                                     <input type="radio" id="pc-6">
                                 </label>
                             </div>
                         </div>
                    </div>
                </div>
            <%
            	}
            %>
            </div>
            <div class="product__pagination">
            <a href="<%=request.getContextPath()%>/home.jsp?currentPage=<% 
            																			  out.print(currentPage-1);
            																			  if(currentPage-1 < 1){
            																				  out.print(currentPage);
            																			  }
            																										%>"><span class="arrow_left"></span></a>
          	<a href="<%=request.getContextPath()%>/home.jsp?currentPage=1">First</a>
          <%
          	for(int i=1; i<= lastPage; i=i+1){
          %>
          	<a href="<%=request.getContextPath()%>/home.jsp?currentPage=<%=i %>"><%=i %></a>
          <%
          	}
          %>
          	<a href="<%=request.getContextPath()%>/home.jsp?currentPage=<%=lastPage %>">Last</a>
            <a href="<%=request.getContextPath()%>/home.jsp?currentPage=<%
            																			  if(currentPage+1 > lastPage){
            																				  out.print(currentPage);
            																			  }else{
            																				  out.print(currentPage+1);
            																			  }
            																			  					%>"><span class="arrow_right"></span></a>
        </div>
        </div>
    </section>
    <!-- Product Section End -->

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


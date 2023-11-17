<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	int goodsNo = 0;
	String goodsTitle = null;
	int goodsPrice = 0;
	GoodsDao goodsDao = new GoodsDao();
	//이미지 출력을위해 GoodsImgDao연결
	GoodsImgDao goodsImg = new GoodsImgDao();
	goodsImg.selectGoodsImg(goodsNo);
		//페이징 컨트롤러
		int currentPage = 1;
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int rowPerPage = 9;
		int beginRow = (currentPage-1)*rowPerPage;
		
		GoodsDao gDao = new GoodsDao();
		ArrayList<Goods> list1 = goodsDao.selectproductList(beginRow, rowPerPage);
		
		int totalRow = gDao.goodsCNT();
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0){
			lastPage = lastPage + 1;
		}
	
%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>상품 리스트</title>

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
    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>Shop</h4>
                        <div class="breadcrumb__links">
                            <a href="./home.jsp">Home</a>
                            <span>Shop</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Shop Section Begin -->
    <section class="shop spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="shop__sidebar">
                        <div class="shop__sidebar__search">
                            <form action="./searchResultList.jsp">
                                <input type="text" name="searchTitle" placeholder="Search...">
                                <button type="submit"><span class="icon_search"></span></button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="shop__product__option">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__left">
                                    <p>Showing 1–12 of 126 results</p>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__right">
                                    <p>Sort by Price:</p>
                                    <select>
                                        <option value="">Low To High</option>
                                        <option value="">$0 - $55</option>
                                        <option value="">$55 - $100</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                	 <div class="row">
                    <%for(Goods g : list1){%>
                   
                        <div class="col-lg-4 col-md-6 col-sm-6" >
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="img/product/<%=goodsImg.selectGoodsImg(g.getGoodsNo()).getFilename() %>"
                                style="background-image: url(&quot;img/product/<%=g.getGoodsTitle() %>.png&quot;);">
                                    
                                </div>
                                <div class="product__item__text">
                                    <h6><%=g.getGoodsNo()%>.<%=g.getGoodsTitle() %></h6><span>품절여부 : <%=g.getSoldout()%></span>
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
                 <div class="row">
                        <div class="col-lg-12">
                             <div class="product__pagination">
            <a href="<%=request.getContextPath()%>/productList.jsp?currentPage=<% 
            																			  out.print(currentPage-1);
            																			  if(currentPage-1 < 1){
            																				  out.print(currentPage);
            																			  }
            																										%>"><span class="arrow_left"></span></a>
          	<a href="<%=request.getContextPath()%>/productList.jsp?currentPage=1">First</a>
          <%
          	for(int i=1; i<= lastPage; i=i+1){
          %>
          	<a href="<%=request.getContextPath()%>/productList.jsp?currentPage=<%=i %>"><%=i %></a>
          <%
          	}
          %>
          	<a href="<%=request.getContextPath()%>/productList.jsp?currentPage=<%=lastPage %>">Last</a>
            <a href="<%=request.getContextPath()%>/productList.jsp?currentPage=<%
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
                </div>
            </div>
        </div>
                       
    </section>
    <!-- Shop Section End -->

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
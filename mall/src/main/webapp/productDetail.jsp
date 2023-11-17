<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	int customerNo = (Integer)session.getAttribute("customerNo");
	int goodsNo=Integer.parseInt(request.getParameter("goodsNo"));
	String goodsTitle = null;
	int goodsPrice = 0;
	String goodsMemo = null;
	GoodsDao goodsDao = new GoodsDao();
	ProductCartDao dao = new ProductCartDao();
	ProductCart Detail = dao.selectProductDetail(request.getParameter("goodsTitle"), goodsPrice, Integer.parseInt(request.getParameter("goodsNo")));
	//문의글 출력하기위한 DAO호출
	QuestionDao questionDao = new QuestionDao();
	ArrayList<HashMap<String,Object>> list = questionDao.selectQuestion(Integer.parseInt(request.getParameter("goodsNo")));
	//리뷰글 출력하기 위한 DAo호출
	ReviewDao reviewDao = new ReviewDao();
	Review r = reviewDao.reviewDetail(goodsNo);
	//상세페이지 하단 다른 상품출력
	GoodsImgDao goodsImg = new GoodsImgDao();
	goodsImg.selectGoodsImg(goodsNo);
	
	int currentPage = 1;
	int rowPerPage = 4;
	int beginRow = (currentPage-1)*rowPerPage;
	GoodsDao gDao = new GoodsDao();
	ArrayList<Goods> list1 = gDao.selectGoodsList(beginRow, rowPerPage);
	
%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>상품 상세보기</title>

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
    <!-- Shop Details Section Begin -->
    <section class="shop-details">
        <div class="product__details__pic">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product__details__breadcrumb">
                            <a href="./home.jsp">홈으로</a></t>
                            <a href="./productList.jsp">목록으로</a>
                            <span>상품 디테일</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-3">
                       
                    </div>
                    <div class="col-lg-6 col-md-9">
                        <div class="tab-content">
                            <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="img/product/<%=Detail.getGoodsTitle() %>.png" alt="">
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-2" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="img/shop-details/product-big-3.png" alt="">
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-3" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="img/shop-details/product-big.png" alt="">
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-4" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="img/shop-details/product-big-4.png" alt="">
                                    <a href="https://www.youtube.com/watch?v=8PJ3_p7VqHw&list=RD8PJ3_p7VqHw&start_radio=1" class="video-popup"><i class="fa fa-play"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="product__details__content">
            <div class="container">
                <div class="row d-flex justify-content-center">
                    <div class="col-lg-8">
                        <div class="product__details__text">
                            <h4><%=Detail.getGoodsNo()%>.<%=Detail.getGoodsTitle()%></h4>
                            <div class="rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star-o"></i>
                                <span> - 5 Reviews</span>
                            </div>
                            <h3><%=Detail.getGoodsPrice() %> <span><%=(Detail.getGoodsPrice()*1.3)%></span></h3>
                            <p><%=Detail.getGoodsMemo() %></p>
                            
                          <form  type="submit" action="./InsertCartAction.jsp" method="get">
                            <div class="product__details__cart__option">
                                <div class="quantity">
                                    <div>
                                       <h5>수량 선택</h5> <input type="number" name="quantity" value="1">
                                        <input type="number" name="goodsNo" value="<%=Detail.getGoodsNo()%>" readonly="readonly" hidden="true">
                                       
                                    </div>
                                </div>
                                <button class="primary-btn" type="submit">장바구니 추가</button>
                            </div>
                            	</form>
                            <div class="product__details__last__option">
                                <h5><span>Guaranteed Safe Checkout</span></h5>
                                <img src="img/shop-details/details-payment.png" alt="">
                                
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product__details__tab">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#tabs-5"
                                    role="tab">상세정보</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-6" role="tab">상품 리뷰</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-7" role="tab">문의</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tabs-5" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item">
                                            <h5>제품 상세 정보</h5>
                                            <p><%= Detail.getGoodsMemo() %></p>
                                        </div>
                                        <div class="product__details__tab__content__item">

                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tabs-6" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item">
                                         <a href="<%=request.getContextPath()%>/reviewList.jsp" class="primary-btn" style=float:left>리뷰 목록으로</a>
                                         <table class="table col-lg-12">
                                         	<th>번호</th>
                                         	<th>내용</th>
                                         	<th>업데이트</th>
                                         	<tr>
                                         	<td><%=r.getReviewNo() %></td>
                                         	<td><%=r.getReviewContent() %></td>
                                         	<td><%=r.getUpdatedate()%></td>   
                                            </tr>
                                            </table> 
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tabs-7" role="tabpanel">
                                  <div class="product__details__tab__content">
                                  <%
									if(session.getAttribute("customerNo") != null){
								  %>
                                 	 <a href="<%=request.getContextPath()%>/insertQuestionForm.jsp?goodsNo=<%=Detail.getGoodsNo() %>" class="primary-btn" style=float:left>add Question</a>
                                  <%
									}
								  %>
                                  <table class="table col-lg-12">
                                  <%
                                  	for(HashMap<String,Object> q : list){
                                  %>
                                  		<tr>
                                       		<td height="100px">
                                        		<textarea class="col-lg-12" rows="3" readonly="readonly">Question - <%=q.get("questionTitle")%> : <%=q.get("questionContent")%>
                                        		
                                        																	Comment - <%=q.get("comment")%></textarea>
                                        	</td>
                                        </tr>
                                        <tr>
                                        	<td>
                                        		<a href="<%=request.getContextPath()%>/questionOne.jsp?questionNo=<%=q.get("questionNo") %>" class="primary-btn" style=float:right>자세히</a>
                                        	</td>
                                        </tr>
                                        <tr>
                                        	<td ></td>
                                        </tr>
                                  <%
                                  	}
                                  %>  
                                  </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Details Section End -->

    <!-- Related Section Begin -->
    <section class="related spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="related-title">다른 상품 더보기</h3>
                </div>
            </div>
            <div class="row">
             <%
            	for(Goods g : list1){
            %>
                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="img/product/<%=goodsImg.selectGoodsImg(g.getGoodsNo()).getFilename() %>"
                        style="background-image: url(&quot;img/product/<%=g.getGoodsTitle() %>.png&quot;);">
                            <span class="label">New</span>
                            
                        </div>
                        <div class="product__item__text">
                            <h6><%=g.getGoodsTitle() %></h6>
                            <a href="productDetail.jsp?goodsNo=<%=g.getGoodsNo() %>" class="add-cart">+ 상세정보 보기</a>
                            <div class="rating">
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <h5><%=g.getGoodsPrice() %></h5>
                        </div>
                    </div>
                </div>
                 <%
            	}
            %>
               
            </div>
        </div>
    </section>
    <!-- Related Section End -->

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
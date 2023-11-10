<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	int goodsNo=0;
	String goodsTitle = null;
	int goodsPrice = 0;
	int quantity = 0;
	int cartNo = 0;
	String goodsMemo = null;
	Integer customerNo = (int)session.getAttribute("customerNo");
	ProductCartDao dao = new ProductCartDao();
	ArrayList<ProductCart> list = dao.selectArrayList(customerNo, goodsTitle, goodsPrice, goodsNo, quantity, cartNo);
	//이미지 출력을위해 GoodsImgDao연결
		GoodsImgDao goodsImg = new GoodsImgDao();
		goodsImg.selectGoodsImg(goodsNo);
	//총계 계산을위해 메소드 추가 생성
	
%>

<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>장바구니</title>

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
                        <h4>장바구니</h4>
                        <div class="breadcrumb__links">
                            <a href="./Home.jsp">홈으로</a>
                            <a href="./productList.jsp">쇼핑</a>
                            <span>장바구니</span>
                        </div>
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
                <div class="col-lg-8">
                    <div class="shopping__cart__table">
                        <table>
                            <thead>
                                <tr>
                                	<th>번호</th>
                                    <th>상품</th>
                                    <th>수량</th>
                                    <th>소계</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                            <form action="./orderApiController.jsp" method="post">
                            	<input hidden="true" readonly="readonly" name="customerRequestTitle" value="transferCartToOrder">
                            <% for(ProductCart p : list) {%>
                                <tr>
                                	<td><%=p.getCartNo()%></td>
                                    <td class="product__cart__item">
                                    <div class="product__cart__item__pic">
                                       <a href="./productDetail.jsp?goodsNo=<%=p.getGoodsNo()%>"><img src="img/product/<%=goodsImg.selectGoodsImg(p.getGoodsNo()).getFilename() %>" alt="" width="120" height="90"></a>
                                    </div>
                                    <div class="product__cart__item__text">
                                        <h6><%=p.getGoodsNo()%>.<%=p.getGoodsTitle()%></h6>
                                        <h5><%=p.getGoodsPrice() %></h5>
                                    </div>
                                    </td>
                                    <td class="quantity__item">
                                        <div class="quantity">
                                            <div class="pro-qty-2">
                                                <input type="text" value="<%=p.getQuantity()%>">
                                            </div>
                                        </div>
                                     
                                    </td>
                                    <td class="cart__price"><span class="subtotal"><%= p.getGoodsPrice() %></span></td>
                                    <td class="cart__close"><a href="./deleteCartAction.jsp?cartNo=<%=p.getCartNo()%>" class="fa fa-close"></a></td>
                                </tr>
                                <%} %>
                                
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="continue__btn">
                                <a href="./productList.jsp">계속 쇼핑하기</a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="continue__btn update__btn">
                                <a href="productCart.jsp"><i class="fa fa-spinner"></i> 새로고침</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="cart__total">
                        <h6>총 금액</h6>
                        <ul>
                            <li>총계<span id="total">??</span></li>
                        </ul>
                        <button type="submit" class="primary-btn">장바구니 상품 주문하기</button>
                    </div>
                </div>
            </div>
        </div>
       </form>
    </section>
    <!-- Shopping Cart Section End -->

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
<%@page import="dao.OrderDao"%>
<%@page import="vo.TransferCartToOrderVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// 작성자 : 정인호 
// 주문리스트조회

request.setCharacterEncoding("utf-8");

Integer customerNo = (int)session.getAttribute("customerNo");// 세션정보 확인
OrderDao dao = new OrderDao();
ArrayList<HashMap<String, Object>> orderList = dao.retrieveOrderList(customerNo);

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
					<h4>주문목록</h4>
					<div class="breadcrumb__links">
						<a href="./index.html">Home</a>
						<a href="./shop.html">Shop</a>
						<span>order list</span>
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
			<div class="col-lg-12">
				<div class="shopping__cart__table">
					<table>
						<thead>
							<tr>
								<th>Product</th>
								<th>Quantity</th>
								<th>Total</th>
								<th>delivery status</th>
								<th>order date</th>
								<th>Shipping address</th>
							</tr>
						</thead>
						<tbody>
						<%
						for(HashMap<String, Object> orderMap : orderList ){
						%>
						<!-- 주문 상품 1개 start-->
							<tr>
								<td class="product__cart__item">
									<div class="product__cart__item__pic">
										<img src="img/shopping-cart/cart-1.jpg" >
									</div>
									<div class="product__cart__item__text">
										<h6><%=orderMap.get("goodTitle")%></h6>
										<h5><%=orderMap.get("goodPrice")%></h5>
									</div> 
								</td>
								<td class="quantity__item">
									<div class="quantity">
										<div ><%=orderMap.get("quantity")%></div>
									</div>
								</td>
								<td class="cart__price">
									<span> <%=orderMap.get("totalPrice")%></span>
								</td>
								<td ><%=orderMap.get("orderStatus")%></td>
								<td ><%=orderMap.get("createdate")%></td>
								<td ><%=orderMap.get("address")%></td>
							</tr>
						<!-- 주문 상품 1개 end -->
						<%
						}
						%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
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
<script type="text/javascript">

</script>
</body>
</html>
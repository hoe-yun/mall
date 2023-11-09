<%@page import="vo.TransferCartToOrderVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// 1. get <goodsNo , quantity > List From Cart;
// 2. retrieve goods price from db using with goodsNo;
// 3. get session customerNo And retrieve customerDetail, address;
// 4. make view with values gotten;
// 5. $post and dao transaction init;

request.setCharacterEncoding("utf-8");
//int customerNo = (int)session.getAttribute("customerNo");// 세션정보 확인
int customerNo = 1;// 세션정보 확인
CustomerDao dao = new CustomerDao();

// 고객 상세정보 vo
HashMap<String,Object> customerInfo = dao.retrieveCustomerInfo(customerNo);
// 고객 주소 조회 vo
ArrayList<HashMap<String, Object>> AddressList = dao.retrieveCustomerAddrList(customerNo); 

ArrayList<TransferCartToOrderVo> goodsList = (ArrayList<TransferCartToOrderVo>)request.getAttribute("TransferCartToOrderVoList");

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
					<h4>주문하기</h4>
					<div class="breadcrumb__links">
						<a href="./index.html">Home</a>
						<a href="./shop.html">Shop</a>
						<span>Shopping Cart</span>
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
								<th>Product</th>
								<th>Quantity</th>
								<th>Total</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
						<%
						for(TransferCartToOrderVo good : goodsList ){
						%>
						<!-- 주문 상품 1개 start-->
							<tr>
								<td class="product__cart__item">
									<div class="product__cart__item__pic">
										<img src="img/shopping-cart/cart-1.jpg" alt="">
									</div>
									<div class="product__cart__item__text">
										<span name="goodNo" hidden="true"><%=good.getGoodsNo()%></span>
										<h6><%=good.getGoodsTitle()%></h6>
										<h5 name="goodTitle"><%=good.getGoodsPrice()%></h5>
									</div>
								</td>
								<td class="quantity__item">
									<div class="quantity">
										<div name="goodQuantity" class="pro-qty-2"><%= good.getQuantity()%></div>
									</div>
								</td>
								<td class="cart__price"><%=(good.getGoodsPrice()*good.getQuantity())%></td>
							</tr>
						<!-- 주문 상품 1개 end -->
						<%
						}
						%>
						</tbody>
					</table>
				</div>
				
				<!-- 배송주소 출력 시작 -->
				<%
				for(HashMap<String, Object> address : AddressList ){
				%>
				<div class="rounded border p-3 mb-2">
					<div class="checkout__input">
						<input hidden="true" type="number" name="AddressNo" value="<%=address.get("addrNo")%>">
						<span class="mx-3">배송주소</span>
						<button type="button" name="addressSelectionBtn" class="btn btn-light btn-sm mb-2">선택하기</button>
						<textarea class="form-control" rows="3" name="address" readonly="readonly"><%=address.get("address")%></textarea>
					</div>
				</div>
				<%
				}
				%>
				<!-- 배송주소출력 종료 -->
			</div>
			<div class="col-lg-4 col-md-6">
				<div class="checkout__order">
					<h4 class="order__title">Your order</h4>
					<ul class="checkout__total__products">
						<li>아이디 <span id="userId"><%=customerInfo.get("customerId") %></span></li>
						<li>이름 <span id="customerName"><%=customerInfo.get("customerName") %></span></li>
						<li>전화번호 <span id="customerPhone"><%=customerInfo.get("customerPhone") %></span></li>
					</ul>
					<ul class="checkout__total__all">
						<li>배송주소</li>
						<li id="selectedAddress"></li>
					</ul>
					<ul class="checkout__total__all">
						<li>결제총액 <span>$750.99</span></li>
					</ul>
					<div class="checkout__input__checkbox">
						<label for="acc-or">
							주문내역을 확인하였습니다
							<input type="checkbox" id="acc-or">
							<span class="checkmark"></span>
						</label>
					</div>
					<p>주문서 발행 </p>
					<div class="checkout__input__checkbox">
						<label for="payment">
							Check Payment
							<input type="checkbox" id="payment">
							<span class="checkmark"></span>
						</label>
					</div>
					<div class="checkout__input__checkbox">
						<label for="paypal">
							Paypal
							<input type="checkbox" id="paypal">
							<span class="checkmark"></span>
						</label>
					</div>
					<button type="submit" class="site-btn">PLACE ORDER</button>
					<button id="orderCreateBtn" type="button" class="site-btn">Create Order</button>
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



let selectedAddressNo;

$('i[name=closeBtn]').click(function () {
	alert('clicked');
})

$(document).on('click', 'button[name=addressSelectionBtn]', function() {
	let selectedAddress = $(this).next().val();
	$('#selectedAddress').html(selectedAddress);
	
	selectedAddressNo = $(this).siblings().first().val();
	alert(selectedAddressNo);
	}
);
</script>
</body>

</html>
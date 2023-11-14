<%@page import="vo.TransferCartToOrderVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// 작성자 : 정인호 
// 주문서 작성

request.setCharacterEncoding("utf-8");
int customerNo = (int)session.getAttribute("customerNo");// 세션정보 확인
CustomerDao dao = new CustomerDao();

// 고객 상세정보 vo
HashMap<String,Object> customerInfo = dao.retrieveCustomerInfo(customerNo);
// 고객 주소 조회 vo
ArrayList<HashMap<String, Object>> AddressList = dao.retrieveCustomerAddrList(customerNo); 
// 장바구니로부터 옮겨온 상품리스트
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
						<span>order create</span>
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
										<img src="img/product/<%=good.getFilename()%>" width="120" height="90">
									</div>
									<div class="product__cart__item__text">
										<span name="goodNo" hidden="true"><%=good.getGoodsNo()%></span>
										<h6><%=good.getGoodsTitle()%></h6>
										<h5 name="goodTitle"><%=good.getGoodsPrice()%></h5>
									</div>
								</td>
								<td class="quantity__item">
									<div class="quantity">
										<div name="goodQuantity" ><%= good.getQuantity()%></div>
									</div>
								</td>
								<td class="cart__price" name="totalPrice"><%=(good.getGoodsPrice()*good.getQuantity())%></td>
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
						<li id="selectedAddress">배송주소를 선택해주세요</li>
					</ul>
					<ul class="checkout__total__all">
						<li>주문금액 <span id="totalprice" ></span></li>
					</ul>
					<div class="checkout__input__checkbox">
						<label for="acc-or">
							주문내역을 확인하였습니다
							<input type="checkbox" id="acc-or">
							<span class="checkmark"></span>
						</label>
					</div>
					<button id="orderCreateBtn" type="button" class="site-btn">Create Order</button>
					<a href="productCart.jsp" type="button" class="site-btn"> *Return and edit my Cart List</a>
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
/*변수선언부*/
let selectedAddressNo;
let totalPrice = 0;
//배송지중 하나를 선택하면 주문서에 배송지가 변경됨
$(document).on('click', 'button[name=addressSelectionBtn]', function() {
	let selectedAddress = $(this).next().val();
	$('#selectedAddress').html(selectedAddress);
	selectedAddressNo = $(this).siblings().first().val();
	}
);

// 총 주문 금액을 계산함
$('.cart__price').each(function() {
	let eachPrice = Number($(this).text());
	totalPrice += eachPrice;
	//alert(totalPrice);
});
//총 주문 금액을 주문서에 옮김
$('#totalprice').text(totalPrice);
if($('#totalprice').text() == 0){
	alert('장바구니에 상품이 없습니다')
	location.href="productCart.jsp";
}

//주문하기 버튼을 누르면 밸리데이션 후 데이터를 정리하여 post 요청함
$('#orderCreateBtn').click(function() {
	if($('#selectedAddress').html() == '배송주소를 선택해주세요'){
		alert('배송주소를 선택해주세요');
		return;
	}
	if (!$('#acc-or').is(':checked')) {
		alert('주문내역 확인을 체크해주세요');
		return;
	}
	
	let goodNos = [];
	let quantitys = [];
	let totalPrices = [];
	$('*[name=goodNo]').each(function() {
		let value = $(this).text(); // 현재 요소의 텍스트 가져오기
		goodNos.push(value); // 배열에 텍스트 추가
	});
	$('*[name=goodQuantity]').each(function() {
		let value = $(this).text(); // 현재 요소의 텍스트 가져오기
		quantitys.push(value); // 배열에 텍스트 추가
	});
	$('*[name=totalPrice]').each(function() {
		let value = $(this).text(); // 현재 요소의 텍스트 가져오기
		totalPrices.push(value); // 배열에 텍스트 추가
	});
	let data = {
		customerRequestTitle : "createOrder",
		CustomerAdrressNo : selectedAddressNo,
		goodNos : goodNos,
		quantitys : quantitys,
		totalPrices : totalPrices
	};
	$.post("orderApiController.jsp",data, function() {
		alert('주문성공');
		location.href="home.jsp"
		}).fail(function () {
		alert('주문실패');
	});
});
</script>
</body>
</html>
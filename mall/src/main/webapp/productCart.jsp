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
	ProductCartDao dao = new ProductCartDao();
	ArrayList<ProductCart> list = dao.selectArrayList(goodsTitle, goodsPrice, goodsNo, quantity, cartNo);
	
	
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
                                	<th>선택</th>
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
                                	<td><input type="checkbox" style="width: 50px; margin: 0 auto;"></td>
                                	<td><%=p.getCartNo()%></td>
                                    <td class="product__cart__item">
                                    <div class="product__cart__item__pic">
                                        <img src="img/product/<%=p.getGoodsTitle() %>.png" alt="" width="120" height="90">
                                    </div>
                                    <div class="product__cart__item__text">
                                        <h6><%=p.getGoodsNo()%>.<%=p.getGoodsTitle()%></h6>
                                        <h5><%=p.getGoodsPrice() %></h5>
                                    </div>
                                    </td>
                                    <td class="quantity__item">
                                        <input type="number" value="<%=p.getQuantity() %>" min="1" class="quantity-input" size="10">
                                        <input name="<%=p.getGoodsNo()%>" value="<%=p.getQuantity() %>" hidden="true">
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
                                <a href="productCart.jsp"><i class="fa fa-spinner"></i> 업데이트</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="cart__total">
                        <h6>총 금액</h6>
                        <ul>
                            <li>소계<span class="subtotal">0원</span></li>
                            <li>총계<span id="total">0원</span></li>
                        </ul>
                        <button type="submit" class="primary-btn">장바구니 상품 주문하기</button>
                    </div>
                </div>
            </div>
        </div>
       </form>
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
<script>
    // JavaScript를 사용하여 수량이 변경될 때 소계 업데이트
    const quantityInputs = document.querySelectorAll(".quantity-input");
    quantityInputs.forEach(input => {
        input.addEventListener("input", function () {
            const quantity = parseInt(this.value);
            const price = parseInt(this.closest("tr").querySelector(".product__cart__item h5").innerText);
            const subtotal = quantity * price;
            this.closest("tr").querySelector(".subtotal").innerText = subtotal;
            recalculateTotals();
        });
    });

    // 체크박스에 체크된 제품만 총계에 출력하기
    const checkboxes = document.querySelectorAll('input[name="checked"]');

    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', recalculateTotals);
    });

    function recalculateTotals() {
        let total = 0;

        checkboxes.forEach(checkbox => {
            if (checkbox.checked) {
                const row = checkbox.parentElement.parentElement; // 해당 상품의 행
                const quantity = row.querySelector('.pro-qty-2 input').value;
                const price = parseFloat(row.querySelector('.cart__price').innerText.replace('', '원'));
                const subtotal = quantity * price;
                total += subtotal;
            }
        });

        // 총계를 화면에 표시
        const totalElement = document.getElementById('total');
        totalElement.innerText = total.toFixed(0) + '원';
    }
    
    
    $('.quantity-input').each(function() {
    	$(this).click(function() {
    		//alert($(this).val());
    		let quantity = $(this).val();
    		$(this).next().val(quantity);
    	});
    })
</script>
</body>

</html>
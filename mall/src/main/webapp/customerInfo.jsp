<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	//작성자 : 정인호	
	//고객 정보 페이지

	request.setCharacterEncoding("utf-8");
	
	int customerNo = (int)session.getAttribute("customerNo");// 세션정보 확인

	CustomerDao dao = new CustomerDao();
	
	//고객상세정보 업데이트 시도 체크
	if(request.getParameter("newName") != null){
		dao.updateCustomerInfo(customerNo, request.getParameter("newName"), request.getParameter("newPhone"));
	}	
	//고객 주소 삭제시도 체크
	if(request.getParameter("deleteAddrNo") != null){
		dao.deleteCustomerAddr(Integer.parseInt(request.getParameter("deleteAddrNo")));
		response.sendRedirect("customerInfo.jsp");
	}
	//고객 주소 생성시도 체크
	if(request.getParameter("newAddr") != null && request.getParameter("newAddr").equals("new")){
		dao.createCustomerAddr(Integer.parseInt(request.getParameter("customerNo")));
	}
	//고객 주소 수정시도 체크
	if(request.getParameter("updateAddrNo") != null){
		dao.updateCustomerAddr(Integer.parseInt(request.getParameter("updateAddrNo")), request.getParameter("address"));
	}
	// 고객 상세정보 vo
	HashMap<String,Object> customerInfo = dao.retrieveCustomerInfo(customerNo);
	// 고객 주소 조회 vo
	ArrayList<HashMap<String, Object>> AddrList = dao.retrieveCustomerAddrList(customerNo); 
	
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
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
    <div>
    	<input id="customerNo" readonly="readonly" hidden="true" value="<%=customerNo%>"> 
    </div>
    <!-- Header Section Begin -->
    <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-7">
                        <div class="header__top__left">
                            <p>Free shipping, 30-day return or refund guarantee.</p>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-5">
                        <div class="header__top__right">
                            <div id="signMenu" class="header__top__links">
                                <a href="customerLogin.jsp" id="signIn">Sign in</a>
                                <a href="#">FAQs</a>
                            </div>
                            <div class="header__top__hover">
                                <span>Usd <i class="arrow_carrot-down"></i></span>
                                <ul>
                                    <li>USD</li>
                                    <li>EUR</li>
                                    <li>USD</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-3">
                    <div class="header__logo">
                        <a href="./index.html"><img src="img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <nav class="header__menu mobile-menu">
                        <ul>
                            <li><a href="./index.html">Home</a></li>
                            <li><a href="./shop.html">Shop</a></li>
                            <li><a href="#">Pages</a>
                                <ul class="dropdown">
                                    <li><a href="./about.html">About Us</a></li>
                                    <li><a href="./shop-details.html">Shop Details</a></li>
                                    <li><a href="./shopping-cart.html">Shopping Cart</a></li>
                                    <li><a href="./checkout.html">Check Out</a></li>
                                    <li><a href="./blog-details.html">Blog Details</a></li>
                                </ul>
                            </li>
                            <li><a href="./blog.html">Blog</a></li>
                            <li><a href="./contact.html">Contacts</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3 col-md-3">
                    <div class="header__nav__option">
                        <a href="#" class="search-switch"><img src="img/icon/search.png" alt=""></a>
                        <a href="#"><img src="img/icon/heart.png" alt=""></a>
                        <a href="#"><img src="img/icon/cart.png" alt=""> <span>0</span></a>
                        <div class="price">$0.00</div>
                    </div>
                </div>
            </div>
            <div class="canvas__open"><i class="fa fa-bars"></i></div>
        </div>
    </header>
    <!-- Header Section End -->

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>Customer Info</h4>
                        <div class="breadcrumb__links">
                            <a href="./index.html">Home</a>
                            <a href="./shop.html">Customer</a>
                            <span>Info</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="checkout__form">
                    <div class="row">
                    	<!-- 배송지관리 -->
                        <div class="col-lg-8 col-md-6">
                            <h6 class="checkout__title">배송지 관리</h6>
                            
                            <!-- 배송지 -->
                          	<%
                          	int addrListIndex = 0;
                           	for(HashMap<String, Object> addr : AddrList ){
                           		addrListIndex += 1;
                           	%>
                            <form action="customerInfo.jsp" method="post">
	                            <div class="rounded border p-3 mb-2">
		                            <div class="row">
		                                <div class="col-lg-6">
		                                    <div class="checkout__input">
		                                        <p>배송지 등록일 </p>
		                                        <input hidden="true" type="number" name="updateAddrNo" value="<%=addr.get("addrNo")%>">
		                                        <input type="text" value="<%=addr.get("updatedate")%>" readonly="readonly">
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="checkout__input">
		                                <p>배송주소 &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; <button class="btn btn-light" type="submit">수정하기</button> <a name="deleteAddress" class="btn btn-light" href="customerInfo.jsp?deleteAddrNo=<%=addr.get("addrNo")%>">삭제하기</a></p>
		                                <textarea class="form-control" rows="3" name="address" readonly="readonly"><%=addr.get("address")%></textarea>
		                            </div>
	                            </div>
                            </form>
                            <%
                           	}
                            %>
                            
                        	<div class="row">
                        		<div class="col-5"></div>
                        		<div class="col-2">
                        		<button type="button" class="btn btn-light" id="createAddr" >&nbsp;&nbsp;+&nbsp;&nbsp;</button>
                        		</div>
                        		<div class="col"></div>
                        	</div>
                        </div>
                        <div class="col-lg-4 col-md-6">
						    <div class="checkout__order">
						        <h4 class="order__title">고객정보</h4>
						        <div class="checkout__order__products"></div>
						        <ul class="checkout__total__products">
						            <li>아이디 <span id="userId"><%=customerInfo.get("customerId") %></span></li>
						            <li>이름 <span id="userName"><%=customerInfo.get("customerName") %></span></li>
						            <li>전화번호 <span id="userPhone"><%=customerInfo.get("customerPhone") %></span></li>
						            <li>가입일 <span id="joinDate"><%=customerInfo.get("createdate") %></span></li>
						        </ul>
						        <ul id="updatePwForm" class="checkout__total__all">
						            <li><button type="button" class="site-btn p-1" id="updateInfo" onclick="editUserInfo()">고객정보 수정하기</button></li>
						            <li><button type="button" class="site-btn p-1" id="updatePw" >비밀번호 변경하기</button></li>
						        </ul>
						        <div class="checkout__input__checkbox">
						        </div>
						        <p id="pwAlert">보안을 위해 이전에 사용되지 않은 <br> 비밀번호로 변경 가능합니다.</p>
						
						        <button type="button" id="deleteCustomer" class="site-btn">회원탈퇴하기</button>
						    </div>
					</div>
                    </div>
                    
                </form>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->

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
    	//고객정보 변경시도
		function editUserInfo() {
		    // 고객 정보를 입력 폼으로 바꿉니다.
		    console.log('editUserInfo()');
		    let customerName = $('#userName').text();
		    let customerPhone = $('#userPhone').text();
		    document.getElementById('userName').innerHTML = '<input type="text" id="newUserName" value="'+ customerName +'">';
		    document.getElementById('userPhone').innerHTML = '<input type="text" id="newUserPhone" value="'+ customerPhone +'">';
		    
		    // 수정 완료 버튼 추가
		    document.querySelector('.checkout__total__all').innerHTML += '<li><button type="button" class="site-btn p-1" onclick="updateUserInfo()">저장</button></li>';
		    //다른버튼제거
		    document.querySelector('#updateInfo').remove();
		    document.querySelector('#updatePw').remove();
		    document.querySelector('#deleteCustomer').remove();
		};
		//고객정보 변경
		function updateUserInfo(){
			let newName = $('#newUserName').val();
            let newPhone = $('#newUserPhone').val();

            $.post("customerInfo.jsp", // 변경정보 비동기 post요청
            {
                newName: newName,
                newPhone: newPhone
            },function(){
                location.reload(); // 새로고침 
            });
			
		}
		
		
		//주소 입력 폼 readonly 해제
		$('.form-control[name=address]').each(function() {
	        $(this).click(function() {
	            $(this).prop("readonly", false); 
	        });
	    });
		
		//주소가 하나 남았을 때 삭제버튼을 없애기
		if($('a[name=deleteAddress]').length == 1){
            $('a[name=deleteAddress]').first().remove();
        }
		
		//빈 주소를 하나 추가하기
        $('#createAddr').click(function () {
            let customerNo = $('#customerNo').val();

            $.post("customerInfo.jsp", //비동기 포스트요청
            {
                customerNo: customerNo,
                newAddr: "new"
            },function(){
                location.reload(); // 성공 후 새로고침
            });
        });
		
     	// 고객 비밀번호 수정시도
        $('#updatePw').click(function () { 
			$('#updateInfo').remove(); //다른 버튼 없애기 및 비밀번호 확인창 생성
			$('#updatePw').remove();
			$('#deleteCustomer').remove();
			
			$('#updatePwForm').append('<input id="currentPw" class="form-control my-2" type="password" placeholder="현재 비밀번호">');
			$('#updatePwForm').append('<input id="newPw" class="form-control my-2" type="password" placeholder="신규 비밀번호">');
			$('#updatePwForm').append('<input id="newPwCheck" class="form-control my-2" type="password" placeholder="신규 비밀번호 재입력">');
			$('#updatePwForm').append('<button type="button" class="site-btn p-1" id="validatePw" >비밀번호 수정</button>');
			$('#updatePwForm').append('<button onclick="location.reload()" class="site-btn p-1" >취소</button>');
			//비밀번호 밸리데이션
			$('#validatePw').click(function () {
				if($('#newPw').val() != $('#newPwCheck').val()){
					$('#pwAlert').text('신규 비밀번호 확인이 일치하지 않습니다.');
				}else{
					$('#pwAlert').text('');
					if($('#currentPw').val() == $('#newPw').val()){
						$('#pwAlert').text('현재 비밀번호와 다른 신규 비밀번호를 입력해주세요.');
					}else{
						let newPw = $('#newPw').val();
						let currentPw = $('#currentPw').val();
						
						$.post("customerPwValid.jsp",{ // 비동기 post 수정요청
							customerNo : $('#customerNo').val(),
							currentPw: currentPw,
							newPw: newPw
			            }, function () {
			            	alert('비밀번호가 변경되었습니다'); 
			            	location.reload(); 
						}).fail(function () {
							$('#pwAlert').text('비밀번호가 맞지 않거나 신규 비밀번호가 예전에 사용된 비밀번호입니다.');
						});
					}
				}
			});
        });
     	
        //회원탈퇴 시도
        $('#deleteCustomer').click(function() {
        	$('#updateInfo').remove(); //다른 버튼 없애기 및 비밀번호 확인창 생성
			$('#updatePw').remove();
			$('#deleteCustomer').remove();
			$('#pwAlert').text('');
			$('#updatePwForm').append('<input id="deleteCustomerCheck" class="form-control my-2" type="password" placeholder=" 회원탈퇴, 비밀번호입력">');
			$('#updatePwForm').append('<button id="deleteCustomerConfirm" class="site-btn p-1" >회원탈퇴 확인</button>');
			$('#updatePwForm').append('<button onclick="location.reload()" class="site-btn p-1" >취소</button>');
			
			$('#deleteCustomerConfirm').click(function () {
				$.post("customerDelete.jsp",{
					customerNo : $('#customerNo').val(), 
					currentPw: $('#deleteCustomerCheck').val()
				}, function () {
            		alert('회원탈퇴가 완료되었습니다.');
					location.href="customerLogin.jsp";
				}).fail(function () {
					$('#pwAlert').text('비밀번호가 맞지않습니다.');
				});
			});
        });
        
		
        
</script>
</body>

</html>
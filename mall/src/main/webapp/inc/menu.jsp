<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	/*로그인 세션체크 여부에 따라 로그인버튼 스위칭*/
	String loginBtnIncMenu = "Log in";
	String urlLoginBtnIncMenu = "./customerLogin.jsp";
	Integer seesionCustomerNo = (Integer)session.getAttribute("customerNo");
	Integer sessionManagerNo = (Integer)session.getAttribute("managerNo");
	if(seesionCustomerNo != null){
		loginBtnIncMenu = "Log out";
		urlLoginBtnIncMenu = "./customerApiController.jsp?customerRequestTitle=logout";
	}if(sessionManagerNo != null){
		loginBtnIncMenu = "Log out";
		urlLoginBtnIncMenu = "./managerLogoutAction.jsp";
	}
	/*세션에 따라 info버튼 스위칭 */
	String infoBtn = "My Info";
	String urlInfoBtn = "./customerInfo.jsp";
	if(sessionManagerNo != null){
		infoBtn = "Management";
		urlInfoBtn = "./managerOne.jsp";
	}
%>	
  <!-- 정인호 수정 U231106 : 로그인링크, customerInfo링크 -->

  <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Offcanvas Menu Begin -->
    <div class="offcanvas-menu-overlay"></div>
    <div class="offcanvas-menu-wrapper">
        <div class="offcanvas__option">
            <div class="offcanvas__links">
                <a href="<%=urlLoginBtnIncMenu%>"><%=loginBtnIncMenu%></a>
                <a href="#">FAQs</a>
            </div>
        </div>
        <div class="offcanvas__nav__option">
            <a href="#" class="search-switch"><img src="img/icon/search.png" alt=""></a>
            <a href="#"><img src="img/icon/heart.png" alt=""></a>
            <a href="#"><img src="img/icon/cart.png" alt=""> <span>0</span></a>
            <div class="price">$0.00</div>
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="offcanvas__text">
            <p>저희의 쇼핑몰 프로젝트에 오신 것을 환영합니다.</p>
        </div>
    </div>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
    <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-7">
                        <div class="header__top__left">
                            <p>저희의 쇼핑몰 프로젝트에 오신 것을 환영합니다.</p>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-5">
                        <div class="header__top__right">
                            <div class="header__top__links">
                                <a href="<%=urlLoginBtnIncMenu%>"><%=loginBtnIncMenu%></a>
                                <a href="<%=urlInfoBtn %>"><%=infoBtn %></a>
                                <a href="orderList.jsp">My ORDER</a>
                                <a href="#">FAQs</a>
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
                        <a href="./Home.jsp"><img src="img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <nav class="header__menu mobile-menu">
                        <ul>
                            <li><a href="./Home.jsp">홈</a></li>
                            <li><a href="./productList.jsp">쇼핑</a></li>
                            <li><a href="#">게시판</a>
                            	<ul class="dropdown">
                            		<li><a href="./noticeList.jsp">Notice</a></li>
                                    <li><a href="./reviewList.jsp">Review</a></li>
                            	</ul>
                            </li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3 col-md-3">
                    <div class="header__nav__option">
                        <a href="#" class="search-switch"><img src="img/icon/search.png" alt=""></a>
                        <a href="./productCart.jsp"><img src="img/icon/cart.png" alt=""> <span>0</span></a>
                    </div>
                </div>
            </div>
            <div class="canvas__open"><i class="fa fa-bars"></i></div>
        </div>
    </header>
    <!-- Header Section End -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>상품 관리</title>

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
	// controller code
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	
	GoodsDao gDao = new GoodsDao();
	ArrayList<Goods> list = gDao.selectGoodsList(beginRow, rowPerPage);
	
	int totalRow = gDao.goodsCNT();
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	
	GoodsImgDao iDao = new GoodsImgDao();
	

	// session정보에 managerNo가 없으면 오류 메세지가 출력된 managerLogin.jsp로 이동
	if(session.getAttribute("managerNo") == null){
		String msg2 = "x";
		response.sendRedirect("./managerLogin.jsp?msg2="+msg2);
	}
%>
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
                        <h4>Goods Management</h4>
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
                        <table >
                            <thead>
                                <tr>
                                    <th>Goods</th>
                                    <th>Goods Memo</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                            	for(Goods g : list){
                            %>
                                <tr>
                                    <td class="product__cart__item">
                                        <div class="product__cart__item__pic" >
                                            <img src="img/product/<%=iDao.selectGoodsImg(g.getGoodsNo()).getFilename()%>" alt="" width="100px" height="100px">
                                        </div>
                                        <div class="product__cart__item__text">
                                            <h6><%=g.getGoodsTitle() %></h6>
                                            <h5>$<%=g.getGoodsPrice() %></h5>
                                        </div>
                                    </td>
                                    <td class="cart__close">
                                    	<%=g.getGoodsMemo() %>
                                    </td>
                                    <td class="col-lg-3">
                                    	<a href="<%=request.getContextPath()%>/deleteGoodsImgAction.jsp?goodsNo=<%=g.getGoodsNo() %>" class="primary-btn">Delete</a>
                                    	<a href="<%=request.getContextPath()%>/updateGoodsForm.jsp?goodsNo=<%=g.getGoodsNo() %>" class="primary-btn">Edit</a>
                                    </td>
                                </tr>
                             <%
                            	}
                             %>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <a href="<%=request.getContextPath()%>/managerOne.jsp" class="primary-btn">Return Management</a>
                        </div>
                        <div>
                        	<span class="col-lg-2 col-md-6 col-sm-6">Page<%=currentPage %></span>
                        </div>
                        <div class="col-lg-5 col-md-6 col-sm-6">
                            <a href="<%=request.getContextPath()%>/insertGoodsForm.jsp" class="primary-btn" style=float:right>Add Goods</a>
                        </div>
                    </div>
                </div>
              <div class="col-lg-12">
        <div class="product__pagination">
            <a href="<%=request.getContextPath()%>/goodsManagementList.jsp?currentPage=<% 
            																			  out.print(currentPage-1);
            																			  if(currentPage-1 < 1){
            																				  out.print(currentPage);
            																			  }
            																										%>"><span class="arrow_left"></span></a>
          	<a href="<%=request.getContextPath()%>/goodsManagementList.jsp?currentPage=1">First</a>
          <%
          	for(int i=1; i<= lastPage; i=i+1){
          %>
          	<a href="<%=request.getContextPath()%>/goodsManagementList.jsp?currentPage=<%=i %>"><%=i %></a>
          <%
          	}
          %>
          	<a href="<%=request.getContextPath()%>/goodsManagementList.jsp?currentPage=<%=lastPage %>">Last</a>
            <a href="<%=request.getContextPath()%>/goodsManagementList.jsp?currentPage=<%
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
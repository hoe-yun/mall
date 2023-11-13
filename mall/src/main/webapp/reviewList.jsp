<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>리뷰 리스트</title>

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
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	// model 호출코드 
	ReviewDao reviewDao = new ReviewDao();
	ArrayList<HashMap<String, Object>> reviewlist = reviewDao.selectReviewList(beginRow,rowPerPage);
	
	
	// end controller code
	
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
                        <h4>Review</h4>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
    
	<br><br>
	
	<!-- Notice List Table Section Begin -->
	<section>
		<div class="container">
			<div class="col-lg-12">
				<table class="col-lg-12 table table-hover">
					<thead>
						<tr>
							<th width=5%>NO</th>
							<th width=20%>상품사진</th>
							<th width=45%>내용</th>
							<th width=10%>생성일자</th>
							<th width=10%>업데이트</th>
							<th width=10%>삭제</th>
						</tr>
					</thead>
					<tbody>
					<% 
						for(HashMap<String, Object> map : reviewlist ){
					%>
						<tr>
							<td><%=map.get("reviewNo") %></td>
							<td><a href="./productDetail.jsp?goodsNo=<%=map.get("goodsNo")%>"><img src="img/product/<%=map.get("filename") %>"></a></td>
							<td><a class="text-dark" href="<%=request.getContextPath()%>/reviewOne.jsp?reviewNo=<%=map.get("reviewNo") %>"><%=map.get("reviewContent")%></a></td>
							<td><%=map.get("createdate") %></td>
							<td><%=map.get("updatedate") %></td>
							<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/delectReviewAction.jsp?reviewNo=<%=map.get("reviewNo") %>">X</a></td>
						</tr>
					<%
						}
					%>
					</tbody>
				</table>
				<br>
				<a href="<%=request.getContextPath()%>/orderList.jsp" class="primary-btn" style=float:left>주문 목록으로 돌아가기</a>
				<div class="row">
                    <div class="col-lg-12">
                        <div class="product__pagination">
                            <a href="<%=request.getContextPath()%>/reviewList.jsp?currentPage=<%out.print(currentPage-1);
   																							if(currentPage-1 < 1){
            																				 	 out.print(currentPage);}
            																					%>"><span class="arrow_left"></span></a>
                            <a href="<%=request.getContextPath()%>/reviewList.jsp?currentPage=<%=currentPage %>"><%=currentPage %></a>
                            <a href="<%=request.getContextPath()%>/reviewList.jsp?currentPage=<%=currentPage+1%>"><span class="arrow_right"></span></a>
                        </div>
                    </div>
                </div>
			</div>
		</div>
	</section>
	<!-- Notice List Table Section End -->
	
	<br><br>
	
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
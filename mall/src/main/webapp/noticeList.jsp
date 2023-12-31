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
    <title>공지사항</title>

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
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Nostice> list = noticeDao.selectNoticeList(beginRow,rowPerPage);
	
	int totalRow = noticeDao.noticeCNT();
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	
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
                        <h4>Notice</h4>
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
							<th width=5%>No.</th>
							<th width=60%>Title</th>
							<th width=15%>CREATE</th>
							<th width=15%>UPDATE</th>
							<th width=5%></th>
						</tr>
					</thead>
					<tbody>
					<% 
						for(Nostice notice : list){
					%>
						<tr>
							<td><%=notice.getNoticeNo() %></td>
							<td><a class="text-dark" href="<%=request.getContextPath()%>/noticeOne.jsp?noticeNo=<%=notice.getNoticeNo() %>"><%=notice.getNoticeTitle() %></a></td>
							<td><%=notice.getCreatedate() %></td>
							<td><%=notice.getUpdatedate() %></td>
							<td>
							<%
							if(session.getAttribute("managerNo") != null){
							%>
								<a class="btn btn-danger" href="<%=request.getContextPath()%>/delectNoticeAction.jsp?noticeNo=<%=notice.getNoticeNo() %>">X</a>
							<%
							}
							%>
							</td>
						</tr>
					<%
						}
					%>
					</tbody>
				</table>
				<br>
				<%
				if(session.getAttribute("managerNo") != null){
				%>
					<a href="<%=request.getContextPath()%>/managerOne.jsp" class="primary-btn" style=float:left>return to Management</a>
					<a href="<%=request.getContextPath()%>/insertNoticeForm.jsp" class="primary-btn" style=float:right>add notice</a>
				<%
				}
				%>
				<div class="row">
                    <div class="col-lg-12">
                        <div class="product__pagination">
                            <a href="<%=request.getContextPath()%>/noticeList.jsp?currentPage=<% 
		            																			  out.print(currentPage-1);
		            																			  if(currentPage-1 < 1){
		            																				  out.print(currentPage);
		            																			  }
		            																										%>"><span class="arrow_left"></span></a>
                            <a href="<%=request.getContextPath()%>/noticeList.jsp?currentPage=<%=currentPage %>"><%=currentPage %></a>
                            <a href="<%=request.getContextPath()%>/noticeList.jsp?currentPage=<%
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
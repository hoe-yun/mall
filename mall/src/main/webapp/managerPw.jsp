<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>관리자 페이지</title>

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
	// session정보에 managerNo가 없으면 오류 메세지가 출력된 managerLogin.jsp로 이동
	if(session.getAttribute("managerNo") == null){
		String msg2 = "x";
		response.sendRedirect("./managerLogin.jsp?msg2="+msg2);
	}
	
	int managerNo = (Integer)session.getAttribute("managerNo");
	
	String msg = request.getParameter("msg");
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
                        <h4>Management Page</h4>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
    <br>
	<!-- managerPw Section Begin -->
	<div class="col-lg-4 col-md-6" style="margin: 0 auto;">
	    <div class="checkout__order">
	    	<form action="managerPwAction.jsp">
		        <h4 class="order__title">Password</h4>
		        	<table >
		        		<tr>
		        			<th width="200px">현재 비밀번호</th>
		        			<td width="350px"><input type="password" name="managerPw" id="pw" style=float:right></td>
		        		</tr>
		        		<tr>
		        			<th height="30px"></th>
		        			<td><span id="pwMsg" class="msg" style=color:red;float:right>
		        			<%
		        				if(msg != null){
		        					out.print(msg);
		        				}
		        			%>
		        			</span></td>
		        		</tr>
		        		<tr>
		        			<th>새로운 비밀번호</th>
		        			<td><input type="password" name="newManagerPw" id="newPw" style=float:right></td>
		        		</tr>
		        		<tr>
		        			<th height="30px"></th>
		        			<td><span id="newPwMsg" class="msg" style=color:red;float:right></span></td>
		        		</tr>
		        		<tr>
		        			<th>새로운 비밀번호 확인</th>
		        			<td><input type="password" name="newManagerPwC" id="newPwC" style=float:right></td>
		        		</tr>
		        		<tr>
		        			<th height="30px"></th>
		        			<td><span id="newPwCMsg" class="msg" style=color:red;float:right></span></td>
		        		</tr>
		        	</table>
		        <button type="submit" class="site-btn" id="btn">PLACE ORDER</button>
	   		</form>
	    </div>
 	</div>
	<!-- managerPw Section End -->
	<br>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
    // 비밀번호 유효성 체크
    $('#newPw').blur(function(){
    	if($('#pw').val() == $('#newPw').val()){
    		$('#newPwMsg').text('동일한 Pw로 바꿀 수 없습니다.');
    		$('#newPw').focus();
    	}else{
    		$('#newPwMsg').text('');
    		$('#newPwC').focus;
    	}
    });
    
    $('#newPwC').blur(function(){
    	if($('#newPwC').val() != $('#newPw').val()){
    		$('#newPwCMsg').text('Pw가 같지 않습니다.');
    		$('#newPw').focus();
    	}else{
    		$('#newPwCMsg').text('');
    		$('#btn').focus;
    	}
    });
    </script>
</body>
</html>
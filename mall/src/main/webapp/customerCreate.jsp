<%@page import="vo.CustomerDomain"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//작성자 : 정인호 
	//고객회원가입 시도하면 가입진행
	if(request.getParameter("id") != null){
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String addr = request.getParameter("addr");		
		
		CustomerDomain.CreateCustomerVo vo = new CustomerDomain.CreateCustomerVo(id,pw,name,phone,addr);
		CustomerDao dao = new CustomerDao();
		int result = dao.createCumstomer(vo);
		
		if(result == 0){ //밸리데이션
			response.setStatus(400); // 중복된 아이디
		}else{
			response.setStatus(200); // 가입성공
		}
	}	
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

    <!-- Contact Section Begin -->
    <section class="contact spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="contact__text">
                        <div class="section-title">
                            <span>createId</span>
                            <h2>회원가입</h2>
                            <p id="pwAlert"></p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="checkout__order">
                        <form action="#">
                            <div class="row">
                                <div class="col-lg-12">
                                    <input class="form-control my-2" id="id" type="text" placeholder="아이디">
                                    <input class="form-control my-2" id="pw" type="password" placeholder="패스워드">
                                    <input class="form-control my-2" id="pwcheck" type="password" placeholder="패스워드확인">
                                    <input class="form-control my-2" id="name" type="text" placeholder="이름">
                                    <input class="form-control my-2" id="phone" type="text" placeholder="전화번호">
                                    <input class="form-control my-2" id="addr" type="text" placeholder="기본배송지주소">
                                    <button id="createBtn" type="button" class="site-btn">회원가입</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Contact Section End -->

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
    <script type="text/javascript"></script>
    <script>
    //가입버튼 누르면진행
    $('#createBtn').click(function () {
		if($('#pw').val() != $('#pwcheck').val()){
			$('#pwAlert').text('신규 비밀번호 확인이 일치하지 않습니다.');
		}else{
			$('#pwAlert').text('');
			$.post("customerCreate.jsp",{ //post비동기요청
				id : $('#id').val(),
				pw : $('#pw').val(),
				name : $('#name').val(),
				phone : $('#phone').val(),
				addr : $('#addr').val()
            }, function () {
            	alert('회원가입이 완료되었습니다.');
            	location.href="customerLogin.jsp"; // 로그인페이지로
			}).fail(function () {
				$('#pwAlert').text('사용할 수 없는 아이디 입니다.'); // 중복경고
			});
			
		}
		
	});
    </script>
</body>

</html>
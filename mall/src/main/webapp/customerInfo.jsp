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
	
	//고객 주소 수정시도 체크
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
   <!-- 상단 메뉴바/ inc폴더안에 menu.jsp파일로 분리하여 불러오기  -->
  <jsp:include page="/inc/menu.jsp"></jsp:include>

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
	                            <div class="rounded border p-3 mb-2">
		                            <div class="row">
		                                <div class="col-lg-6">
		                                    <div class="checkout__input">
		                                        <p>배송지 등록일 </p>
		                                        <input type="text" value="<%=addr.get("updatedate")%>" readonly="readonly">
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="checkout__input">
		                                <p>
	                                        <input hidden="true" type="number" name="AddressNo" value="<%=addr.get("addrNo")%>">
		                                	배송주소
		                                	<button class="btn btn-light ml-5" type="button" name="updateAddressBtn">수정하기</button>
		                                	<button class="btn btn-light" type="button" name="deleteAddressBtn">삭제하기</button>
		                                </p>
		                                <textarea class="form-control" rows="3" name="address" readonly="readonly"><%=addr.get("address")%></textarea>
		                            </div>
	                            </div>
                            <%
                           	}
                            %>
                            
                        	<div class="row">
                        		<div class="col-5"></div>
                        		<div class="col-2">
                        		<button type="button" class="btn btn-light" id="createAddressEmptyBtn" >&nbsp;&nbsp;+&nbsp;&nbsp;</button>
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
						            <li>이름 <span id="customerName"><%=customerInfo.get("customerName") %></span></li>
						            <li>전화번호 <span id="customerPhone"><%=customerInfo.get("customerPhone") %></span></li>
						            <li>가입일 <span id="joinDate"><%=customerInfo.get("createdate") %></span></li>
						        </ul>
						        <ul id="customerInfoBtnForm" class="checkout__total__all">
						            <li><button type="button" class="site-btn p-1" id="editCustomerInfoBtn" onclick="editCustomerInfo()">고객정보 수정하기</button></li>
						            <li><button type="button" class="site-btn p-1" id="editCustomerPwBtn" >비밀번호 변경하기</button></li>
						        </ul>
						        <div class="checkout__input__checkbox">
						        </div>
						        <p id="pwAlert">보안을 위해 이전에 사용되지 않은 <br> 비밀번호로 변경 가능합니다.</p>
						
						        <button type="button" id="deleteCustomerAccountBtn" class="site-btn">회원탈퇴하기</button>
						    </div>
						</div>
                    </div>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->

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
    <script>
    	//고객정보 수정
		function editCustomerInfo() {
		    // 고객정보 수정폼 변경
		    let customerName = $('#customerName').text();
		    let customerPhone = $('#customerPhone').text();
		    $('#customerName').html('<input type="text" id="newCustomerName" value="'+ customerName +'">');
		    $('#customerPhone').html('<input type="text" id="newCustomerPhone" value="'+ customerPhone +'">');
		    // 수정 완료 버튼 추가, 다른버튼 제거
		    $('#customerInfoBtnForm').append('<li><button type="button" class="site-btn p-1" onclick="updateUserInfo()">수정완료</button></li>');
		    $('#editCustomerInfoBtn').remove();
		    $('#editCustomerPwBtn').remove();
		    $('#deleteCustomerAccountBtn').remove();
		};
		//고객정보 수정 완료 버튼 누름
		function updateUserInfo(){
			let newCustomerName = $('#newCustomerName').val();
            let newCustomerPhone = $('#newCustomerPhone').val();
            $.post("customerApiController.jsp", // 변경정보 비동기 post요청
            {
            	customerRequestTitle : "updateCustomerInfo",
                newCustomerName : newCustomerName,
                newCustomerPhone : newCustomerPhone
            },function(){
                location.reload(); // 성공. 새로고침 
            }).fail(function () {
				//실패
			});
		}
		
		
		//배송주소 입력 폼 readonly 해제
		$('.form-control[name=address]').each(function() {
	        $(this).click(function() {
	            $(this).prop("readonly", false);
	        });
	    });		
		//배송주소 가 하나 남았을 때 삭제버튼을 없애기
		if($('button[name = deleteAddressBtn]').length == 1){
            $('button[name = deleteAddressBtn]').first().remove();
        }		
		//배송주소 (비어있음)을 하나 추가
        $('#createAddressEmptyBtn').click(function () {
            $.post("customerApiController.jsp", //비동기 포스트요청
            {
            	customerRequestTitle : "createAddressEmpty"
            },function(){
                location.reload(); // 성공 후 새로고침
            });
        });
		//배송주소 수정버튼클릭
		console.log($('button[name = updateAddressBtn]'));
		$('button[name=updateAddressBtn]').each(function () {
			$(this).click(function(){
				let addressNo = $(this).siblings().first().val();
				let newAddress = $(this).parent().next().val();
				$.post("customerApiController.jsp", // 변경정보 비동기 post요청
			            {
			            	customerRequestTitle : "updateAddressOne",
			            	addressNo : addressNo,
			                newAddress : newAddress
			            },function(){
			                location.reload(); // 성공. 새로고침 
			            }).fail(function () {
							//실패
						});
			});
		});
		//배송주소 삭제버튼클릭
		console.log($('button[name = deleteAddressBtn]'));
		$('button[name=deleteAddressBtn]').each(function () {
			$(this).click(function(){
				let addressNo = $(this).siblings().first().val();
				$.post("customerApiController.jsp", // 변경정보 비동기 post요청
			            {
			            	customerRequestTitle : "deleteAddressOne",
			            	addressNo : addressNo,
			            },function(){
			                location.reload(); // 성공. 새로고침 
			            }).fail(function () {
							//실패
						});
			});
		});
		
     	// 고객 비밀번호 수정시도
        $('#editCustomerPwBtn').click(function () { 
			$('#editCustomerInfoBtn').remove(); //다른 버튼 없애기 및 비밀번호 확인창 생성
			$('#editCustomerPwBtn').remove();
			$('#deleteCustomerAccountBtn').remove();
			
			$('#customerInfoBtnForm').append('<input id="currentPw" class="form-control my-2" type="password" placeholder="현재 비밀번호">');
			$('#customerInfoBtnForm').append('<input id="newPw" class="form-control my-2" type="password" placeholder="신규 비밀번호">');
			$('#customerInfoBtnForm').append('<input id="newPwCheck" class="form-control my-2" type="password" placeholder="신규 비밀번호 재입력">');
			$('#customerInfoBtnForm').append('<button type="button" class="site-btn p-1" id="updateCustomerPwBtn" >비밀번호 수정</button>');
			$('#customerInfoBtnForm').append('<button onclick="location.reload()" class="site-btn p-1" >취소</button>');
			//비밀번호 수정 , 밸리데이션
			$('#updateCustomerPwBtn').click(function () {
				if($('#newPw').val() != $('#newPwCheck').val()){
					$('#pwAlert').text('신규 비밀번호 확인이 일치하지 않습니다.');
				}else{
					$('#pwAlert').text('');
					if($('#currentPw').val() == $('#newPw').val()){
						$('#pwAlert').text('현재 비밀번호와 다른 신규 비밀번호를 입력해주세요.');
					}else{
						let newPw = $('#newPw').val();
						let currentPw = $('#currentPw').val();
						
						$.post("customerApiController.jsp",{ // 비동기 post 수정요청
							customerRequestTitle : "updateCustomerPw",
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
        $('#deleteCustomerAccountBtn').click(function() {
        	$('#updateInfo').remove(); //다른 버튼 없애기 및 비밀번호 확인창 생성
			$('#editCustomerPwBtn').remove();
			$('#deleteCustomerAccountBtn').remove();
			$('#pwAlert').text('');
			$('#customerInfoBtnForm').append('<input id="deleteCustomerCheckPw" class="form-control my-2" type="password" placeholder=" 회원탈퇴, 비밀번호입력">');
			$('#customerInfoBtnForm').append('<button id="deleteCustomerAccountConfirmBtn" class="site-btn p-1" >회원탈퇴 확인</button>');
			$('#customerInfoBtnForm').append('<button onclick="location.reload()" class="site-btn p-1" >취소</button>');
			
			$('#deleteCustomerAccountConfirmBtn').click(function () {
				$.post("customerApiController.jsp",{
					customerRequestTitle : "deleteCustomerAccount",
					currentPw: $('#deleteCustomerCheckPw').val()
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
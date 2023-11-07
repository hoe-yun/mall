<%@page import="vo.CustomerDomain"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//작성자 정인호
//Api 요청 Controller

request.setCharacterEncoding("utf-8");
String customerRequestTitle = request.getParameter("customerRequestTitle");
CustomerDao dao = new CustomerDao();
/** 세션 비회원만 접근가능 **/
if(customerRequestTitle == null){
	return;
}

//로그인
if(customerRequestTitle.equals("login")){
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	
	int customerNo = dao.loginCustomer(customerId,customerPw);
	if (customerNo != 0){
		System.out.println(" login 성공 customerNo  : " + customerNo);
		session.setAttribute("customerNo", customerNo);
		response.setStatus(200);
		response.sendRedirect("customerInfo.jsp"); // 성공시 상세페이지로
		return;
	}else{
		System.out.println(" login 실패");
		response.setStatus(400);
		return;
	}
}
//회원가입
if(customerRequestTitle.equals("createCustomerAccount")){
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");		
	CustomerDomain.CreateCustomerVo vo = new CustomerDomain.CreateCustomerVo(id,pw,name,phone,address);
	int validation = dao.createCumstomer(vo);
	if(validation == 1){
		System.out.println(" createCustomerAccount 성공");
		response.setStatus(200);
		return;
	}else{
		System.out.println(" createCustomerAccount 실패");
		response.setStatus(400);
		return;
	}
}	
/** 세션 회원만 접근가능 **/
//로그인세션이 없은 요청은 되돌림
Integer customerNo = (int)session.getAttribute("customerNo");// 세션정보 확인
if(customerNo == null ){
	return;
}

//로그아웃
if(customerRequestTitle.equals("logout")){
	session.removeAttribute("customerNo");
	System.out.println(" logout 성공");
	response.sendRedirect("./customerLogin.jsp"); // $.(post) 요청 아님
	return;
}
//고객정보 업데이트
if(customerRequestTitle.equals("updateCustomerInfo")){
	String newCustomerName = request.getParameter("newCustomerName");
	String newCustomerPhone = request.getParameter("newCustomerPhone");
	
	int validation = dao.updateCustomerInfo(customerNo, newCustomerName, newCustomerPhone);
	if(validation == 1){
		System.out.println(" updateCustomerInfo 성공");
		response.setStatus(200);
		return;
	}else{
		System.out.println(" updateCustomerInfo 실패");
		response.setStatus(400);
		return;
	}
}
//배송지 하나 추가
if(customerRequestTitle.equals("createAddressEmpty")){
	int validation = dao.createCustomerAddr(customerNo);
	
	if(validation == 1){
		System.out.println(" createAddressEmpty 성공");
		response.setStatus(200);
		return;
	}else{
		System.out.println(" createAddressEmpty 실패");
		response.setStatus(400);
		return;
	}
}
//배송지 하나 제거
if(customerRequestTitle.equals("deleteAddressOne")){
	int addressNo = Integer.parseInt(request.getParameter("addressNo"));
	int validation = dao.deleteCustomerAddr(customerNo ,addressNo);
	
	if(validation == 1){
		System.out.println(" deleteAddressOne 성공");
		response.setStatus(200);
		return;
	}else{
		System.out.println(" deleteAddressOne 실패");
		response.setStatus(400);
		return;
	}
}
//배송지 하나 수정
if(customerRequestTitle.equals("updateAddressOne")){
	int addressNo = Integer.parseInt(request.getParameter("addressNo"));
	String newAddress = request.getParameter("newAddress");
	
	int validation = dao.updateCustomerAddr(customerNo, addressNo, newAddress);
	if(validation == 1){
		System.out.println(" updateAddressOne 성공");
		response.setStatus(200);
		return;
	}else{
		System.out.println(" updateAddressOne 실패");
		response.setStatus(400);
		return;
	}
}
//고객 비밀번호 변경
if(customerRequestTitle.equals("updateCustomerPw")){
	String currentPw = request.getParameter("currentPw");
	String newPw = request.getParameter("newPw");
	
	int validation = dao.vaildateUpdatePw(customerNo, currentPw, newPw);
	if(validation == 1){
		System.out.println(" updateCustomerPw 성공");
		response.setStatus(200);
		return;
	}else{
		System.out.println(" updateCustomerPw 실패"); // 비밀번호가 이전에 사용되었음
		response.setStatus(400);
		return;
	}
}
//고객 회원탈퇴
if(customerRequestTitle.equals("deleteCustomerAccount")){
	String currentPw = request.getParameter("currentPw");
	
	int validation = dao.deleteCustomer(customerNo, currentPw);
	if(validation == 1){
		System.out.println(" deleteCustomerAccount 성공");
		session.removeAttribute("customerNo");
		response.setStatus(200);
		return;
	}else{
		System.out.println(" deleteCustomerAccount 실패");
		response.setStatus(400);
		return;
	}
}

%>
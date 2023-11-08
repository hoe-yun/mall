<%@page import="vo.CustomerDomain"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//작성자 정인호
//Api 요청 Controller

request.setCharacterEncoding("utf-8");
String customerRequestTitle = request.getParameter("customerRequestTitle");
String referer = request.getHeader("Referer");
CustomerDao dao = new CustomerDao();

/** 세션 회원만 접근가능 **/
//로그인세션 확인은 필터로 이관;
Integer customerNo = (int)session.getAttribute("customerNo");// 세션정보 확인
System.out.println(" 로그인 세션 customerNo   ::  " + customerNo);
//요청 제목이 없는 경우 리턴
if(customerRequestTitle == null ){
	response.sendRedirect(referer);
	return;
}

//로그아웃
if(customerRequestTitle.equals("logout")){
	session.removeAttribute("customerNo");
	System.out.println(" logout 성공");
	response.sendRedirect(referer);
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
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int customerNo = (int)session.getAttribute("customerNo");// 세션정보 확인

CustomerDao dao = new CustomerDao();

//Api Controller 요청타입을 처리함
String customerRequestTitle = request.getParameter("customerRequestTitle");

if(customerRequestTitle == null){
	return;
}
//고객정보 업데이트
if(customerRequestTitle.equals("updateUserInfo")){
	int validation = dao.updateCustomerInfo(customerNo, request.getParameter("newCustomerName"), request.getParameter("newCustomerPhone"));
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
	int validation = dao.deleteCustomerAddr(Integer.parseInt(request.getParameter("addressNo")));
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
	int validation = dao.updateCustomerAddr(Integer.parseInt(request.getParameter("addressNo")), request.getParameter("newAddress"));
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
		session.removeAttribute("cutomerNo");
		response.setStatus(200);
		return;
	}else{
		System.out.println(" deleteCustomerAccount 실패");
		response.setStatus(400);
		return;
	}
}
%>
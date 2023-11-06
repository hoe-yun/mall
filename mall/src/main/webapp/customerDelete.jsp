<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% // 작성자 : 정인호 
	// 회원탈퇴 진행
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	String currentPw = request.getParameter("currentPw");
	
	CustomerDao dao = new CustomerDao();
	int validation = dao.deleteCustomer(customerNo, currentPw);
	
	if(validation == 1){
		System.out.println(" updateCustomerPw 성공");
		response.setStatus(200);
	}else{
		System.out.println(" updateCustomerPw 실패");
		response.setStatus(400);
	}
	return;
%>
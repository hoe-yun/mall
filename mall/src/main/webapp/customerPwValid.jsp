<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% // 작성자 : 정인호 
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	String currentPw = request.getParameter("currentPw");
	String newPw = request.getParameter("newPw");
	
	CustomerDao dao = new CustomerDao();
	int validation = dao.vaildateUpdatePw(customerNo, currentPw, newPw);
	
	if(validation == 1){
		System.out.println(" updateCustomerPw 성공");
		response.setStatus(200);
	}else{
		System.out.println(" updateCustomerPw 실패"); // 비밀번호가 이전에 사용되었음
		response.setStatus(400);
	}
	return;
%>
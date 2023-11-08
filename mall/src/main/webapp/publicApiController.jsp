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
//요청 제목이 없는 경우 리턴
if(customerRequestTitle == null ){
	String referer = request.getHeader("Referer");
	response.sendRedirect(referer);
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

%>
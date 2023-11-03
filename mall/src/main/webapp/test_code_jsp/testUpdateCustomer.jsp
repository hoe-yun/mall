<%@page import="vo.Customer"%>
<%@page import="vo.CustomerPwHistory"%>
<%@page import="dto.RetrieveCustomerAllInfoDto"%>
<%@page import="vo.CustomerAddr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//비밀번호 변경 테스트
CustomerDao dao = new CustomerDao();

Customer c = new Customer();

	c.setCustomerPw("1234");
	c.setCustomerNo(1);
	c.setActive("Y");

	int result = dao.updateCustomer(c);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%=result %>

</body>
</html>
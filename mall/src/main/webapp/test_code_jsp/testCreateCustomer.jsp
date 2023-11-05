<%@page import="vo.CustomerDomain.CreateCustomerVo"%>
<%@page import="vo.CustomerDomain"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
CustomerDomain.CreateCustomerVo vo = new CreateCustomerVo("tt", "1234", "n33me", "p23423e", "ad32dr");


CustomerDao dao = new CustomerDao();

int genCusNo = dao.createCumstomer(vo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%=genCusNo%>
</body>
</html>
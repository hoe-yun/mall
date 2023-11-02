<%@page import="dao.CustomerDao"%>
<%@page import="vo.CreateCustomerVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
CreateCustomerVo createCustomerVo = new CreateCustomerVo();

createCustomerVo.setCustomerId("testId");
createCustomerVo.setCustomerPw("1234");
createCustomerVo.setAddress("testadrr");
createCustomerVo.setCustomerName("testName");
createCustomerVo.setCustomerPhone("010-1234-1234");

CustomerDao customerDao = new CustomerDao();

customerDao.createCumstomer(createCustomerVo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
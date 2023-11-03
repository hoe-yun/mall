<%@page import="dto.CreateCustomerDto"%>
<%@page import="vo.Customer"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
CreateCustomerDto dto = new CreateCustomerDto();




dto.setId("testId");
dto.setPw("1234");
dto.setName("testName");
dto.setPhone("010-1234-1234");
dto.setAddr("testadrr");

CustomerDao customerDao = new CustomerDao();

int genCusNo = customerDao.createCumstomer(dto);

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
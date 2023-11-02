<%@page import="vo.CustomerAddr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.RetrieveCumstomerInfoVo"%>
<%@page import="dao.CustomerDao"%>
<%@page import="vo.CreateCustomerVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

CustomerDao customerDao = new CustomerDao();

 RetrieveCumstomerInfoVo retrieveCumstomerVo = customerDao.retrieveCumstomerInfo(1);
 ArrayList<CustomerAddr> addrList = customerDao.retrieveCumstomerAddr(1);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	out.print(retrieveCumstomerVo.getCustomerId());
	out.print(retrieveCumstomerVo.getCustomerName());
	out.print(retrieveCumstomerVo.getCustomerPhone());

%>
	<br>
<%
 for( CustomerAddr s : addrList){
	 out.print(s.getCustomerAddrNo() + s.getAddress());
 }
%>

</body>
</html>
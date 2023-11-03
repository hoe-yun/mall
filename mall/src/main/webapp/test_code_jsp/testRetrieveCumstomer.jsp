<%@page import="vo.CustomerPwHistory"%>
<%@page import="dto.RetrieveCustomerAllInfoDto"%>
<%@page import="vo.CustomerAddr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

CustomerDao customerDao = new CustomerDao();
RetrieveCustomerAllInfoDto dto = customerDao.retrieveCustomerAllInfoByCusNo(1);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=dto.getCustomerNo()%>
	<br>
<%=dto.getCustomerId()%>
	<br>
<%=dto.getCustomerPw()%>
	<br>
<%=dto.getCreatedateCustomer()%>
	<br>
<%=dto.getUpdatedateCustomer() %>
	<br>
<%=dto.getActive()%>
	<br>
<%=dto.getCustomerName()%>
	<br>
<%=dto.getCustomerPhone()%>
	<br>
<%=dto.getCreatedateCustomerDetail()%>
	<br>
<%=dto.getUpdatedateCustomerDetail() %>
	<br>
<%=dto.getCustomerAddrList()%>
	<br>
<%=dto.getCustomerPwHistoryList()%>
	<br>
<%
	for(CustomerAddr ca : dto.getCustomerAddrList()){
		out.print(ca.getCustomerAddrNo()+" "+ca.getCustomerNo()+" "+ca.getAddress()+" "+ca.getCreatedate()+" "+ca.getUpdatedate()+"<br>");
		
	}
%>

<%
	for(CustomerPwHistory ca : dto.getCustomerPwHistoryList()){
		out.print(ca.getCustomerPwHistoryNo()+" "+ca.getCustomerNo()+" "+ca.getCustomerPw()+" "+ca.getCreatedate()+"<br>");
		
	}
%>
	

</body>
</html>
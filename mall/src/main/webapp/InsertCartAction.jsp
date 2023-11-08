<%@page import="dao.ProductCartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	Integer customerNo = (int)session.getAttribute("customerNo");// 세션에서 고객번호 확인
	ProductCartDao dao = new ProductCartDao();
	dao.selectCart(goodsNo);
	dao.insertCart(customerNo, goodsNo, quantity);

	response.sendRedirect("./productCart.jsp");
	%>
</body>
</html>
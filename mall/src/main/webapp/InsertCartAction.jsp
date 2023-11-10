<%@page import="dao.ProductCartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
	<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	ProductCartDao dao1 = new ProductCartDao();
	dao1.selectCart(goodsNo);
	if(dao1.selectCart(goodsNo) != null){
		
	}
	
	
	
	
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	Integer customerNo = (int)session.getAttribute("customerNo");// 세션에서 고객번호 확인
	ProductCartDao dao = new ProductCartDao();
	dao.selectCart(goodsNo);
	dao.insertCart(customerNo, goodsNo, quantity);

	response.sendRedirect("./productCart.jsp");
	%>

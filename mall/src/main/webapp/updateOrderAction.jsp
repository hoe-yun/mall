<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String orderStatus = request.getParameter("orderStatus");
	
	Orders o = new Orders();
	o.setOrdersNo(orderNo);
	o.setOrdersState(orderStatus);
	
	OrderDao oDao = new OrderDao();
	oDao.updateOrder(o);
	
	response.sendRedirect("./managementOrderList.jsp");
%>
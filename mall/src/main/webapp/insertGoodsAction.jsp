<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	String soldout = request.getParameter("soldout");
	String goodsMemo = request.getParameter("goodsMemo");
	
	Goods g = new Goods();
	g.setGoodsTitle(goodsTitle);
	g.setGoodsPrice(goodsPrice);
	g.setSoldout(soldout);
	g.setGoodsMemo(goodsMemo);
	
	GoodsDao gDao = new GoodsDao();
	gDao.insertGoods(g);
	
	response.sendRedirect("goodsManagementList.jsp");
	
%>
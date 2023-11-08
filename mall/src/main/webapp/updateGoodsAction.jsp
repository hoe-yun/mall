<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	String soldout = request.getParameter("soldout");
	String goodsMemo = request.getParameter("goodsMemo");
	
	Goods g = new Goods();
	g.setGoodsNo(goodsNo);
	g.setGoodsTitle(goodsTitle);
	g.setGoodsPrice(goodsPrice);
	g.setSoldout(soldout);
	g.setGoodsMemo(goodsMemo);
	
	GoodsDao gDao = new GoodsDao();
	gDao.updateGoods(g);
	
	response.sendRedirect("goodsManagementList.jsp");
%>
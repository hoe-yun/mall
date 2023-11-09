<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

	GoodsImgDao iDao = new GoodsImgDao();
	iDao.deleteGoodsImg(goodsNo);
	
	response.sendRedirect("deleteGoodsAction.jsp?goodsNo="+goodsNo);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	request.setCharacterEncoding("utf-8");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String filename = request.getParameter("filename");
	String originName = request.getParameter("originName");
	String contentType = request.getParameter("contentType");
	
	
	GoodsDao gdao = new GoodsDao();
	Goods g = gdao.goodsOne(goodsNo);
	
	GoodsImg img = new GoodsImg();
	img.setGoodsNo(g.getGoodsNo());
	img.setFilename(filename);
	img.setOriginName(originName);
	img.setContentType(contentType);
	
	GoodsImgDao iDao = new GoodsImgDao();
	iDao.insertGoodsImg(img);
	
	response.sendRedirect("goodsManagementList.jsp");
	
%>
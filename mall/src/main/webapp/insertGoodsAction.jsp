<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%
	String uploadPath = request.getServletContext().getRealPath("/img/product");
	MultipartRequest req = new MultipartRequest(request, uploadPath, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
	
	String goodsTitle = req.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(req.getParameter("goodsPrice"));
	String soldout = req.getParameter("soldout");
	String goodsMemo = req.getParameter("goodsMemo");
	
	String filename = req.getFilesystemName("goodsImg");	
	String originName = req.getOriginalFileName("goodsImg");	
	String contentType = req.getContentType("goodsImg");
	
	Goods g = new Goods();
	g.setGoodsTitle(goodsTitle);
	g.setGoodsPrice(goodsPrice);
	g.setSoldout(soldout);
	g.setGoodsMemo(goodsMemo);
	
	GoodsDao gDao = new GoodsDao();
	gDao.insertGoods(g);
	Goods go = gDao.goodsNoOne(goodsTitle);
	
	int goodsNo = go.getGoodsNo();
	
	GoodsDao gdao = new GoodsDao();
	
	GoodsImg img = new GoodsImg();
	img.setGoodsNo(goodsNo);
	img.setFilename(filename);
	img.setOriginName(originName);
	img.setContentType(contentType);
	
	GoodsImgDao iDao = new GoodsImgDao();
	iDao.insertGoodsImg(img);
	
	response.sendRedirect("goodsManagementList.jsp");
	
%>
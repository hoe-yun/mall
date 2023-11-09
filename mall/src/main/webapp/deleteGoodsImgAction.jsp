<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.io.File"%>
<%
	String imgPath = request.getServletContext().getRealPath("/img/product");	// img/product 폴더 경로 


	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

	GoodsImgDao iDao = new GoodsImgDao();
	GoodsImg img = iDao.selectGoodsImg(goodsNo);	// img 삭제를 위한 filename 출력
	
	File f = new File(imgPath + "/" + img.getFilename());	// img폴더에 filename의 img 지정
	f.delete();	// 삭제
	
	iDao.deleteGoodsImg(goodsNo);
	
	
	
	response.sendRedirect("deleteGoodsAction.jsp?goodsNo="+goodsNo);
%>
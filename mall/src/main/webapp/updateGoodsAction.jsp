<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.io.File" %>
<%
	String uploadPath = request.getServletContext().getRealPath("/img/product");
	MultipartRequest req = new MultipartRequest(request, uploadPath, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
	
	int goodsNo = Integer.parseInt(req.getParameter("goodsNo"));
	String goodsTitle = req.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(req.getParameter("goodsPrice"));
	String soldout = req.getParameter("soldout");
	String goodsMemo = req.getParameter("goodsMemo");
	
	Goods g = new Goods();
	g.setGoodsNo(goodsNo);
	g.setGoodsTitle(goodsTitle);
	g.setGoodsPrice(goodsPrice);
	g.setSoldout(soldout);
	g.setGoodsMemo(goodsMemo);
	
	GoodsDao gDao = new GoodsDao();
	gDao.updateGoods(g);
	
	String filename = req.getFilesystemName("goodsImg");	
	String originName = req.getOriginalFileName("goodsImg");	
	String contentType = req.getContentType("goodsImg");
	
	GoodsImgDao iDao = new GoodsImgDao();
	GoodsImg img = new GoodsImg();
	GoodsImg i = iDao.selectGoodsImg(goodsNo);
	
	if(filename != null){	// 파일이 넘어오면 if문 실행
		File f = new File(uploadPath + "/" + i.getFilename());	
		f.delete();		// 기존 파일 삭제
		
		img.setFilename(filename);
		img.setOriginName(originName);
		img.setContentType(contentType);
		img.setGoodsNo(goodsNo);
		
		iDao.updateGoodsImg(img);	//새로운 파일로 update
	}
	response.sendRedirect("goodsManagementList.jsp");
%>
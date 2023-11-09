<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="dao.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String reviewContent = request.getParameter("reviewContent");	


	Review review = new Review();
	review.setOrdersNo(ordersNo);
	review.setReviewContent(reviewContent);
	
	ReviewDao reviewDao = new ReviewDao();
	reviewDao.insertReview(ordersNo, reviewContent);
	
	
	response.sendRedirect("./reviewList.jsp");




%>
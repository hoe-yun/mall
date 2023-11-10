<%@page import="dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	ReviewDao reviewDao = new ReviewDao();
	reviewDao.deleteReview(reviewNo);
	
	response.sendRedirect("./reviewList.jsp");


%>
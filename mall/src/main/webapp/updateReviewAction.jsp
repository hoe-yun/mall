<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.Review" %>
<%@ page import="dao.ReviewDao" %>



<%
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	String reviewContent = request.getParameter("reviewContent");
	
	Review review = new Review();
	review.setReviewNo(reviewNo);
	review.setReviewContent(reviewContent);
	
	ReviewDao reviewDao = new ReviewDao();
	int row = reviewDao.updateReview(review);
	
	response.sendRedirect("reviewOne.jsp?reviewNo="+reviewNo );



%>

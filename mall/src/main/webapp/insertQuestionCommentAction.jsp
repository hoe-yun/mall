<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	int managerNo = 1;
	String comment = request.getParameter("comment");
	
	QuestionComment qc = new QuestionComment();
	qc.setQuestionNo(questionNo);
	qc.setManagerNo(managerNo);
	qc.setComment(comment);
	
	QuestionCommentDao qcDao = new QuestionCommentDao();
	qcDao.insertQuestionComment(qc);
	
	response.sendRedirect("questionOne.jsp?questionNo="+questionNo);
%>
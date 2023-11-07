<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	int questionCommentNo = Integer.parseInt(request.getParameter("questionCommentNo"));
	int managerNo = 1;
	String comment = request.getParameter("comment");
	
	QuestionComment qc = new QuestionComment();
	
	qc.setQuestionCommentNo(questionCommentNo);
	qc.setManagerNo(managerNo);
	qc.setComment(comment);
	
	QuestionCommentDao qcDao = new QuestionCommentDao();
	qcDao.updateQuestionComment(qc);
	
	QuestionComment qc2 = qcDao.updateQuestionCommentOne(questionCommentNo);
	
	response.sendRedirect("questionOne.jsp?questionNo="+qc2.getQuestionNo());
%>
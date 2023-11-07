<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
int questionCommentNo = Integer.parseInt(request.getParameter("questionCommentNo"));
	QuestionCommentDao qcDao = new QuestionCommentDao();
	QuestionComment qc = qcDao.updateQuestionCommentOne(questionCommentNo);
	
	qcDao.deleteQuestionComment(questionCommentNo);
	
	response.sendRedirect("questionOne.jsp?questionNo="+qc.getQuestionNo());
%>
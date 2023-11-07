<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	String questionTitle = request.getParameter("questionTitle");
	String questionContent = request.getParameter("questionContent");
	
	Question q = new Question();
	
	q.setQuestionNo(questionNo);
	q.setQuestionTitle(questionTitle);
	q.setQuestionContent(questionContent);
	
	QuestionDao qDao = new QuestionDao();
	qDao.updateQuestion(q);
	
	response.sendRedirect("questionOne.jsp?questionNo="+questionNo);
%>


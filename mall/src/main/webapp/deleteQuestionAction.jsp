<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	QuestionDao qDao = new QuestionDao();
	Question q = qDao.questionOne(questionNo);
	
	qDao.deleteQuestion(questionNo);
	
	response.sendRedirect("productDetail.jsp?goodsNo="+q.getGoodsNo());
%>
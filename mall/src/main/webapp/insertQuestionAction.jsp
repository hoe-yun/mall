<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int customerNo = 1; // 추후 세션에 저장된 customerNo로 수정
	String questionTitle = request.getParameter("questionTitle");
	String questionContent = request.getParameter("questionContent");
	
	Question q = new Question();
	q.setGoodsNo(goodsNo);
	q.setCustomerNo(customerNo);
	q.setQuestionTitle(questionTitle);
	q.setQuestionContent(questionContent);
	
	QuestionDao qDao = new QuestionDao();
	int row = qDao.insertQuestion(q);
	
	response.sendRedirect("productDetail.jsp?goodsNo="+goodsNo);
%>
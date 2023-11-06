<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.Nostice" %>
<%@ page import="dao.NoticeDao" %>
<%
	int managerNo= 1;
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	Nostice notice = new Nostice();
	notice.setManagerNo(managerNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.insertNotice(notice);
	
	response.sendRedirect("noticeList.jsp");
	
%>
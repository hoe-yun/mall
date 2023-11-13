<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	String managerPw = request.getParameter("managerPw");
	String newManagerPw = request.getParameter("newManagerPw");
	System.out.println(request.getParameter("managerPw")+"<-emanagerPw");
	System.out.println(managerPw+"<-managerPw");
	System.out.println(newManagerPw+"<-newManagerPw");
	ManagerDao mDao = new ManagerDao();
	int row = mDao.managerPw(managerPw, newManagerPw);
	
	if(row == 1){
		mDao.managerPwHistory(newManagerPw);
		response.sendRedirect("./managerOne.jsp");
	}else{
		String msg = URLEncoder.encode("현재 비밀번호가 틀렸습니다.");
		response.sendRedirect("./managerPw.jsp?msg="+msg);
	}
%>
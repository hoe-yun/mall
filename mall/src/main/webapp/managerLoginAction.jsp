<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	ManagerDao mDao = new ManagerDao();
	int row = mDao.managerLogin(id, pw);
	System.out.println(row + "<--managerNo");
	
	if(row != 0){
		session.setAttribute("managerNo",row);
		System.out.println(session.getAttribute("managerNo") + "<--session");
		response.sendRedirect("./managerOne.jsp");
	}else{
		String msg = "x";
		response.sendRedirect("./managerLogin.jsp?msg="+msg);
	}
%>
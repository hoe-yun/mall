<%@page import="dao.ProductCartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
    int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    Integer customerNo = (Integer) session.getAttribute("customerNo"); // 세션에서 고객번호 확인
    System.out.println("CustomerNo: " + customerNo); //Integer로 반환되는지 확인 
    ProductCartDao dao = new ProductCartDao();
    int cartQuantity = dao.selectCart(goodsNo, customerNo);
    System.out.println("Cart Quantity: " + cartQuantity);

    if (cartQuantity != 0){
        	dao.updateCart(goodsNo, quantity, customerNo);
        } else {
            dao.insertCart(customerNo, goodsNo, quantity);
        }
    

    response.sendRedirect("./productCart.jsp");
%>
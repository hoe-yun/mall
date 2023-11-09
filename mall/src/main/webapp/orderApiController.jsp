<%@page import="vo.OrderCreateVo"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="dao.CustomerDao"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.TransferCartToOrderVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

//1. get <goodsNo , quantity > List From Cart;
//2. retrieve goods price from db using with goodsNo;
//3. get session customerNo And retrieve customerDetail, address;
//4. make view with vlues gotten;
//5. $post and dao transaction init;
request.setCharacterEncoding("utf-8");
String customerRequestTitle = request.getParameter("customerRequestTitle");
Integer customerNo = (int)session.getAttribute("customerNo");// 세션정보 확인
String referer = request.getHeader("Referer");

//요청 제목이 없는 경우 리턴
if(customerRequestTitle == null ){
	response.sendRedirect(referer);
	return;
}

OrderDao orderDao = new OrderDao();
CustomerDao customerDao = new CustomerDao();

//장바구니를 주문서로 옮기는 경우 사용
if(customerRequestTitle.equals("transferCartToOrder")){
	ArrayList<TransferCartToOrderVo> transferList = new ArrayList<>();
	request.getParameterMap().forEach((K, V) -> { System.out.println(K + " : " + V[0]); });
	request.getParameterMap().forEach((K, V) -> { 
		System.out.println(K.equals("customerRequestTitle"));
		if(K.equals("customerRequestTitle")){
			return;
		}
		TransferCartToOrderVo vo = new TransferCartToOrderVo();
		vo.setGoodsNo(Integer.parseInt(K));
		vo.setQuantity(Integer.parseInt(V[0]));
		transferList.add(vo);
		});
	for(TransferCartToOrderVo vo : transferList){
		System.out.println(vo.getGoodsNo());
	}
	orderDao.transferCartToOrder(transferList);
	for(TransferCartToOrderVo vo : transferList){
		System.out.println(vo.getGoodsPrice());
	}
	request.setAttribute("TransferCartToOrderVoList", transferList);
	request.getRequestDispatcher("orderCreate.jsp").forward(request, response);
}
//주문을 만들때 사용
if(customerRequestTitle.equals("createOrder")){
	
	ArrayList<OrderCreateVo> voList = new ArrayList<>();
	String[] goodNos = request.getParameterMap().get("goodNos[]");
	String[] quantitys = request.getParameterMap().get("quantitys[]");
	String[] totalPrices = request.getParameterMap().get("totalPrices[]");
	int customerAddressNo = Integer.parseInt(request.getParameter("CustomerAdrressNo"));
	
	for(int i = 0; i < goodNos.length; i++){
		OrderCreateVo vo = new OrderCreateVo();
		vo.setCustomerNo(customerNo);
		vo.setCustomerAddressNo(customerAddressNo);
		vo.setGoodNo(Integer.parseInt(goodNos[i]));
		vo.setQuantity(Integer.parseInt(quantitys[i]));
		vo.setTotalPrice(Integer.parseInt(totalPrices[i]));
		voList.add(vo);
	}
	
	for(OrderCreateVo vo : voList){
		System.out.println(vo.toString());
	}
	
	request.getParameterMap().forEach((K, V) -> { System.out.println(K + " : " + V[0]); });
	request.getParameterMap().forEach((K, V) -> { 
		System.out.print(K);
		for(int i = 0; i < V.length; i++){
			System.out.print(V[i]);
		}
		System.out.println("");
		});
	
	int validation = orderDao.CreateOrder(voList);
	if(validation == 1){
		System.out.println(" createOrder 성공");
		response.setStatus(200);
		return;
	}else{
		System.out.println(" createOrder 실패");
		response.setStatus(400);
		return;
	}
};

%>
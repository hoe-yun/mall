<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="../orderApiController.jsp" method="post">
	<!-- for문 시작점-->
		<input hidden="true" readonly="readonly" name="customerRequestTitle" value="transferCartToOrder">
		<input name="1" value="2"> <!-- name ="상품번호" -->
		<input name="2" value="1"> <!-- name ="상품번호" -->
		<input name="3" value="4"> <!-- name ="상품번호" -->
		<button type="submit">주문전송</button>
	<!-- for문 종료 -->
	</form>

</body>
</html>
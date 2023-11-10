package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import vo.OrderCreateVo;
import vo.TransferCartToOrderVo;
import vo.Orders;

//작성자 : 정인호 
// order 처리용 DAO
public class OrderDao {
	//db접근용 데이터
	final String url;
	final String dbuser;
	final String dbpw;
	
	//생성자
	public OrderDao() throws ClassNotFoundException {
		this.url = "jdbc:mariadb://192.168.200.36:3306/mall";
		this.dbuser = "user";
		this.dbpw = "java1234";
		Class.forName("org.mariadb.jdbc.Driver");
	}
	
	//장바구니를 주문서로 옮김
	public int transferCartToOrder(ArrayList<TransferCartToOrderVo> voList) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "SELECT goods_price goodsPrice, goods_title goodsTitle, filename FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_no  = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		for(TransferCartToOrderVo vo : voList) {
			stmt.setInt(1, vo.getGoodsNo());
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				vo.setGoodsPrice(rs.getInt("goodsPrice"));	
				vo.setGoodsTitle(rs.getString("goodsTitle"));
				vo.setFilename(rs.getString("filename"));
			}else {
				return 0;
			}
			rs.close();
		}
		stmt.close();
		conn.close();
		return 1;
	}
	
	//고객이 주문할 때 사용
	public int CreateOrder(ArrayList<OrderCreateVo> voList) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		String sql1 = """
				INSERT INTO orders(customer_no, customer_addr_no, goods_no, quantity, total_price, orders_state,createdate,updatedate)
				VALUES(?,?,?,?,?,'주문완료',NOW(), NOW())""";
		String sql2 = "DELETE FROM cart WHERE customer_no = ? AND goods_no = ? AND quantity = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		
		int validation = 1;
		
		for(OrderCreateVo vo : voList) {
			stmt1.setInt(1, vo.getCustomerNo());
			stmt1.setInt(2, vo.getCustomerAddressNo());
			stmt1.setInt(3, vo.getGoodNo());
			stmt1.setInt(4, vo.getQuantity());
			stmt1.setInt(5, vo.getTotalPrice());
			System.out.println(" stmt --> " + stmt1);
			validation *= stmt1.executeUpdate();
			stmt2.setInt(1, vo.getCustomerNo());
			stmt2.setInt(2, vo.getGoodNo());
			stmt2.setInt(3, vo.getQuantity());
			validation *= stmt2.executeUpdate();
			System.out.println(" stmt --> " + stmt2);
		}
		stmt1.close();
		stmt2.close();
		if (validation == 1) {
			conn.commit();
			conn.close();
			return 1;
		}else {
			conn.rollback();
			conn.close();
			return 0;
		}
	}
	
	//고객이 주문리스트를 확인할 때 사용
	public ArrayList<HashMap<String, Object>> retrieveOrderList(int customerNo) throws SQLException{
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = """
				SELECT o.orders_no orderNo, g.goods_title goodTitle, g.goods_price goodPrice, quantity, total_price totalPrice, orders_state orderStatus, o.createdate createdate, ca.address address
				 FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no inner join customer_addr ca ON o.customer_addr_no = ca.customer_addr_no
				 WHERE o.customer_no = ? ORDER BY o.createdate DESC""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		System.out.println(" stmt --> " + stmt);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>> orderList = new ArrayList<>();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("orderNo", rs.getInt("orderNo"));
			map.put("goodTitle", rs.getString("goodTitle"));
			map.put("goodPrice", rs.getInt("goodPrice"));
			map.put("quantity", rs.getInt("quantity"));
			map.put("totalPrice", rs.getInt("totalPrice"));
			map.put("orderStatus", rs.getString("orderStatus"));
			map.put("createdate", rs.getString("createdate"));
			map.put("address", rs.getString("address"));
			orderList.add(map);
		}
		rs.close();
		stmt.close();
		conn.close();		
		return orderList;
	}
	public ArrayList<HashMap<String, Object>> managementOrderList(int managerNo) throws SQLException{
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = """
				SELECT o.orders_no orderNo, o.goods_no goodsNo, g.goods_title goodTitle, g.goods_price goodPrice, quantity, total_price totalPrice, orders_state orderStatus, o.createdate createdate, ca.address address
				 FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no inner join customer_addr ca ON o.customer_addr_no = ca.customer_addr_no
				 ORDER BY o.createdate DESC""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>> orderList = new ArrayList<>();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("orderNo", rs.getInt("orderNo"));
			map.put("goodsNo", rs.getInt("goodsNo"));
			map.put("goodTitle", rs.getString("goodTitle"));
			map.put("goodPrice", rs.getInt("goodPrice"));
			map.put("quantity", rs.getInt("quantity"));
			map.put("totalPrice", rs.getInt("totalPrice"));
			map.put("orderStatus", rs.getString("orderStatus"));
			map.put("createdate", rs.getString("createdate"));
			map.put("address", rs.getString("address"));
			orderList.add(map);
		}
		rs.close();
		stmt.close();
		conn.close();		
		return orderList;
	}

	public int updateOrder(Orders orders) throws SQLException{
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql="UPDATE orders SET orders_state = ? WHERE orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,orders.getOrdersState() );
		stmt.setInt(2, orders.getOrdersNo());
		int row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
	
}


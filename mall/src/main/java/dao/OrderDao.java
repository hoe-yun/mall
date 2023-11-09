package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.OrderCreateVo;
import vo.TransferCartToOrderVo;

//작성자 : 정인호 
// order처리용 DAO
public class OrderDao {
	//db접근용 데이터
	final String url;
	final String dbuser;
	final String dbpw;
	
	//생성자
	public OrderDao() throws ClassNotFoundException {
		this.url = "jdbc:mariadb://localhost:3306/mall";
		this.dbuser = "root";
		this.dbpw = "java1234";
		Class.forName("org.mariadb.jdbc.Driver");
	}
	
	//장바구니를 주문서로 옮김
	public int transferCartToOrder(ArrayList<TransferCartToOrderVo> voList) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "SELECT goods_price goodsPrice, goods_title goodsTitle FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		for(TransferCartToOrderVo vo : voList) {
			stmt.setInt(1, vo.getGoodsNo());
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				vo.setGoodsPrice(rs.getInt("goodsPrice"));	
				vo.setGoodsTitle(rs.getString("goodsTitle"));
			}else {
				return 0;
			}
			rs.close();
		}
		stmt.close();
		conn.close();
		return 1;
	}
	//주문을 시도할 때 사용
	public int CreateOrder(ArrayList<OrderCreateVo> voList) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		String sql1 = """
				INSERT INTO orders(customer_no, customer_addr_no, goods_no, quantity, total_price, orders_state,createdate,updatedate)
				VALUES(?,?,?,?,?,'주문완료',NOW(), NOW())""";
		String sql2 = "DELETE FROM cart WHERE customer_no = ? AND goods_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		
		int validation = 1;
		
		for(OrderCreateVo vo : voList) {
			stmt1.setInt(1, vo.getCustomerNo());
			stmt1.setInt(2, vo.getCustomerAddressNo());
			stmt1.setInt(3, vo.getGoodNo());
			stmt1.setInt(4, vo.getQuantity());
			stmt1.setInt(5, vo.getTotalPrice());
			validation *= stmt1.executeUpdate();
			stmt2.setInt(1, vo.getCustomerNo());
			stmt2.setInt(2, vo.getGoodNo());
			validation *= stmt2.executeUpdate();
		}
		stmt1.close();
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
}

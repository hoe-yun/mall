package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.OrderCreateVo;
import vo.TransferCartToOrderVo;

//정인호 order처리용 DAO
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
	
	//장바구니를 주문서로 옮길 때 사용
	public ArrayList<TransferCartToOrderVo> transferCartToOrder(ArrayList<TransferCartToOrderVo> voList) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "SELECT goods_price goodsPrice, goods_title goodsTitle FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		voList.forEach((vo) -> {
			try {
				stmt.setInt(1, vo.getGoodsNo());
				ResultSet rs = stmt.executeQuery();
				if(rs.next()) {	
					vo.setGoodsPrice(rs.getInt("goodsPrice"));	}
					vo.setGoodsTitle(rs.getString("goodsTitle"));
				rs.close();
			} catch (SQLException e) {e.printStackTrace();}
		});
		
		stmt.close();
		conn.close();
		return voList;
	}
	//주문완료할 때 사용
	public int CreateOrder(ArrayList<OrderCreateVo> voList) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		String sql = """
				INSERT INTO orders(customer_no, customer_addr_no, goods_no, quantity, total_price, orders_state,createdate,updatedate)
				VALUES(?,?,?,?,?,'주문완료',NOW(), NOW())""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		int validation = 1;
		
		for(OrderCreateVo vo : voList) {
			stmt.setInt(1, vo.getCustomerNo());
			stmt.setInt(2, vo.getCustomerAddressNo());
			stmt.setInt(3, vo.getGoodNo());
			stmt.setInt(4, vo.getQuantity());
			stmt.setInt(5, vo.getTotalPrice());
			validation *= stmt.executeUpdate();
		}
		stmt.close();
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

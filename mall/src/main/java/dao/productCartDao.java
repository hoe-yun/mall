package dao;
import java.util.ArrayList;

import vo.Cart;
import vo.Goods;
import vo.Customer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class productCartDao {
	public ArrayList<Cart> selectArrayList(String goodsTitle, int goodsPrice, int goodsNo, int quantity, int cartNo) throws Exception {
		
	ArrayList<Cart> list = new ArrayList<>();
	
	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/mall";
	String dbuser = "root";
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	//상품명,가격,솔드아웃여부,메모 쿼리문
	String sql = "SELECT g.goods_title goodsTitle, g.goods_price goodsPrice, ca.cart_no cartNo, ca.soldout, g.goods_no goodsNo, ca.quantity, c.customer_no customerNo ca.createdate, ca.updatedate FROM cart ca inner join goods g on ca.goods_no = g.goods_no inner join customer c on ca.customer_no = c.customer_no";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	list = new ArrayList<>();
	while(rs.next()) {
	Cart c = new Cart();
	c.setGoodsNo(rs.getInt("goodsNo"));
	c.setQuantity(rs.getInt("quantity"));
	c.setCartNo(rs.getInt("cartNo"));
	c.setGoodsTitle(rs.getString("goodsTitle"));
	c.setGoodsPrice(rs.getInt("goodsPrice"));
	c.setGoodsMemo(rs.getString("goodsMemo"));
	list.add(c);
	
	//DB자원반납
	stmt.close();
	conn.close();
	
	}
	return list; 
  }	
}

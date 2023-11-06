package dao;
import java.util.ArrayList;

import javax.servlet.ServletRequest;

import vo.ProductCart;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProductCartDao {
	public ArrayList<ProductCart> selectArrayList(String goodsTitle, int goodsPrice, int goodsNo, int quantity, int cartNo) throws Exception {
		
	ArrayList<ProductCart> list = new ArrayList<>();
	
	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/mall";
	String dbuser = "root";
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	//상품명,가격,솔드아웃여부,메모 쿼리문
	String sql = "SELECT g.goods_title AS goodsTitle, g.goods_price AS goodsPrice, ca.cart_no cartNo, ca.soldout, g.goods_no goodsNo, ca.quantity, c.customer_no customerNo ca.createdate, ca.updatedate FROM cart ca inner join goods g on ca.goods_no = g.goods_no inner join customer c on ca.customer_no = c.customer_no";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	//ResultSet로 가져온 데이터를 새로운 ProductCart ArrayList에 담기
	list = new ArrayList<>();
	while(rs.next()) {
	ProductCart c = new ProductCart();
	c.setGoodsNo(rs.getInt("goodsNo"));
	c.setQuantity(rs.getInt("quantity"));
	c.setCartNo(rs.getInt("cartNo"));
	c.setCustomerNo(rs.getInt("customerNo"));
	c.setGoodsTitle(rs.getString("goodsTitle"));
	c.setGoodsPrice(rs.getInt("goodsPrice"));
	c.setGoodsMemo(rs.getString("goodsMemo"));
	c.setSoldout(rs.getString("soldout"));
	list.add(c);
	
	//DB자원반납
	rs.close();
	stmt.close();
	conn.close();
	
	}
	return list; 
  }	
	public ProductCart selectProductDetail(String goodsTitle, int goodsPrice, int goodsNo) throws Exception {
		
		
		//DB연결
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		//상품 번호 별 상품명,가격,솔드아웃여부,메모 쿼리문
		
		String sql = "SELECT goods_no goodsNo, goods_title goodsTitle, goods_price goodsPrice, goods_memo goodsMemo, soldout FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		ResultSet rs = stmt.executeQuery();
		
		//DB에서 셀렉한 데이터를 새로운 객체에 저장
		ProductCart c = new ProductCart();
		while(rs.next()) {
		
		c.setGoodsNo(rs.getInt("goodsNo"));
		c.setGoodsTitle(rs.getString("goodsTitle"));
		c.setGoodsPrice(rs.getInt("goodsPrice"));
		c.setGoodsMemo(rs.getString("goodsMemo"));
		c.setSoldout(rs.getString("soldout"));
		
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		
		}
		return c; 
	  }	
}


package dao;

import java.util.ArrayList;

import vo.Goods;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class productCartDao {
	public ArrayList<productCart> selectArrayList(String goodsTitle, int goodsPrice) throws Exception {
		
	ArrayList<productCart> list = new ArrayList<>();
	
	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/mall";
	String dbuser = "root";
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	//상품명,가격,솔드아웃여부,메모 쿼리문
	String sql = "SELECT goods_no goodsNo, goods_title goodsTitle, goods_Price goodsPrice, soldout, goods_memo goodsMemo FROM goods";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	list = new ArrayList<>();
	while(rs.next()) {
	productCart c = new productCart();
	c.setGoodsNo(rs.getInt("goodsNo"));
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

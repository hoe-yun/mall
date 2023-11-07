package dao;
import java.util.ArrayList;
import vo.Goods;
import java.sql.*;
public class GoodsDao {
	public ArrayList<Goods> selectArrayList(String goodsTitle, int goodsPrice) throws Exception {
		
	ArrayList<Goods> list = new ArrayList<>();
	
	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/mall";
	String dbuser = "root";
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	//상품명,가격,솔드아웃여부,메모 쿼리문
	String sql = "SELECT goods_no goodsNo, goods_title goodsTitle, goods_Price goodsPrice, soldout, goods_memo goodsMemo, soldout FROM goods";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	list = new ArrayList<>();
	while(rs.next()) {
	Goods g = new Goods();
	g.setGoodsNo(rs.getInt("goodsNo"));
	g.setGoodsTitle(rs.getString("goodsTitle"));
	g.setGoodsPrice(rs.getInt("goodsPrice"));
	g.setGoodsMemo(rs.getString("goodsMemo"));
	g.setSoldout(rs.getString("soldout"));
	list.add(g);
	
	//DB자원반납
	stmt.close();
	conn.close();
	
	}
	return list; 
  }	
}
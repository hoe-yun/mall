package dao;
import java.util.ArrayList;
import vo.Goods;
import java.sql.*;
public class GoodsDao {
	public ArrayList<Goods> selectArrayList(String goodsTitle, int goodsPrice) throws Exception {
		
	ArrayList<Goods> list = new ArrayList<>();
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/mall";
	String dbuser = "root";
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	String sql = "SELECT goods_no goodNo, goods_title goodsTitle, goods_Price goodsPrice, soldout, goods_memo goodsMemo FROM goods";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	list = new ArrayList<>();
	while(rs.next()) {
	Goods g = new Goods();
	g.setGoodsTitle(rs.getString("goodsTitle"));
	g.setGoodsPrice(rs.getInt("goodsPrice"));
	list.add(g);
	
	}
	return list;
  }	
}

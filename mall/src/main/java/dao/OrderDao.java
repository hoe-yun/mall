package dao;

import java.sql.*;
import java.util.ArrayList;

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
}

package dao;

import java.sql.*;
import vo.*;

public class GoodsImgDao {
	//controller : insertGoodsImgAction.jsp
	public int insertGoodsImg(GoodsImg img) throws Exception{
		int row = 0;
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "INSERT INTO goods_img (goods_no,filename,origin_name,content_type,createdate,updatedate) VALUES(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, img.getGoodsNo());
		stmt.setString(2, img.getFilename());
		stmt.setString(3, img.getOriginName());
		stmt.setString(4, img.getContentType());
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
	//controller : deleteGoodsImgAction.jsp
	public int deleteGoodsImg(int goodsNo) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// goods 삭제를 위한 DELETE QUERY
		String sql ="DELETE FROM goods_img WHERE goods_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		System.out.println(stmt + "<- stmt delectTest()");
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
	//controller
	public GoodsImg selectGoodsImg(int goodsNo) throws Exception{
		GoodsImg gi = new GoodsImg();
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// goodsImg 정보를 출력하기 위한 SELECT QUERY
		String sql="SELECT goods_no goodsNo, filename, origin_name originName, content_type contentType, createdate, updatedate FROM goods_img WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			gi.setGoodsNo(rs.getInt("goodsNo"));
			gi.setFilename(rs.getString("filename"));
			gi.setOriginName(rs.getString("originName"));
			gi.setContentType(rs.getString("contentType"));
			gi.setCreatedate(rs.getString("createdate"));
			gi.setUpdatedate(rs.getString("updatedate"));
		}
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		//end model code
		return gi;	
	}
}

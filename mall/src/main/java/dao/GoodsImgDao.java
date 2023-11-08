package dao;

import java.sql.*;
import vo.*;

public class GoodsImgDao {
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
}

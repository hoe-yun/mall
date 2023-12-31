package dao;

import java.sql.*;
import vo.*;

public class GoodsImgDao {
	//db접근용 데이터
	final String url;
	final String dbuser;
	final String dbpw;
	
	//생성자
	public GoodsImgDao() throws ClassNotFoundException {
		this.url = "jdbc:mariadb://192.168.200.36:3306/mall";
		this.dbuser = "user";
		this.dbpw = "java1234";
		Class.forName("org.mariadb.jdbc.Driver");
	}
	//controller : insertGoodsImgAction.jsp
	public int insertGoodsImg(GoodsImg img) throws Exception{
		int row = 0;
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
	public int updateGoodsImg(GoodsImg img)throws Exception {
		int row = 0;
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// 상품이미지 수정을 위한 UPDATE QUERY
		String sql = "UPDATE goods_img SET filename = ?, origin_name = ?, content_type = ?, updatedate = NOW() WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,img.getFilename());
		stmt.setString(2,img.getOriginName());
		stmt.setString(3,img.getContentType());
		stmt.setInt(4,img.getGoodsNo());
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
}

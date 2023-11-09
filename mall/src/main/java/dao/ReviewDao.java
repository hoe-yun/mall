package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class ReviewDao {
	public ArrayList<HashMap<String,Object>> selectReview(int ordersNo) throws Exception{
		ArrayList<HashMap<String,Object>> rlist = new ArrayList<>();
		
		//모델코드
		//DB연결
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		//쿼리문 작성
		String sql ="SELECT o.orders_no ordersNo, r.review_no reviewNo, r.review_content reviewContent, r.createdate, r.updatedate FROM review r INNER JOIN orders o ON r.oders_no = o.orders_no WHERE= orders_no=? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		ResultSet rs = stmt.executeQuery();
		rlist = new ArrayList<>();
		
		while(rs.next()) {
		HashMap<String,Object> r = new HashMap<String,Object>();
		
		r.put("reviewNo", rs.getInt("reviewNo"));
		r.put("ordersNo", rs.getInt("ordersNo"));
		r.put("reviewContent", rs.getString("reviewContent"));
		r.put("reviewContent", rs.getString("reviewContent"));
		r.put("createdate", rs.getString("createdate"));
		r.put("updatedate", rs.getString("updatedate"));
		rlist.add(r);
		}
			//DB자원반납
				rs.close();
				stmt.close();
				conn.close();
			//모델코드 끝
				return rlist;
	}
}
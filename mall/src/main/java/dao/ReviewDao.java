package dao;
import java.sql.*;
import java.util.*;
import vo.*;

public class ReviewDao {
	public ArrayList<Review> selectReviewList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Review> list = new ArrayList<>();
		
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// noticeList 출력을 위한 review DB SELECT QUERY
		String sql = "SELECT review_no reviewNo, orders_no ordersNo, review_content reviewContent, createdate, updatedate FROM review order by review_no DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,beginRow);
		stmt.setInt(2,rowPerPage);
		ResultSet rs = stmt.executeQuery();
		list = new ArrayList<>();
		while(rs.next()){
			Review r = new Review();
			r.setReviewNo(rs.getInt("ReviewNo"));
			r.setOrdersNo(rs.getInt("ordersNo"));
			r.setReviewContent(rs.getString("reviewContent"));
			r.setCreatedate(rs.getString("createdate"));
			r.setUpdatedate(rs.getString("updatedate"));
			list.add(r);
		}
		//end model code : model date >> ArrayList<Nostice> list
		stmt.close();
		conn.close();
		rs.close();
		return list;
	}
	public Review reviewOne(int reviewNo) throws Exception{
		Review r = new Review();
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// review 정보를 출력하기 위한 SELECT QUERY
		String sql = "SELECT r.review_no reviewNo, o.orders_no ordersNo, r.review_content reviewContent,r.createdate,r.updatedate FROM review r INNER JOIN orders o ON r.orders_no = o.orders_no WHERE review_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, reviewNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			r = new Review();
			r.setReviewNo(rs.getInt("reviewNo"));
			r.setOrdersNo(rs.getInt("ordersNo"));
			r.setReviewContent(rs.getString("reviewContent"));
			r.setCreatedate(rs.getString("createdate"));
			r.setUpdatedate(rs.getString("updatedate"));
			
		}
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		//end model code
		return r;
	}
		
		public int insertReview(int ordersNo,String reviewContent) throws Exception{
			int row = 0;
			//모델코드
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall";
			String dbuser = "root";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			//리뷰 추가를 위한 쿼리문
			String sql = "INSERT INTO review(orders_no,review_content,createdate,updatedate) VALUES(?, ?, NOW(),NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ordersNo);
			stmt.setString(2, reviewContent);
			row = stmt.executeUpdate();
			//DB자원반납
			stmt.close();
			conn.close();
			//end model code
			return row;
			
		}
}
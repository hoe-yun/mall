package dao;
import java.sql.*;
import java.util.*;
import vo.*;

public class ReviewDao {
	public ArrayList<HashMap<String, Object>> selectReviewList(int beginRow, int rowPerPage) throws Exception{
		
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://192.168.200.36:3306/mall";
		String dbuser = "user";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// reviewList 출력을 위한 review DB SELECT QUERY
		String sql = "SELECT i.filename AS filename, i.goods_no AS goodsNo, r.review_no AS reviewNo, o.orders_no AS ordersNo, r.review_content AS reviewContent, r.createdate, r.updatedate FROM review r INNER JOIN orders o ON r.orders_no = o.orders_no INNER JOIN goods_img i ON o.goods_no = i.goods_no ORDER BY review_no DESC LIMIT ?,?;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,beginRow);
		stmt.setInt(2,rowPerPage);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<>();
		while(rs.next()){
			HashMap<String, Object> map = new HashMap<>();
			map.put("goodsNo", rs.getInt("goodsNo"));
			map.put("reviewNo", rs.getInt("reviewNo"));
			map.put("ordersNo", rs.getString("ordersNo"));
			map.put("reviewContent", rs.getString("reviewContent"));
			map.put("updatedate", rs.getString("updatedate"));
			map.put("createdate", rs.getString("createdate"));
			map.put("filename", rs.getString("filename"));
			reviewList.add(map);
		}
		//end model code : model date >> ArrayList<Nostice> list
		stmt.close();
		conn.close();
		rs.close();
		return reviewList;
	}
	public Review reviewOne(int reviewNo) throws Exception{
		Review r = new Review();
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://192.168.200.36:3306/mall";
		String dbuser = "user";
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
			String url = "jdbc:mariadb://192.168.200.36:3306/mall";
			String dbuser = "user";
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
			//모델코드 끝
			return row;
			
		}
		
		public int deleteReview(int reviewNo) throws Exception{
			int row = 0;
			//모델코드
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://192.168.200.36:3306/mall";
			String dbuser = "user";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			//리뷰 삭제를 위한 쿼리문
			String sql = "DELETE FROM review WHERE review_no=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, reviewNo);
			row = stmt.executeUpdate();
			//DB자원 반납
			stmt.close();
			conn.close();
			//모델코드 끝
			return row;
		}
		public Review reviewDetail(int goodsNo) throws Exception{
			Review review = new Review();
			//모델코드 시작 DB연결
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://192.168.200.36:3306/mall";
			String dbuser = "user";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			//상품번호에 맞는 리뷰를 출력하기위한 쿼리문
			String sql = "SELECT r.review_no reviewNo, r.review_content reviewContent, r.createdate, r.updatedate, o.orders_no ordersNo FROM review r inner join orders o on r.orders_no = o.orders_no LEFT OUTER JOIN goods g ON o.goods_no = g.goods_no WHERE o.goods_no=?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
			review.setReviewNo(rs.getInt("reviewNo"));
			review.setReviewContent(rs.getString("reviewContent"));
			review.setCreatedate(rs.getString("createdate"));
			review.setUpdatedate(rs.getString("updatedate"));
			
			}
			//DB자원 반납
			stmt.close();
			conn.close();
			//모델코드 끝
			return review;
		}
		
		public int updateReview(Review review) throws Exception{
			int row = 0;
			//모델코드
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://192.168.200.36:3306/mall";
			String dbuser = "user";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			//리뷰 삭제를 위한 쿼리문
			String sql = "UPDATE review SET review_content = ?, updatedate = NOW() WHERE review_no= ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, review.getReviewContent());
			stmt.setInt(2, review.getReviewNo());
			row = stmt.executeUpdate();
			//DB자원 반납
			stmt.close();
			conn.close();
			//모델코드 끝
			return row;
		}
		
}
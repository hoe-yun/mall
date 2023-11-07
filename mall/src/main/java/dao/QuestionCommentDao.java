package dao;
import java.sql.*;
import vo.*;
public class QuestionCommentDao {
	//controller : productDetail.jsp
	public QuestionComment questionCommentOne(int questionNo) throws Exception{
		QuestionComment qc = new QuestionComment();
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
		String sql = "SELECT question_comment_no questionCommentNo, question_no questionNo, manager_no managerNo, comment,createdate,updatedate FROM question_comment WHERE question_no =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			qc.setQuestionCommentNo(rs.getInt("questionCommentNo"));
			qc.setQuestionNo(rs.getInt("questionNo"));
			qc.setManagerNo(rs.getInt("managerNo"));
			qc.setComment(rs.getString("comment"));
			qc.setCreatedate(rs.getString("createdate"));
			qc.setUpdatedate(rs.getString("updatedate"));
		}
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		//end model code
		return qc;
	}
	//controller : productDetail.jsp
		public QuestionComment updateQuestionCommentOne(int questionCommentNo) throws Exception{
			QuestionComment qc = new QuestionComment();
			// model code
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall";
			String dbuser = "root";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
			String sql = "SELECT question_comment_no questionCommentNo, question_no questionNo, manager_no managerNo, comment,createdate,updatedate FROM question_comment WHERE question_comment_no =?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, questionCommentNo);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				qc.setQuestionCommentNo(rs.getInt("questionCommentNo"));
				qc.setQuestionNo(rs.getInt("questionNo"));
				qc.setManagerNo(rs.getInt("managerNo"));
				qc.setComment(rs.getString("comment"));
				qc.setCreatedate(rs.getString("createdate"));
				qc.setUpdatedate(rs.getString("updatedate"));
			}
			//DB자원반납
			rs.close();
			stmt.close();
			conn.close();
			//end model code
			return qc;
		}
	//controller : insertQuestionCommentAction.jsp
	public int insertQuestionComment(QuestionComment comment) throws Exception{
		int row = 0;
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// comment 추가를 위한 INSERT QUERY
		String sql = "INSERT INTO question_comment(question_no,manager_no,comment,createdate,updatedate)VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,comment.getQuestionNo());
		stmt.setInt(2,comment.getManagerNo());
		stmt.setString(3,comment.getComment());
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
	//controller : deleteQuestionCommentAction.jsp
	public int deleteQuestionComment(int questionCommentNo) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// comment 삭제를 위한 DELETE QUERY
		String sql = "DELETE FROM question_comment WHERE question_comment_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionCommentNo);
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
	//controller : updateQuestionCommentAction.jsp
	public int updateQuestionComment(QuestionComment comment) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// comment 수정을 위한 UPDATE QUERY
		String sql = "UPDATE question_comment SET comment = ?, updatedate = NOW() WHERE question_comment_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, comment.getComment());
		stmt.setInt(2, comment.getQuestionCommentNo());
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
}

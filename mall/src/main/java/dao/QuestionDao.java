package dao;
import java.sql.*;
import vo.*; 

public class QuestionDao {
	//controller : productDetail.jsp , updateQuestionForm.jsp
	public Question questionOne(int goodsNo) throws Exception{
		Question q = new Question();
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		//question 정보 출력을 위한 SELETE QUERY
		String sql ="SELECT question_no questionNo, goods_no goodsNo, customer_no customerNo, question_title questionTitle, question_content questionContent,createdate,updatedate FROM question WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			q.setQuestionNo(rs.getInt("questionNo"));
			q.setGoodsNo(rs.getInt("goodsNo"));
			q.setCustomerNo(rs.getInt("customerNo"));
			q.setQuestionTitle(rs.getString("questionTitle"));
			q.setQuestionContent(rs.getString("questionContent"));
			q.setCreatedate(rs.getString("createdate"));
			q.setUpdatedate(rs.getString("updatedate"));
		}
		//end model code
		return q;
	}
	//controller : insertQuestionAction.jsp
	public int insertQuestion(Question question) throws Exception{
		int row = 0;
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		//question 추가를 위한 INSERT QUERY
		String sql = "INSERT INTO question(goods_no,customer_no,question_title,question_content,createdate,updatedate) VALUES(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,question.getGoodsNo());
		stmt.setInt(2,question.getCustomerNo());
		stmt.setString(3,question.getQuestionTitle());
		stmt.setString(4,question.getQuestionContent());
		row = stmt.executeUpdate();
		//end model code
		return row;
	}
	//controller : deleteQuestionAction.jsp
	public int deleteQuestion(int questionNo) throws Exception{
		int row = 0;
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// question 삭제를 위한 DELETE QUERY
		String sql = "DELETE FROM question WHERE question_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionNo);
		row = stmt.executeUpdate();
		//end model code
		return row;
	}
	//controller : updateQuestionAction.jsp
	public int updateQuestion(Question question)throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// question 수정을 위한 UPDATE QUERY
		String sql = "UPDATE question SET question_title = ?, question_content = ?, updatedate = NOW() WHERE question_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,question.getQuestionTitle());
		stmt.setString(2,question.getQuestionContent());
		stmt.setInt(3,question.getQuestionNo());
		row = stmt.executeUpdate();
		//end model code
		return row;
	}
}

package dao;
import java.sql.*;
import java.util.*;
import vo.*; 

public class QuestionDao {
	// controller : productDetail.jsp
	public ArrayList<HashMap<String,Object>> selectQuestion(int goodsNo) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		//question 및 questionComment 정보 출력을 위한 SELETE QUERY
		String sql ="SELECT q.question_no questionNo, q.goods_no goodsNo, q.customer_no customerNo, q.question_title questionTitle, q.question_content questionContent, qc.comment comment,q.createdate qCreatedate, q.updatedate qUpdatedate,qc.createdate qcCreatedate, qc.updatedate qcUpdatedate FROM question q INNER JOIN question_comment qc ON q.question_no = qc.question_no WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		ResultSet rs = stmt.executeQuery();
		list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> q = new HashMap<String,Object>();
			q.put("questionNo",rs.getInt("questionNo"));
			q.put("goodsNo",rs.getInt("goodsNo"));
			q.put("customerNo",rs.getInt("customerNo"));
			q.put("questionTitle",rs.getString("questionTitle"));
			q.put("questionContent",rs.getString("questionContent"));
			q.put("comment",rs.getString("comment"));
			q.put("qCreatedate",rs.getString("qCreatedate"));
			q.put("qUpdatedate",rs.getString("qUpdatedate"));
			q.put("qcCreatedate",rs.getString("qcCreatedate"));
			q.put("qcUpdatedate",rs.getString("qcUpdatedate"));
			list.add(q);
		}
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		//end model code
		return list;
	}
	//controller : updateQuestionForm.jsp
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
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
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
		//DB자원반납
		stmt.close();
		conn.close();
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
		//DB자원반납
		stmt.close();
		conn.close();
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
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
}

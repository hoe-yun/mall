package dao;

import java.sql.*;


public class ManagerDao {
	//db접근용 데이터
		final String url;
		final String dbuser;
		final String dbpw;
		
	//생성자
	public ManagerDao() throws ClassNotFoundException {
		this.url = "jdbc:mariadb://192.168.200.36:3306/mall";
		this.dbuser = "user";
		this.dbpw = "java1234";
		Class.forName("org.mariadb.jdbc.Driver");
	}
	public int managerLogin(String id,String pw) throws Exception{
		
		// model code
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// 매니저 정보를 출력하기 위한 SELECT QUERY
		String sql= "SELECT manager_no managerNo FROM manager WHERE manager_id = ? AND manager_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		int managerNo = 0;
		if(rs.next()) {
			managerNo = rs.getInt("managerNo");
		}
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		//end model code
		return managerNo;
	}
	public int managerPw(int managerPw,int newManagerPw) throws Exception{
		int row = 0;
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "UPDATE manager SET manager_pw = PASSWORD(?) WHERE manager_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, newManagerPw);
		stmt.setInt(2, managerPw);
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
	public int managerPwHistory(int newManagerPw) throws Exception{
		int row = 0;
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "INSERT INTO manager_pw_history (manager_no,manager_pw,createdate) VALUES (1,PASSWORD(?),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, newManagerPw);
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
}

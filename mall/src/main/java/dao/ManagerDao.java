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
}

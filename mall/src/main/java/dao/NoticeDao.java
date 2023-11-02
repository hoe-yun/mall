package dao;
import java.sql.*;
import java.util.*;
import vo.*;

public class NoticeDao {
	// controller : noticeList.jsp
	public ArrayList<Nostice> selectNoticeList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Nostice> list = new ArrayList<>();
		
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
		String sql = "SELECT notice_no noticeNo, manager_no managerNo, notice_title noticeTitle, notice_content noticeContent,createdate,updatedate FROM nostice LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,beginRow);
		stmt.setInt(2,rowPerPage);
		ResultSet rs = stmt.executeQuery();
		list = new ArrayList<>();
		while(rs.next()){
			Nostice n = new Nostice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setManagerNo(rs.getInt("managerNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setCreatedate(rs.getString("createdate"));
			n.setUpdatedate(rs.getString("updatedate"));
			list.add(n);
		}
		//end model code : model date >> ArrayList<Nostice> list
		return list;
	}
	//controller : insertNoticeAction.jsp
	public int insertNotice(Nostice notice) throws Exception{
		int row = 0;
		//model code
		// model code
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "INSERT INTO nostice(manager_no,notice_title,notice_content,createdate,updatedate) VALUES (?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,notice.getManagerNo());
		stmt.setString(2, notice.getNoticeTitle());
		stmt.setString(3, notice.getNoticeContent());
		row = stmt.executeUpdate();
		//end model code
		return row;
	}
}

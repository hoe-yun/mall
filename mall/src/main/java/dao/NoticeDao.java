package dao;
import java.sql.*;
import java.util.*;
import vo.*;

public class NoticeDao {
	//db접근용 데이터
	final String url;
	final String dbuser;
	final String dbpw;
	
	//생성자
	public NoticeDao() throws ClassNotFoundException {
		this.url = "jdbc:mariadb://192.168.200.36:3306/mall";
		this.dbuser = "user";
		this.dbpw = "java1234";
		Class.forName("org.mariadb.jdbc.Driver");
	}
	// controller : noticeList.jsp
	public ArrayList<Nostice> selectNoticeList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Nostice> list = new ArrayList<>();
		
		// model code
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// noticeList 출력을 위한 nostice DB SELECT QUERY
		String sql = "SELECT notice_no noticeNo, manager_no managerNo, notice_title noticeTitle, notice_content noticeContent,createdate,updatedate FROM nostice order by notice_no DESC LIMIT ?,?";
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
	//controller : noticeOne.jsp, updateNoticeForm.jsp
	public Nostice noticeOne(int noticeNo) throws Exception{
		Nostice n = new Nostice();
		// model code
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// notice 정보를 출력하기 위한 SELECT QUERY
		String sql = "SELECT notice_no noticeNo, manager_no managerNo, notice_title noticeTitle, notice_content noticeContent,createdate,updatedate FROM nostice WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			n = new Nostice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setManagerNo(rs.getInt("managerNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setCreatedate(rs.getString("createdate"));
			n.setUpdatedate(rs.getString("updatedate"));
			
		}
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		//end model code
		return n;
	}
	//controller : insertNoticeAction.jsp
	public int insertNotice(Nostice notice) throws Exception{
		int row = 0;
		// model code
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// notice 추가를 위한 INSERT QUERY
		String sql = "INSERT INTO nostice(manager_no,notice_title,notice_content,createdate,updatedate) VALUES (?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,notice.getManagerNo());
		stmt.setString(2, notice.getNoticeTitle());
		stmt.setString(3, notice.getNoticeContent());
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
	//controller : delectNoticeAction.jsp
	public int deleteNotice(int noticeNo) throws Exception {
		int row = 0;
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// notice 삭제를 위한 DELETE QUERY
		String sql ="DELETE FROM nostice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println(stmt + "<- stmt delectTest()");
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
	//controller : updateNoticeAction.jsp
	public int updateNotice(Nostice notice)throws Exception {
		int row = 0;
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// notice 수정을 위한 UPDATE QUERY
		String sql = "UPDATE nostice SET notice_title = ?, notice_content = ?, updatedate = NOW() WHERE notice_no =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
}	

package dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import dto.CreateCustomerDto;
import dto.RetrieveCustomerAllInfoDto;
import dto.UpdateCumtomerDto;
import vo.Customer;
import vo.CustomerAddr;
import vo.CustomerDetail;
import vo.CustomerDomain;
import vo.CustomerDomain.CreateCustomerVo;
import vo.CustomerPwHistory;

//customer 기본키 엔터티의 DAO
//작성자 정인호
public class CustomerDao {
	//db접근용 데이터
	final String url;
	final String dbuser;
	final String dbpw;
	
	//생성자
	public CustomerDao() throws ClassNotFoundException {
		this.url = "jdbc:mariadb://localhost:3306/mall";
		this.dbuser = "root";
		this.dbpw = "java1234";
		Class.forName("org.mariadb.jdbc.Driver");
	}
	
	//고객 회원가입 
	public int createCumstomer(CreateCustomerVo vo) throws SQLException, ClassNotFoundException{
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		/*아이디 중복확인*/
		String dupCheck = "SELECT COUNT(*) FROM customer WHERE customer_id = ?";
		PreparedStatement dstmt = conn.prepareStatement(dupCheck);
		dstmt.setString(1, vo.getId());
		System.out.println(" dstmt --> " + dstmt);
		ResultSet drs = dstmt.executeQuery();
		int duplId = -1;
		if(drs.next()) {
			duplId = drs.getInt(1);
		}
		drs.close();
		dstmt.close();
		if(duplId != 0) {
			return 0;
		}
		//중복 확인 통과 -- insert 진행
		ArrayList<PreparedStatement> stmtList = vo.getStmtList(conn);
		
		int updateCheck = 0;
		int genCustomerNo = -1;
		PreparedStatement stmt = stmtList.get(0);
		System.out.println(" stmt --> " + stmt);
		updateCheck = stmt.executeUpdate();
		ResultSet rs = stmt.getGeneratedKeys();
		rs.next();
		genCustomerNo = rs.getInt(1); // 기본키 엔티티의 PK 생성
		rs.close();
		stmt.close();
		stmtList.remove(0);
		
		while(!stmtList.isEmpty()) { // customerNo를 입력하고 나머지 stmt 진행
			stmt = stmtList.get(0);
			stmt.setInt(1,genCustomerNo);
			System.out.println(" stmt --> " + stmt);
			updateCheck *= stmt.executeUpdate();
			stmt.close();
			stmtList.remove(0);
		}
		
		if (updateCheck != 1) { // 밸리데이션
			conn.rollback();
			conn.close();
			System.out.println("conn.rollback()");
			return 0;
		}else {
			conn.commit();
			conn.close();
			System.out.println("conn.commit()");
			return genCustomerNo;
		}
	}
	
	// 고객 정보 조회
	public HashMap<String, Object> retrieveCustomerInfo(int customerNo) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = """
					SELECT c.customer_id customerId, cd.customer_name customerName, cd.customer_phone customerPhone, c.createdate createdate FROM customer c INNER JOIN customer_detail cd ON c.customer_no = cd.customer_no 
					 WHERE c.customer_no = ?;""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		ResultSet rs = stmt.executeQuery();
		HashMap<String, Object> map = new HashMap<>();
		if(rs.next()) {
			map.put("customerId", rs.getString("customerId"));
			map.put("customerName", rs.getString("customerName"));
			map.put("customerPhone", rs.getString("customerPhone"));
			map.put("createdate", rs.getString("createdate"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return map;
	}
	
	// 고객 주소리스트 조회
	public ArrayList<HashMap<String, Object>> retrieveCustomerAddrList(int customerNo) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = """
					 SELECT customer_addr_no addrNo, address, updatedate FROM customer_addr
					  WHERE customer_no = ?;""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("addrNo", rs.getInt("addrNo"));
			map.put("address", rs.getString("address"));
			map.put("updatedate", rs.getString("updatedate"));
			list.add(map);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	//고객 정보 업데이트
	public int updateCustomerInfo(int customerNo, String customerName, String CustomerPhone) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = """
					UPDATE customer_detail SET customer_name = ?, customer_phone = ? WHERE customer_no = ?""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerName);
		stmt.setString(2, CustomerPhone);
		stmt.setInt(3, customerNo);
		int updateCheck = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return updateCheck;
	}
	
	//고객 주소 1개 제거
	public int deleteCustomerAddr(int AddrNo) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = """
					DELETE FROM customer_addr WHERE customer_addr_no = ?""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, AddrNo);
		int updateCheck = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return updateCheck;
	}
	
	//고객 주소 1개 생성
	public int createCustomerAddr(int customerNo) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = """
					INSERT INTO customer_addr(customer_no, address, createdate, updatedate)
					 VALUES(?,'',NOW(),NOW())""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		int updateCheck = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return updateCheck;
	}
	
	//고객 주소 1개 수정
	public int updateCustomerAddr(int addrNo, String newAddr) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = """
					UPDATE customer_addr SET address = ?, updatedate = NOW() WHERE customer_addr_no = ?""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newAddr);
		stmt.setInt(2, addrNo);
		System.out.println(" stmt --> " + stmt);
		int updateCheck = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return updateCheck;
	}
	
	//고객 패스워드체크 후 패스워드 업데이트
	public int vaildateUpdatePw(int customerNo, String currentPw, String newPw) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = """
					SELECT COUNT(*) validate FROM customer c INNER JOIN customer_pw_history ch ON c.customer_no = ch.customer_no 
					 WHERE c.customer_no = ? AND c.customer_pw = PASSWORD(?) AND (ch.customer_pw = PASSWORD(?) OR ch.customer_pw = PASSWORD(?))""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		stmt.setString(2, currentPw);
		stmt.setString(3, currentPw);
		stmt.setString(4, newPw);
		System.out.println(" stmt --> " + stmt);
		ResultSet rs = stmt.executeQuery();
		//현재비밀번호 및 이전 비밀번호 중복 체크를 수행
		int validate = 0;
		if(rs.next()) {
			validate = rs.getInt(1);
		}
		if(validate == 1) {
			//doing upadate pw
			System.out.println(" vaildateUpdatePw 성공");
			rs.close();
			stmt.close();
			conn.setAutoCommit(false);
			sql = "UPDATE customer SET customer_pw = PASSWORD(?) WHERE customer_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, newPw);
			stmt.setInt(2,customerNo);
			validate *= stmt.executeUpdate();
			
			sql = "INSERT INTO customer_pw_history(customer_no, customer_pw, createdate)values(?,PASSWORD(?), NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1,customerNo);
			stmt.setString(2, newPw);
			validate *= stmt.executeUpdate();			
		}else {
			//validation fail
			System.out.println(" vaildateUpdatePw 실패");
			rs.close();
			stmt.close();
			conn.close();
			return 0; // 비밀번호 중복
		}
		if (validate == 1) {
			//validation& update ok
			conn.commit();
			stmt.close();
			conn.close();
			return 1;
		}else {
			//update fail
			conn.rollback();
			stmt.close();
			conn.close();
			return 0; // 
		}
	}
	
	//고객 로그인
	public int loginCustomer(String id, String pw) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = """
					SELECT customer_no customerNo FROM customer WHERE customer_id = ? AND customer_pw = PASSWORD(?) AND active ='Y'""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		System.out.println(" stmt --> " + stmt);
		ResultSet rs = stmt.executeQuery();
		int customerNo = -1;
		if(rs.next()) {
			customerNo = rs.getInt("customerNo");
		}
		return customerNo;
		
	}
	
	//회원탈퇴 
	public int deleteCustomer(int customerNo, String customerPw) throws SQLException {
		String sql = """
				SELECT COUNT(*) validate FROM customer WHERE customer_no = ? AND customer_pw = PASSWORD(?)""";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		stmt.setString(2, customerPw);
		System.out.println(" stmt --> " + stmt);
		ResultSet rs = stmt.executeQuery();
		int validate = -1;
		if(rs.next()) {
			validate = rs.getInt(1);
		}
		if(validate == 1) {
			conn.setAutoCommit(false);
			sql = """
				UPDATE customer SET active = 'N' WHERE customer_no = ?""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, customerNo);
			System.out.println(" stmt --> " + stmt);
			validate *= stmt.executeUpdate(); //active를 N으로 변경
		}else {
			rs.close();
			stmt.close();
			conn.close();
			return 0;
		}
		
		if (validate == 1) {
			//validation& update ok
			conn.commit();
			stmt.close();
			conn.close();
			return 1;
		}else {
			//update fail
			conn.rollback();
			stmt.close();
			conn.close();
			return 0;
		}
	}
}

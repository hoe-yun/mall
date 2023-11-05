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
import vo.UpdateCumstomerAddrVo;
import vo.UpdateCumstomerInfoVo;

//customer 도메인의 DAO
//정인호
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
		/*get connection*/
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		ArrayList<PreparedStatement> stmtList = vo.getStmtList(conn);
		
		int updateCheck = 0;
		int genCustomerNo = -1;
		PreparedStatement stmt = stmtList.get(0);
		System.out.println(" stmt --> " + stmt);
		updateCheck = stmt.executeUpdate();
		ResultSet rs = stmt.getGeneratedKeys();
		rs.next();
		genCustomerNo = rs.getInt(1);
		rs.close();
		stmt.close();
		stmtList.remove(0);
		
		while(!stmtList.isEmpty()) {
			stmt = stmtList.get(0);
			stmt.setInt(1,genCustomerNo);
			System.out.println(" stmt --> " + stmt);
			updateCheck *= stmt.executeUpdate();
			stmt.close();
			stmtList.remove(0);
		}
		
		if (updateCheck != 1) { 
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
		/*트랜젝션 종료*/
	}
	
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
	
	public int updateCustomerAddr(int addrNo, String newAddr) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = """
					UPDATE customer_addr SET address = ? WHERE customer_addr_no = ?""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newAddr);
		stmt.setInt(2, addrNo);
		int updateCheck = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return updateCheck;
	}
	
}

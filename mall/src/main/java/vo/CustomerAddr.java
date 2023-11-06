package vo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
//작성자 :정인호
public class CustomerAddr {
	private int customerAddrNo;
	private int customerNo;
	private String address;
	private String createdate;
	private String updatedate;
	
	/* preparestatement 생성 메소드*/
	
	/* creates ***/
	public PreparedStatement getStmtToCreate(Connection conn) throws SQLException {
		String sql = "INSERT INTO customer_addr(customer_no, address, createdate, updatedate) VALUES ( ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setInt(1, this.customerNo);
		stmt.setString(2, this.address);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	
	//@OVERLOADING getStmtToCreate 
	public PreparedStatement getStmtToCreate(Connection conn, int customerNo) throws SQLException {
		String sql = "INSERT INTO customer_addr(customer_no, address, createdate, updatedate) VALUES ( ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setInt(1, customerNo);
		stmt.setString(2, this.address);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	
	/* retrieves ***/
	public PreparedStatement getStmtToRetrieveByaddrNo(Connection conn, int customerAddrNo) throws SQLException {
		String sql = "SELECT customer_addr_no customerAddrNo, customer_no customerNo, address, createDate, updatedate FROM customer_addr WHERE customer_addr_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerAddrNo);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}	
	public PreparedStatement getStmtToRetrieveByCusNo(Connection conn, int customerNo) throws SQLException {
		String sql = "SELECT customer_addr_no customerAddrNo, customer_no customerNo, address, createDate, updatedate FROM customer_addr WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	
	/*updates */
	public PreparedStatement getStmtToUpdate(Connection conn) throws SQLException {
		String sql = "UPDATE customer_addr SET address = ?, updatedate = NOW() WHERE customer_addr_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, this.address);
		stmt.setInt(2, this.customerAddrNo);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	
	/*mapper*/
	
	public void map(ResultSet rs) throws SQLException {
		this.customerAddrNo = rs.getInt("customerAddrNo");
		this.customerNo = rs.getInt("customerNo");
		this.address = rs.getString("address");
		this.createdate = rs.getString("createdate");
		this.updatedate = rs.getString("updatedate");
	}
	
	/* getters and setters */	

	
	public int getCustomerAddrNo() {
		return customerAddrNo;
	}
	public void setCustomerAddrNo(int customerAddrNo) {
		this.customerAddrNo = customerAddrNo;
	}
	public int getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
}

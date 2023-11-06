package vo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
//작성자 정인호
public class CustomerDetail {
	private int customerNo; // pk
	private String customerName;
	private String customerPhone;
	private String createdate;
	private String updatedate;
	
	public CustomerDetail() {
	}
	
	public CustomerDetail(ResultSet rs) throws SQLException {
		this.customerNo = rs.getInt("customerNo");
		this.customerName = rs.getString("customerName");
		this.customerPhone = rs.getString("customerPhone");
		this.createdate = rs.getString("createdate");
		this.updatedate = rs.getString("updatedate");
	}
	

	
	/* preparestatement 생성 메소드*/	
	public PreparedStatement getStmtToCreate(Connection conn) throws SQLException {
		String sql = "INSERT INTO customer_detail(customer_no, customer_name, customer_phone, createdate, updatedate)VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setInt(1, this.customerNo);
		stmt.setString(2, this.customerName);
		stmt.setString(3, this.customerPhone);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	//@OVERLOADING getStmtToCreate 
	public PreparedStatement getStmtToCreate(Connection conn, int customerNo) throws SQLException {
		String sql = "INSERT INTO customer_detail(customer_no, customer_name, customer_phone, createdate, updatedate)VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setInt(1, customerNo);
		stmt.setString(2, this.customerName);
		stmt.setString(3, this.customerPhone);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	
	public PreparedStatement getStmtToRetrieve(Connection conn, int customerNo) throws SQLException {
		String sql = "SELECT customer_no customerNo, customer_name customerName, customer_phone customerPhone, createDate, updateDate FROM customer_detail WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	/*updates */
	public PreparedStatement getStmtToUpdate(Connection conn) throws SQLException {
		String sql = "UPDATE customer_detail SET customer_name = ?, customer_phone = ?, updatedate = NOW() WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, this.customerName);
		stmt.setString(2, this.customerPhone);
		stmt.setInt(3, this.customerNo);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	
	/* getters and setters */
	
	public int getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerPhone() {
		return customerPhone;
	}
	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
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

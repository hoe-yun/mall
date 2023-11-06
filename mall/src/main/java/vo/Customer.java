package vo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// 작성자 : 정인호
public class Customer {
	private int customerNo; //pk
	private String customerId;
	private String customerPw;
	private String createdate;
	private String updatedate;
	private String active;
	
	/* primary Constructor*/
	public Customer() {
		// TODO Auto-generated constructor stub
	}
	
	/* ResultSetConstructor*/
	public Customer(ResultSet rs) throws SQLException {
		this.customerNo = rs.getInt("customerNo");
		this.customerId = rs.getString("customerId");
		this.customerPw = rs.getString("customerPw");
		this.createdate = rs.getString("createdate");
		this.updatedate = rs.getString("updatedate");
		this.active = rs.getString("active");
	}
	
	/* preparestatement 생성 메소드*/
	/*create*/
	public PreparedStatement getStmtToCreate(Connection conn) throws SQLException {
		String sql = "INSERT INTO customer(customer_id, customer_pw, createdate, updatedate, ACTIVE)VALUES(?,PASSWORD(?),NOW(),NOW(),'Y')";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, this.customerId);
		stmt.setString(2, this.customerPw);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	/*retrieve*/
	public PreparedStatement getStmtToRetrieve(Connection conn, int customerNo) throws SQLException {
		String sql = "SELECT customer_no customerNo, customer_id customerId, customer_pw customerPw, createdate, updatedate, active 'active' FROM customer WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	/*update*/
	public PreparedStatement getStmtToUpdate(Connection conn) throws SQLException {
		String sql = "UPDATE customer SET customer_pw = PASSWORD(?), updatedate = NOW(), active = ? WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, this.customerPw);
		stmt.setString(2, this.active);
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
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getCustomerPw() {
		return customerPw;
	}
	public void setCustomerPw(String customerPw) {
		this.customerPw = customerPw;
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
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
}

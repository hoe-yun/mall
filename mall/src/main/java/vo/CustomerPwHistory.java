package vo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CustomerPwHistory {
	private int customerPwHistoryNo;
	private int customerNo;
	private String customerPw;
	private String createdate;
	

	/* preparestatement 생성 메소드*/	
	/* creates **/
	public PreparedStatement getStmtToCreate(Connection conn) throws SQLException {
		String sql = "INSERT INTO customer_pw_history(customer_no, customer_pw, createdate)VALUES( ?, PASSWORD(?), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setInt(1, this.customerNo);
		stmt.setString(2, this.customerPw);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	//@OVERLOADING getStmtToCreate 
	/*create*/
	public PreparedStatement getStmtToCreate(Connection conn, int CustomerNo) throws SQLException {
		String sql = "INSERT INTO customer_pw_history(customer_no, customer_pw, createdate)VALUES( ?, PASSWORD(?), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setInt(1, CustomerNo);
		stmt.setString(2, this.customerPw);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	
	/*retrieves**/
	public PreparedStatement getStmtToRetrieveByHisNo(Connection conn, int customerPwHistoryNo) throws SQLException {
		String sql = "SELECT customer_pw_history_no customerPwHistoryNo, customer_no customerNo, customer_pw customerPw, createdate FROM customer_pw_history WHERE customer_pw_history_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerPwHistoryNo);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	public PreparedStatement getStmtToRetrieveByCusNo(Connection conn, int customerNo) throws SQLException {
		String sql = "SELECT customer_pw_history_no customerPwHistoryNo, customer_no customerNo, customer_pw customerPw, createdate FROM customer_pw_history WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		System.out.println(" stmt --> " + stmt);
		
		return stmt;
	}
	
	/*updates - none*/

	
	/*mapper*/
	public void map(ResultSet rs) throws SQLException {
		this.customerPwHistoryNo = rs.getInt("customerPwHistoryNo");
		this.customerNo = rs.getInt("customerNo");
		this.customerPw = rs.getString("customerPw");
		this.createdate = rs.getString("createdate");
	}
	
	/*getter*/
	public int getCustomerPwHistoryNo() {
		return customerPwHistoryNo;
	}
	public void setCustomerPwHistoryNo(int customerPwHistoryNo) {
		this.customerPwHistoryNo = customerPwHistoryNo;
	}
	public int getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
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
}

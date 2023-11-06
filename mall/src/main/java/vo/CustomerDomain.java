package vo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
//작성자 : 정인호
public class CustomerDomain {
	
	/*회원가입용 VO 중첩정적클래스*/
	public static class CreateCustomerVo{
		private String id;
		private String pw;
		private String name;
		private String phone;
		private String addr;
		
		//생성자
		public CreateCustomerVo(String id, String pw, String name, String phone, String addr) {
			super();
			this.id = id;
			this.pw = pw;
			this.name = name;
			this.phone = phone;
			this.addr = addr;
		}
		
		//회원가입를 위한 stmtList생성메소드 
		public ArrayList<PreparedStatement> getStmtList(Connection conn) throws SQLException {
			ArrayList<PreparedStatement> stmtList = new ArrayList<>();
			
			String sql1 = """					
						INSERT INTO customer(customer_id, customer_pw, createdate, updatedate, ACTIVE)
						VALUES(?,PASSWORD(?),NOW(),NOW(),'Y')""";
			PreparedStatement stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
			stmt1.setString(1, this.id);
			stmt1.setString(2, this.pw);
			
			String sql2 = """
						INSERT INTO customer_detail(customer_no, customer_name, customer_phone, createdate, updatedate)
						VALUES(?, ?, ?, NOW(), NOW())""";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(2, this.name);
			stmt2.setString(3, this.phone);
			
			String sql3 = """
						INSERT INTO customer_addr(customer_no, address, createdate, updatedate)
						VALUES ( ?, ?, NOW(), NOW())""";
			PreparedStatement stmt3 = conn.prepareStatement(sql3);
			stmt3.setString(2, this.addr);
			
			String sql4 = """
						INSERT INTO customer_pw_history(customer_no, customer_pw, createdate)
						VALUES( ?, PASSWORD(?), NOW())""";
			PreparedStatement stmt4 = conn.prepareStatement(sql4);
			stmt4.setString(2, this.pw);
			
			stmtList.add(stmt1);
			stmtList.add(stmt2);
			stmtList.add(stmt3);
			stmtList.add(stmt4);
			
			return stmtList;
		}

		public String getId() {
			return id;
		}
	}
}

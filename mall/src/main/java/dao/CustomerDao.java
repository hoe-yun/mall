package dao;
import java.sql.*;
import java.util.ArrayList;
import vo.CreateCustomerVo;
import vo.CustomerAddr;
import vo.RetrieveCumstomerInfoVo;
import vo.UpdateCumstomerAddrVo;
import vo.UpdateCumstomerInfoVo;

//customer 도메인의 DAO
//정인호
public class CustomerDao {
	//db접근용 데이터
	final String url = "jdbc:mariadb://localhost:3306/mall";
	final String dbuser = "root";
	final String dbpw = "java1234";
	
	
	//회원가입 @table customer, customer_detail, customer_pw_history, customer_addr
	public void createCumstomer(CreateCustomerVo createCustomerVo) throws SQLException, ClassNotFoundException{
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		//인자가 빈 쿼리문 준비
		String sqlTableCustomer = "INSERT INTO customer(customer_id, customer_pw, createdate, updatedate, ACTIVE)VALUES(?,PASSWORD(?),NOW(),NOW(),'Y')";
		String sqlTableCustomerDetail = "INSERT INTO customer_detail(customer_no, customer_name, customer_phone, createdate, updatedate)VALUES(?, ?, ?, NOW(), NOW())";
		String sqlTableCustomerAddr = "INSERT INTO customer_addr(customer_no, address, createdate, updatedate) VALUES ( ?, ?, NOW(), NOW())";
		String sqlTableCustomerPwHistory = "INSERT INTO customer_pw_history(customer_no, customer_pw, createdate)VALUES( ?, PASSWORD(?), NOW())";
		
		//pstmt 준비
		PreparedStatement stmtTableCustomer = conn.prepareStatement(sqlTableCustomer, Statement.RETURN_GENERATED_KEYS);
		PreparedStatement stmtTableCustomerDetail = conn.prepareStatement(sqlTableCustomerDetail);
		PreparedStatement stmtTableCustomerAdrr = conn.prepareStatement(sqlTableCustomerAddr);
		PreparedStatement stmtTableCustomerPwHistory = conn.prepareStatement(sqlTableCustomerPwHistory);
		
		//기본키생성을 위한 psmt 인자 입력
		stmtTableCustomer.setString(1, createCustomerVo.getCustomerId());
		stmtTableCustomer.setString(2, createCustomerVo.getCustomerPw());
		System.out.println("createCumstomer :: stmt --> " + stmtTableCustomer);
		
		//결과 리턴 후 기본키 생성
		int querycheck1 = stmtTableCustomer.executeUpdate();
		ResultSet rsGeneratedKey = stmtTableCustomer.getGeneratedKeys();
		int generatedKey;
		rsGeneratedKey.next();
		generatedKey = rsGeneratedKey.getInt(1);
		
		//psmt 인자 입력
		stmtTableCustomerDetail.setInt(1, generatedKey);
		stmtTableCustomerDetail.setString(2, createCustomerVo.getCustomerName());
		stmtTableCustomerDetail.setString(3, createCustomerVo.getCustomerPhone());
		
		stmtTableCustomerAdrr.setInt(1, generatedKey);
		stmtTableCustomerAdrr.setString(2, createCustomerVo.getAddress());
		
		stmtTableCustomerPwHistory.setInt(1, generatedKey);
		stmtTableCustomerPwHistory.setString(2, createCustomerVo.getCustomerPw());
		
		//쿼리실행
		int querycheck2 = stmtTableCustomerDetail.executeUpdate();
		int querycheck3 = stmtTableCustomerAdrr.executeUpdate();
		int querycheck4 = stmtTableCustomerPwHistory.executeUpdate();
		
		//트랙젝션 종료
		if(querycheck1*querycheck2*querycheck3*querycheck4 == 1) {
			System.out.println("createCumstomer 성공");
			conn.commit();
		}else {
			conn.rollback();
		}
		// return DB resource
		stmtTableCustomerPwHistory.close();
		stmtTableCustomerAdrr.close();
		stmtTableCustomerDetail.close();
		stmtTableCustomer.close();
		conn.close();
	}
	
	//@table customer, customer_detail
	public RetrieveCumstomerInfoVo retrieveCumstomerInfo(int customerNo) throws SQLException, ClassNotFoundException {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		//인자가 빈 쿼리문 준비
		String sqlTableCustomerJoinCustomerDetail = "SELECT c.customer_id customerId, cd.customer_name customerName, cd.customer_phone customerPhone FROM customer c INNER JOIN customer_detail cd ON c.customer_no = cd.customer_no	WHERE c.customer_no = ?";
		
		//redy stmt
		PreparedStatement stmtTableCustomerJoinCustomerDetail = conn.prepareStatement(sqlTableCustomerJoinCustomerDetail);
		
		//인자입력
		stmtTableCustomerJoinCustomerDetail.setInt(1, customerNo);
		
		//쿼리실행
		 ResultSet rsTableCustomerDetailJoinCustomerDetail = stmtTableCustomerJoinCustomerDetail.executeQuery();
		 
		 //vo
		 RetrieveCumstomerInfoVo CumstomerInfoVo = new RetrieveCumstomerInfoVo();		 
		 
		 
		 //mapping
		 if (rsTableCustomerDetailJoinCustomerDetail.next()) {
			 CumstomerInfoVo.setCustomerId(rsTableCustomerDetailJoinCustomerDetail.getString("customerId"));
			 CumstomerInfoVo.setCustomerName(rsTableCustomerDetailJoinCustomerDetail.getString("customerName"));
			 CumstomerInfoVo.setCustomerPhone(rsTableCustomerDetailJoinCustomerDetail.getString("customerPhone"));
		 }		
		
		// return DB resource
		rsTableCustomerDetailJoinCustomerDetail.close();
		stmtTableCustomerJoinCustomerDetail.close();
		conn.close();
		
		//return
		return CumstomerInfoVo;
	}
	
		//@table customer_addr
	public ArrayList<CustomerAddr> retrieveCumstomerAddr(int customerNo) throws SQLException, ClassNotFoundException {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		//인자가 빈 쿼리문 준비
		String sqlTableCustomerAddr = "SELECT address, customer_addr_no customerAddrNo FROM customer_addr ca WHERE ca.customer_no = ?";
		
		//redy stmt
		PreparedStatement stmtTableCustomerAdrr = conn.prepareStatement(sqlTableCustomerAddr);
		
		//인자입력
		stmtTableCustomerAdrr.setInt(1, customerNo);
		
		//쿼리실행
		ResultSet rsTableCustomerAdrr = stmtTableCustomerAdrr.executeQuery();
		 
		 //vo
		ArrayList<CustomerAddr> addrList = new ArrayList<>();
		 
		 //mapping
		 while(rsTableCustomerAdrr.next()) {
			 CustomerAddr customerAddr = new CustomerAddr();
			 customerAddr.setCustomerAddrNo(rsTableCustomerAdrr.getInt("customerAddrNo"));
			 customerAddr.setAddress(rsTableCustomerAdrr.getString("address"));
			 
			 addrList.add(customerAddr);
		 }		 
		
		
		// return DB resource
		rsTableCustomerAdrr.close();
		stmtTableCustomerAdrr.close();
		conn.close();
		
		//return
		return addrList;
	}
	
	
	//@table customer, customer_detail, customer_pw_history
	public void updateCumstomerInfo(UpdateCumstomerInfoVo updateVo) throws ClassNotFoundException, SQLException {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		/*
		updateVo.getCustomerNo()
		updateVo.getUpdatePw()
		
		updateVo.getUpdateName()
		updateVo.getUpdatePhone()
		*/
		
		PreparedStatement stmtCustomer;
		PreparedStatement stmtCustomerDetail;
		PreparedStatement stmtCustomerPwHistory;
		
		
		
		
		if (updateVo.getUpdatePw() != null) {
			String sqlCustomerPwHistoryDuplicateCheck = " SELECT COUNT(*) duplicatedPw from customer_pw_history WHERE customer_no = ? AND customer_pw = PASSWORD(?)";
			stmtCustomerPwHistory = conn.prepareStatement(sqlCustomerPwHistoryDuplicateCheck);
			stmtCustomerPwHistory.setInt(1,updateVo.getCustomerNo());
			stmtCustomerPwHistory.setString(2,updateVo.getUpdatePw());
			ResultSet rs = stmtCustomerPwHistory.executeQuery();
			rs.next();
			
			int pwDuplicateCheck = rs.getInt("duplicatedPw");
			
			if(pwDuplicateCheck == 0) {
				String sqlCustomer = "UPDATE customer SET customer_pw = PASSWORD(?), updatedate = NOW() WHERE customer_no = ?";
				stmtCustomer = conn.prepareStatement(sqlCustomer);
				stmtCustomer.executeUpdate();
			}
						
		}
		
		
		
		String sqlCustomerDetail = "UPDATE customer_detail SET customer_name = ?, customer_phone = ?, updatedate = NOW() WHERE customer_no = ?";
		
		
		
		
		
	}
	
	//@table customer_addr
	public void updateCumstomerAdrr(UpdateCumstomerAddrVo updateVo) {
		
	}
	
	
	
	//@table customer, customer_detail, customer_pw_history
	public void deleteCumstomer() {
		
	}
	
	
}

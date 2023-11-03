package dao;
import java.sql.*;
import java.util.ArrayList;

import dto.CreateCustomerDto;
import dto.RetrieveCustomerAllInfoDto;
import dto.UpdateCumtomerDto;
import vo.Customer;
import vo.CustomerAddr;
import vo.CustomerDetail;
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
	public int createCumstomer(CreateCustomerDto dto) throws SQLException, ClassNotFoundException{
		/* DTO to VO*/
		Customer customer = dto.toCustomer();
		CustomerDetail detail = dto.toCustomerDetail();
		CustomerAddr addr = dto.toCustomerAddr();
		CustomerPwHistory pwHistory = dto.toCustomerPwHistory();
		
		/*get connection*/
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		/*트랜젝션 시작*/
		PreparedStatement stmtCustomer = customer.getStmtToCreate(conn);
		int affectedRow = stmtCustomer.executeUpdate();
		//validation check
		if (affectedRow != 1) { 
			conn.rollback();
			stmtCustomer.close();
			conn.close();
			return 0;
		}
		//gen parent table PR key
		int genCustomerNo = -1;
		ResultSet rsGenKey = stmtCustomer.getGeneratedKeys();
		if(rsGenKey.next()) {
			genCustomerNo = rsGenKey.getInt(1);
			rsGenKey.close();
			stmtCustomer.close();
		}
		//to ready childe table 
		PreparedStatement stmtCustomerDetail = detail.getStmtToCreate(conn,genCustomerNo);
		PreparedStatement stmtCustomerAddr = addr.getStmtToCreate(conn,genCustomerNo);
		PreparedStatement stmtCustomerPwHistory = pwHistory.getStmtToCreate(conn,genCustomerNo);		
		affectedRow *= stmtCustomerDetail.executeUpdate();
		affectedRow *= stmtCustomerAddr.executeUpdate();
		affectedRow *= stmtCustomerAddr.executeUpdate();		
		//validation check and return result ( fail : - 1  , success : genCustomerNo)
		if (affectedRow != 1) { 
			conn.rollback();
			stmtCustomerDetail.close();
			stmtCustomerAddr.close();
			stmtCustomerPwHistory.close();
			conn.close();
			return -1;
		}else {
			conn.commit();
			stmtCustomerDetail.close();
			stmtCustomerAddr.close();
			stmtCustomerPwHistory.close();
			conn.close();
			return genCustomerNo;
		}
		/*트랜젝션 종료*/
	}
	
	//@table 하나의 고객의 모든정보 조회
	public RetrieveCustomerAllInfoDto retrieveCustomerAllInfoByCusNo(int customerNo) throws SQLException, ClassNotFoundException {
		RetrieveCustomerAllInfoDto dto = new RetrieveCustomerAllInfoDto();
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		PreparedStatement stmtCustomer = new Customer().getStmtToRetrieve(conn, customerNo);
		PreparedStatement stmtDetail = new CustomerDetail().getStmtToRetrieve(conn, customerNo);
		PreparedStatement stmtAddr = new CustomerAddr().getStmtToRetrieveByCusNo(conn, customerNo);
		PreparedStatement stmtPwHistory = new CustomerPwHistory().getStmtToRetrieveByCusNo(conn, customerNo);
		
		ResultSet rsCustomer = stmtCustomer.executeQuery();
		ResultSet rsDetail = stmtDetail.executeQuery();
		ResultSet rsAddr = stmtAddr.executeQuery();
		ResultSet rsPwHistory = stmtPwHistory.executeQuery();
		
		if(rsCustomer.next()) {
			Customer customer = new Customer(rsCustomer);
			dto.mapCustomer(customer);
		}
		if(rsDetail.next()) {
			CustomerDetail customerDetail = new CustomerDetail(rsDetail);
			dto.mapDetail(customerDetail);
		}
		
		ArrayList<CustomerAddr> addrList = new ArrayList<>();
		while(rsAddr.next()) {
			CustomerAddr addr = new CustomerAddr();
			addr.map(rsAddr);
			addrList.add(addr);
		}
		dto.setCustomerAddrList(addrList);
		
		ArrayList<CustomerPwHistory> pwHistoryList = new ArrayList<>();
		while(rsPwHistory.next()) {
			CustomerPwHistory pwhist = new CustomerPwHistory();
			pwhist.map(rsPwHistory);
			pwHistoryList.add(pwhist);
		}
		dto.setCustomerPwHistoryList(pwHistoryList);
		
		rsCustomer.close();
		stmtCustomer.close();
		rsDetail.close();
		stmtDetail.close();
		rsAddr.close();
		stmtAddr.close();
		rsPwHistory.close();
		stmtPwHistory.close();
		conn.close();
		
		return dto;
		
	}
	/*updates*/
	public int updateCustomer(Customer cus) throws SQLException {
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		//validation pw duplicated
		String pwDupCheck = "SELECT COUNT(*) duplicatedPw FROM customer_pw_history WHERE customer_no = ? AND customer_pw = PASSWORD(?)";
		PreparedStatement stmtPwPudcheck = conn.prepareStatement(pwDupCheck);
		stmtPwPudcheck.setInt(1, cus.getCustomerNo());
		stmtPwPudcheck.setString(2, cus.getCustomerPw());
		ResultSet rsPwDup = stmtPwPudcheck.executeQuery();
		if(rsPwDup.next()){
			int pwDup = rsPwDup.getInt("duplicatedPw");
			if(pwDup != 0) {
				rsPwDup.close();
				stmtPwPudcheck.close();
				conn.close();
				return -1;
			}
		}
		//update customer;
		PreparedStatement stmtCutomer = cus.getStmtToUpdate(conn);
		int affectedRow = stmtCutomer.executeUpdate();
		if (affectedRow != 1) { 
			conn.rollback();
			stmtCutomer.close();
			conn.close();
			return -1;
		}else {
			conn.commit();
			stmtCutomer.close();
			conn.close();
			return affectedRow;
		}
		
	}
	
	
	
	
	
	//@table customer, customer_detail, customer_pw_history
	public void deleteCumstomer() {
		
	}
	
	
}

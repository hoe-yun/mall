package dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.Customer;
import vo.CustomerAddr;
import vo.CustomerDetail;
import vo.CustomerPwHistory;

public class RetrieveCustomerAllInfoDto {
	private int customerNo; //pk
	private String customerId;
	private String customerPw;
	private String createdateCustomer;
	private String updatedateCustomer;
	private String active;
	
	private String customerName;
	private String customerPhone;
	private String createdateCustomerDetail;
	private String updatedateCustomerDetail;
	
	private ArrayList<CustomerAddr> customerAddrList;
	private ArrayList<CustomerPwHistory> customerPwHistoryList;
	
	/* mapper*/
	public void mapCustomer(Customer c) {
		this.customerNo = c.getCustomerNo();
		this.customerId = c.getCustomerId();
		this.customerPw = c.getCustomerPw();
		this.createdateCustomer = c.getCreatedate();
		this.updatedateCustomer = c.getUpdatedate();
		this.active = c.getActive();
	}

	public void mapDetail(CustomerDetail cd) throws SQLException {
		this.customerName = cd.getCustomerName();
		this.customerPhone = cd.getCustomerPhone();
		this.createdateCustomerDetail = cd.getCreatedate();
		this.updatedateCustomerDetail = cd.getUpdatedate();
		
	}
	
	
	/* getters*/
	public int getCustomerNo() {
		return customerNo;
	}
	public String getCustomerId() {
		return customerId;
	}
	public String getCustomerPw() {
		return customerPw;
	}
	public String getCreatedateCustomer() {
		return createdateCustomer;
	}
	public String getUpdatedateCustomer() {
		return updatedateCustomer;
	}
	public String getActive() {
		return active;
	}
	public String getCustomerName() {
		return customerName;
	}
	public String getCustomerPhone() {
		return customerPhone;
	}
	public String getCreatedateCustomerDetail() {
		return createdateCustomerDetail;
	}
	public String getUpdatedateCustomerDetail() {
		return updatedateCustomerDetail;
	}
	public ArrayList<CustomerAddr> getCustomerAddrList() {
		return customerAddrList;
	}
	public ArrayList<CustomerPwHistory> getCustomerPwHistoryList() {
		return customerPwHistoryList;
	}
	public void setCustomerAddrList(ArrayList<CustomerAddr> customerAddrList) {
		this.customerAddrList = customerAddrList;
	}
	public void setCustomerPwHistoryList(ArrayList<CustomerPwHistory> customerPwHistoryList) {
		this.customerPwHistoryList = customerPwHistoryList;
	}

	
	
	
}

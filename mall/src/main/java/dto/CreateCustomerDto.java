package dto;

import vo.Customer;
import vo.CustomerAddr;
import vo.CustomerDetail;
import vo.CustomerPwHistory;

public class CreateCustomerDto {
	private String id;
	private String pw;
	private String name;
	private String phone;
	private String addr;
	
	/* toVo*/
	public Customer toCustomer() {
		Customer c = new Customer();
		c.setCustomerId(id);
		c.setCustomerPw(pw);
		
		return c;
	}
	public CustomerDetail toCustomerDetail() {
		CustomerDetail c = new CustomerDetail();
		c.setCustomerName(name);;
		c.setCustomerPhone(phone);
		
		return c;
	}
	public CustomerAddr toCustomerAddr() {
		CustomerAddr c = new CustomerAddr();
		c.setAddress(addr);
		
		return c;
	}
	public CustomerPwHistory toCustomerPwHistory() {
		CustomerPwHistory c = new CustomerPwHistory();
		c.setCustomerPw(pw);
		
		return c;
	}
	
	
	/* setters */
	public void setId(String id) {
		this.id = id;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
}

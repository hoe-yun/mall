package dto;

import vo.Customer;
import vo.CustomerAddr;
import vo.CustomerDetail;

public class UpdateCumtomerDto {
	private int customerNo;
	private String pw;
	private String active;
	private String name;
	private String phone;
	
	private int customerAddrNo;
	private String addr;
	
	/*constructor*/
	public UpdateCumtomerDto() {
		this.customerNo = -1;
		this.pw = null;  
		this.name = null;
		this.phone = null; 
		
		this.customerAddrNo = -1;
		this.addr = null;
	}
	
	/* toVo*/
	public Customer toCustomer() {
		Customer c = new Customer();
		c.setCustomerNo(customerNo);
		c.setActive(active);
		c.setCustomerPw(pw);
		return c;
	}
	public CustomerDetail toCustomerDetail() {
		CustomerDetail c = new CustomerDetail();
		c.setCustomerNo(customerNo);
		c.setCustomerName(name);;
		c.setCustomerPhone(phone);
		return c;
	}
	public CustomerAddr toCustomerAddr() {
		CustomerAddr c = new CustomerAddr();
		c.setCustomerAddrNo(customerAddrNo);
		c.setAddress(addr);
		return c;
	}
	

	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setCustomerAddrNo(int customerAddrNo) {
		this.customerAddrNo = customerAddrNo;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
}

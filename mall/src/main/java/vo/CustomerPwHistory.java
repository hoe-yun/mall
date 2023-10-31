package vo;

public class CustomerPwHistory {
	private int customerPwHistoryNo;
	private int customerNo;
	private String customerPw;
	private String createdate;
	
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

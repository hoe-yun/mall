package vo;

public class OrderCreateVo {
	private int customerNo;
	private int customerAddressNo;
	private int goodNo;
	private int quantity;
	private int totalPrice;
	
	public int getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public int getCustomerAddressNo() {
		return customerAddressNo;
	}
	public void setCustomerAddressNo(int customerAddressNo) {
		this.customerAddressNo = customerAddressNo;
	}
	public int getGoodNo() {
		return goodNo;
	}
	public void setGoodNo(int goodNo) {
		this.goodNo = goodNo;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	@Override
	public String toString() {
	StringBuilder stringBuilder = new StringBuilder();
		String str = stringBuilder
			.append(customerNo).append(" ")
			.append(customerAddressNo).append(" ")
			.append(goodNo).append(" ")
			.append(quantity).append(" ")
			.append(totalPrice).append(" ")
			.toString(); // 문자열로 변환

	return str;
	}
	
}

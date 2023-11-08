package vo;
// 정인호  장바구니 데이터를 주문서로 옮기기 위한 vo
public class TransferCartToOrderVo {
	private int goodsNo;
	private int quantity;
	private int goodsPrice;
	
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(int goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	
	
	
}

package vo;

public class Nostice {
	private int nosticeNo;
	private int managerNo;
	private String nosticeTitle;
	private String nosticeContent;
	private String createdate;
	private String updatedate;
	
	public int getNosticeNo() {
		return nosticeNo;
	}
	public void setNosticeNo(int nosticeNo) {
		this.nosticeNo = nosticeNo;
	}
	public int getManagerNo() {
		return managerNo;
	}
	public void setManagerNo(int managerNo) {
		this.managerNo = managerNo;
	}
	public String getNosticeTitle() {
		return nosticeTitle;
	}
	public void setNosticeTitle(String nosticeTitle) {
		this.nosticeTitle = nosticeTitle;
	}
	public String getNosticeContent() {
		return nosticeContent;
	}
	public void setNosticeContent(String nosticeContent) {
		this.nosticeContent = nosticeContent;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
}

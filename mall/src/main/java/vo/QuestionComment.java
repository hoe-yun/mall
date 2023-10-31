package vo;

public class QuestionComment {
	private int questionCommentNo;
	private int questionNo;
	private int managerNo;
	private String comment;
	private String createdate;
	private String updatedate;
	
	public int getQuestionCommentNo() {
		return questionCommentNo;
	}
	public void setQuestionCommentNo(int questionCommentNo) {
		this.questionCommentNo = questionCommentNo;
	}
	public int getQuestionNo() {
		return questionNo;
	}
	public void setQuestionNo(int questionNo) {
		this.questionNo = questionNo;
	}
	public int getManagerNo() {
		return managerNo;
	}
	public void setManagerNo(int managerNo) {
		this.managerNo = managerNo;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
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

package web.jsp08.model;

import java.sql.Timestamp;

public class ReplyDTO {

	private int replyNum;
	private String reply;
	private String replyer;
	private Timestamp replyReg;
	private int boardNum;
	private int replyGrp;
	private int replyLevel;
	private int replyStep;
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	public Timestamp getReplyReg() {
		return replyReg;
	}
	public void setReplyReg(Timestamp replyReg) {
		this.replyReg = replyReg;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public int getReplyGrp() {
		return replyGrp;
	}
	public void setReplyGrp(int replyGrp) {
		this.replyGrp = replyGrp;
	}
	public int getReplyLevel() {
		return replyLevel;
	}
	public void setReplyLevel(int replyLevel) {
		this.replyLevel = replyLevel;
	}
	public int getReplyStep() {
		return replyStep;
	}
	public void setReplyStep(int replyStep) {
		this.replyStep = replyStep;
	}
	
	
}

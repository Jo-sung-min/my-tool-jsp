package web.board.model;

import java.sql.Timestamp;

public class ImgReplyDTO {

	private int rno; 
	private String reply; 
	private String replyer; 
	private Timestamp replyReg;
	private int bno; 
	private int replyGrp;
	private int replyLevel;
	private int replyStep;
	
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
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
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
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

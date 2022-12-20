package web.jsp04.test;

import java.sql.Timestamp;

public class TestDTO {
		// 컬럼
	private String id;
	private String pw;
	private int age;
	private Timestamp reg;
	
	public String getId() {
		return id;
	}
	public String getPw() {
		return pw;
	}
	public int getAge() {
		return age;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
	
	
}

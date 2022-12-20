package web.jsp03.test;




	//자바 빈 : 캡슐화로 작성
	public class Bean implements java.io.Serializable {

		//변수
		private String id;
		private String pw;
		
		// 기본생성자
		public Bean () {}
			//get/set
			public void setId(String id) {
				this.id=id;
			}
			public void setPw(String pw) {
				this.pw=pw;
			}
			
			public String getID() {
				return id;
			}
			public String getPw() {
				return pw;
			}
		
			
		
		
	}



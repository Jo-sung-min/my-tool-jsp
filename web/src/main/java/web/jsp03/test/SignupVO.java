package web.jsp03.test;

public class SignupVO implements java.io.Serializable {
	private String id;
	private String pw;
	private String name;
	private String gender;
	private String email;
	
	private String music;
	private String sports;
	private String travel;
	private String moives;
	private String job;
	private String bio;
	
	
	public SignupVO() {}
	public void setId(String id) {
		this.id=id;
	}
	public void setPw(String pw) {
		this.pw=pw;
	}
	public void setName(String name) {
		this.name=name;
	}
	public void setGender(String gender) {
		this.gender=gender;
	}
	public void setMusic(String music) {
		this.music=music;
	}
	public void setSports(String sports) {
		this.sports=sports;
	}
	public void setTravel(String travel) {
		this.travel=travel;
	}
	public void setMoives(String moives) {
		this.moives=moives;
	}
	public void setJob(String job) {
		this.job=job;
	}
	public void setBio(String bio) {
		this.bio=bio;
	}
	
	
	public String getId() {
		return id;
	}
	public String getPw() {
		return pw;
	}
	public String getName() {
		return name;
	}
	public String getGender() {
		return gender;
	}
	public String getMusic() {
		return music;
	}
	public String getSports() {
		return sports;
	}
	public String getTravel() {
		return travel;
	}
	public String getMoives() {
		return moives;
	}
	public String getJob() {
		return job;
	}
	public String getBio() {
		return bio;
	}

	
}

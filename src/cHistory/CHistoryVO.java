package cHistory;

public class CHistoryVO {
	private String id; //학번
	private int ccode; //과목코드
	private double grade; // 학점
	private String rate; // 등급
	
	
	//getter & setter
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getCcode() {
		return ccode;
	}
	public void setCcode(int ccode) {
		this.ccode = ccode;
	}
	public double getGrade() {
		return grade;
	}
	public void setGrade(double grade) {
		this.grade = grade;
	}
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}
	
	
}

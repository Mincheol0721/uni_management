package faculty;

// 학부 정보 테이블
public class FacultyVO {
	private int fcode; // 학부 고유 번호
	private String fname; //학부 이름
	
	//getter & setter
	public int getFcode() {
		return fcode;
	}
	public void setFcode(int fcode) {
		this.fcode = fcode;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	
	
}

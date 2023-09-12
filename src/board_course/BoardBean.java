package board_course;

//개설 과목

//VO역할을 하는 클래스
public class BoardBean {

	//멤버 변수
	private int ccode; //과목 코드		    
	private String cname; //과목명
	private String compdiv; //이수 구분
	private int compyear; //이수 학년
	private int compsem; //이수 학기
	private int grade; //학점
	private String professor; //담당 교수
	
	//getter, setter 메소드
	public int getCcode() {
		return ccode;
	}
	public void setCcode(int ccode) {
		this.ccode = ccode;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getCompdiv() {
		return compdiv;
	}
	public void setCompdiv(String compdiv) {
		this.compdiv = compdiv;
	}
	public int getCompyear() {
		return compyear;
	}
	public void setCompyear(int compyear) {
		this.compyear = compyear;
	}
	public int getCompsem() {
		return compsem;
	}
	public void setCompsem(int compsem) {
		this.compsem = compsem;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getProfessor() {
		return professor;
	}
	public void setProfessor(String professor) {
		this.professor = professor;
	}
	

	
	
}

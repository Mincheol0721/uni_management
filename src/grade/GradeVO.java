package grade;

public class GradeVO {
	private String cname; //과목명
	private String compdiv; // 전공 ex)전공필수 전공선택
	private int compyear; // 학년
	private double grade; // 학점
	private String rate; // 등급
	private String professor; //교수
	
	// 교수를 제외한 매개변수를 받아 객체를 생성할 생성자
	public GradeVO(String cname, String compdiv, int compyear, double grade, String rate) {
		super();
		this.cname = cname;
		this.compdiv = compdiv;
		this.compyear = compyear;
		this.grade = grade;
		this.rate = rate;
	}
	
	//모든 매개변수를 받아 객체를 생성할 생성자
	public GradeVO(String cname, String compdiv, int compyear, double grade, String rate, String professor) {
		super();
		this.cname = cname;
		this.compdiv = compdiv;
		this.compyear = compyear;
		this.grade = grade;
		this.rate = rate;
		this.professor = professor;
	}


	//getter & setter
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

	public String getProfessor() {
		return professor;
	}

	public void setProfessor(String professor) {
		this.professor = professor;
	}
	
	
	
	
	
}

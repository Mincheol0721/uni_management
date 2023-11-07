package courseList;

//전체 강의 리스트를 보여줄 클래스
public class CourseBean {

	//멤버변수 선언
	private int grade;
	private int compyear;
	private int compsem;
	private String cname;
	private String professor;
	private String compdiv;
	
	public CourseBean() {}
	
	public CourseBean(int grade, int compyear, int compsem, String cname, String professor, String compdiv) {
		
		this.grade = grade;
		this.compyear = compyear;
		this.compsem = compsem;
		this.cname = cname;
		this.professor = professor;
		this.compdiv = compdiv;
	}
	
	//getter, setter메소드	
	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
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

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getProfessor() {
		return professor;
	}

	public void setProfessor(String professor) {
		this.professor = professor;
	}

	public String getCompdiv() {
		return compdiv;
	}

	public void setCompdiv(String compdiv) {
		this.compdiv = compdiv;
	}
	

	
}

package courseList;

//cPlan 테이블
public class CoursePlanBean {

	private String course;
	private String dept;
	private int grade;
	private String time;
	private String compdiv;
	private int compyear;
	private int compsem;
	private String email;
	private String content;
	private String purpose;
	private String books;
	
	public CoursePlanBean() {

	}

	public CoursePlanBean(String course, String dept, int grade, String time, String compdiv, int compyear, int compsem,
			String email, String content, String purpose, String books) {

		this.course = course;
		this.dept = dept;
		this.grade = grade;
		this.time = time;
		this.compdiv = compdiv;
		this.compyear = compyear;
		this.compsem = compsem;
		this.email = email;
		this.content = content;
		this.purpose = purpose;
		this.books = books;
	}

	public String getCourse() {
		return course;
	}

	public void setCourse(String course) {
		this.course = course;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getBooks() {
		return books;
	}

	public void setBooks(String books) {
		this.books = books;
	}
	
	
	
	
}

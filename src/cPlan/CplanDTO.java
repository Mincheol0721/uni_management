package cPlan;

public class CplanDTO {
	private String cname; // 과목명
	private String dept; // 학과
	private int grade; // 학점
	private String time; // 시간
	private String compdiv; //이수구분
	private int compyear; // 대상학년
	private int compsem; //학기
	private String email; // 이메일
	private String content; // 교과목 개요
	private String purpose; // 교육 목표
	private String books; // 주교재
	
	
	//기본 생성자
	public CplanDTO() {
		
	}

// 모든 매개변수를 받을 생성자
	
	public CplanDTO(String cname, String dept, int grade, String time, String compdiv, int compyear, int compsem,
			String email, String content, String purpose, String books) {
		super();
		this.cname = cname;
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

	

	// getter & setter
	public String getCname() {
		return cname;
	}



	


	public void setCname(String cname) {
		this.cname = cname;
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

	public int getCompyear() {
		return compyear;
	}

	public void setCompyear(int compyear) {
		this.compyear = compyear;
	}
	
	
	
}

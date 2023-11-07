package course;
// 과목
public class CourseVO {
	private int ccode; // 컴퓨터공학과, 신소재공학과 ..
	private String cname; 
	private String compdiv; // 전공선택, 전공필수, 교양선택,교양필수
	private int compyear; // 1학년 ~ 4학년 필수 입력 , 꼭 그학년이어야만 하는건 아님
	private int compsem; // 1학기,2학기 중 선택 입력
	private int grade; // 1점 ~ 3점 선택
	private String day; //요일
	private String professor;
	private String startTime; // 강의 시작 교시
	private String endTime; // 강의 끝 교시
	
	
	public CourseVO(int ccode, String cname, String compdiv, int compyear, int compsem, int grade, String professor,
			String startTime, String endTime,String day) {
		super();
		this.ccode = ccode;
		this.cname = cname;
		this.compdiv = compdiv;
		this.compyear = compyear;
		this.compsem = compsem;
		this.grade = grade;
		this.professor = professor;
		this.startTime = startTime;
		this.endTime = endTime;
		this.day = day;
	}

	
	
	//getter & setter
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


	public String getStartTime() {
		return startTime;
	}


	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}


	public String getEndTime() {
		return endTime;
	}


	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}



	public String getDay() {
		return day;
	}



	public void setDay(String day) {
		this.day = day;
	}
	
	
	
	
	
}

package board_course;


//개설 과목

//VO역할을 하는 클래스
public class BoardBean {

	//멤버 변수
	private int ccode; 			//과목 코드		    
	private String cname; 		//과목명
	private String compdiv; 	//이수 구분
	private int compyear; 		//이수 학년
	private int compsem; 		//이수 학기
	private int grade; 			//학점
	private String professor; 	//담당 교수 이름
	private String day;			//요일
	private int starttime;		//시작 교시
	private int endtime;		//끝 교시
	private String id; 			//등록한 과목에 대한 교수 아이디
	
	public BoardBean() {
	
	}

	public BoardBean(int ccode, String cname, String compdiv, int compyear, int compsem, int grade, String professor,
			String day, int starttime, int endtime, String id) {
		this.ccode = ccode;
		this.cname = cname;
		this.compdiv = compdiv;
		this.compyear = compyear;
		this.compsem = compsem;
		this.grade = grade;
		this.professor = professor;
		this.day = day;
		this.starttime = starttime;
		this.endtime = endtime;
		this.id = id;
	}

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

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public int getStarttime() {
		return starttime;
	}

	public void setStarttime(int starttime) {
		this.starttime = starttime;
	}

	public int getEndtime() {
		return endtime;
	}

	public void setEndtime(int endtime) {
		this.endtime = endtime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	








	

	
	
}

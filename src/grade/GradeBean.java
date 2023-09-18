package grade;

//성적

//VO역할을 하는 클래스
public class GradeBean {

	//멤버 변수 -- 수강 내역 테이블 
	private String id;			//학번
	private int ccode;			//과목 코드
	private int grade;			//학점
	private String rate;		//등급 (A,B,C..)
	private String cname;		//과목명
	private String name;		//학생 이름	
		
	public GradeBean() {}

	public GradeBean(String id, int ccode, int grade, String rate, String cname, String name) {
		super();
		this.id = id;
		this.ccode = ccode;
		this.grade = grade;
		this.rate = rate;
		this.cname = cname;
		this.name = name;
	}

	//getter, setter 메소드들
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

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}	
	

	
	
	
	
	
	
}

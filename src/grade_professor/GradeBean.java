package grade_professor;

//성적

//VO역할을 하는 클래스
public class GradeBean {

	//멤버 변수 -- 수강 내역 테이블 
	
	private int ccode;			//과목 코드
	private String cname;		//과목명
	private String id;			//학번
	private String name;		//학생 이름	
	private int grade;			//점수 (75, 80...)
	private String rate;		//등급 (A,B,C..)
	private String propid;		//교수 아이디
		
	public GradeBean() {}

	public GradeBean(int ccode, String cname, String id, String name, int grade, String rate, String propId) {
		this.ccode = ccode;
		this.cname = cname;
		this.id = id;
		this.name = name;
		this.grade = grade;
		this.rate = rate;
		this.propid = propId;
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getPropId() {
		return propid;
	}

	public void setPropId(String propId) {
		this.propid = propId;
	}

	
	
	
	
	
}

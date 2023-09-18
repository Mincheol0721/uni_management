package lectureBoard;

import java.sql.Timestamp;

public class LectureVO {
	private int num; //글번호
	private String name; //이름
	private String title; // 제목
	private String lectureName; //강의명
	private String professorName; //교수명
	private String lectureYear; //수강년도
	private String semesterDivide; //수강학기
	private String lectureDivide; // 강의구분 전필,전선,교필...
	private String mainText; //내용
	private String rate; //등급
	private int re_ref;
	private int re_lev;
	private int re_seq;
	private int readcount;
	private Timestamp date;
	
	public LectureVO() {
		
	}
	
	//모든값을 매개변수로 받아 저장할 생성자
	public LectureVO(String name, String lectureName, String professorName, String lectureYear,
			String semesterDivide, String lectureDivide, String title, String mainText, String rate) {
		super();
		this.name = name;
		this.lectureName = lectureName;
		this.professorName = professorName;
		this.lectureYear = lectureYear;
		this.semesterDivide = semesterDivide;
		this.lectureDivide = lectureDivide;
		this.title = title;
		this.mainText = mainText;
		this.rate = rate;
	}
	
	public LectureVO(int num,String name, String title, String lectureName, String professorName, String rate,Timestamp date) {
		super();
		this.date = date;
		this.num = num;
		this.name = name;
		this.title = title;
		this.lectureName = lectureName;
		this.professorName = professorName;
		this.rate = rate;
	
	}

	//getter & setter
	
	
	

	public int getNum() {
		return num;
	}

	public int getRe_ref() {
		return re_ref;
	}

	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}

	public int getRe_lev() {
		return re_lev;
	}

	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}

	public int getRe_seq() {
		return re_seq;
	}

	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLectureName() {
		return lectureName;
	}

	public void setLectureName(String lectureName) {
		this.lectureName = lectureName;
	}

	public String getProfessorName() {
		return professorName;
	}

	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}

	public String getLectureYear() {
		return lectureYear;
	}

	public void setLectureYear(String lectureYear) {
		this.lectureYear = lectureYear;
	}

	public String getSemesterDivide() {
		return semesterDivide;
	}

	public void setSemesterDivide(String semesterDivide) {
		this.semesterDivide = semesterDivide;
	}

	public String getLectureDivide() {
		return lectureDivide;
	}

	public void setLectureDivide(String lectureDivide) {
		this.lectureDivide = lectureDivide;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMainText() {
		return mainText;
	}

	public void setMainText(String mainText) {
		this.mainText = mainText;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}
	
	
	
	
}

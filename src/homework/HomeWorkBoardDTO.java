package homework;

public class HomeWorkBoardDTO {
	
	private String name; // 이름
	private int num; //글 번호
	private String course; // 과목
	private String tasktype; // 과제유형
	private String tasktitle; // 과제제목
	private String taskmethod; // 제출방법
	private String period; // 기간
	private String homeworkOk; // 제출 여부
	private int numpeople; // 제출인원
	
	
	
	// 기본생성자
	public HomeWorkBoardDTO() {
		super();
	}

	// 모든매개변수를 받을 생성자
	public HomeWorkBoardDTO(String course, String tasktype, String tasktitle, String taskmethod, String period,
			int numpeople) {
		super();
		this.course = course;
		this.tasktype = tasktype;
		this.tasktitle = tasktitle;
		this.taskmethod = taskmethod;
		this.period = period;
		this.numpeople = numpeople;
	}

	// getter & setter
	
	
	
	public String getCourse() {
		return course;
	}

	public String getHomeworkOk() {
		return homeworkOk;
	}

	public void setHomeworkOk(String homeworkOk) {
		this.homeworkOk = homeworkOk;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public void setCourse(String course) {
		this.course = course;
	}

	public String getTasktype() {
		return tasktype;
	}

	public void setTasktype(String tasktype) {
		this.tasktype = tasktype;
	}

	public String getTasktitle() {
		return tasktitle;
	}

	public void setTasktitle(String tasktitle) {
		this.tasktitle = tasktitle;
	}

	public String getTaskmethod() {
		return taskmethod;
	}

	public void setTaskmethod(String taskmethod) {
		this.taskmethod = taskmethod;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public int getNumpeople() {
		return numpeople;
	}

	public void setNumpeople(int numpeople) {
		this.numpeople = numpeople;
	}
	
	
}

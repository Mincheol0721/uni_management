package homework;

import java.sql.Timestamp;

public class HomeWorkDTO {
	private int num;
	private String studentName;
	private String course;
	private String taskTitle;
	private String title;
	private String content;
	private String passwd;
	private String fileName;
	private String fileRealName;
	private Timestamp date;
	
	
	//기본 생성자
	public HomeWorkDTO() {
		super();
	}
	
	
	
	
		//모든 매개변수를 받을 생성자
		public HomeWorkDTO(int num,String studentName, String course, String taskTitle, String title, String content, String passwd,
			String fileName, String fileRealName, Timestamp date) {
		super();
		this.num = num;
		this.studentName = studentName;
		this.course = course;
		this.taskTitle = taskTitle;
		this.title = title;
		this.content = content;
		this.passwd = passwd;
		this.fileName = fileName;
		this.fileRealName = fileRealName;
		this.date = date;
	}





		public HomeWorkDTO(String studentName, String course, String taskTitle, String title, String content,
			String passwd, String fileName, String fileRealName) {
		super();
		this.studentName = studentName;
		this.course = course;
		this.taskTitle = taskTitle;
		this.title = title;
		this.content = content;
		this.passwd = passwd;
		this.fileName = fileName;
		this.fileRealName = fileRealName;
	}

		//setter & getter
	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getCourse() {
		return course;
	}

	public void setCourse(String course) {
		this.course = course;
	}

	

	public String getTaskTitle() {
		return taskTitle;
	}




	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}




	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileRealName() {
		return fileRealName;
	}

	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}




	public int getNum() {
		return num;
	}




	public void setNum(int num) {
		this.num = num;
	}
	
	
	
}

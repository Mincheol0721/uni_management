package file;



public class FileDTO {//VO역할을 하는 클래스
	//변수
	
	private String title; // 제목
	private String fileName;//업로드 또는 다운로드한 파일의 원본이름을 저장할 변수 
	private String fileRealName;//업로드 또는 다운로드한 파일의 실제이름을 저장할 변수 
	private String content; // 본문
	private String submitHomeWork; // 과제 보냈는지 확인할 변수 y or no
	
	
	//기본생성자
	public FileDTO() {}
	
	//FileDTO클래스의 인스턴스 생성시 호출되는 생성자로
	//업로드 또는 다운로드한 파일의 원본이름, 업로드 또는 다운로드한 파일의 실제이름, 다운로드한 횟수를 저장할 인스턴스변수의 값을 초기화할 생성자.
	public FileDTO(String fileName, String fileRealName, int downloadCount) {
		this.fileName = fileName;
		this.fileRealName = fileRealName;
			
	}
	
	//모든 매개변수로 받을 생성자 
	public FileDTO(String title, String fileName, String fileRealName, String content, String submitHomeWork) {
		super();
		this.title = title;
		this.fileName = fileName;
		this.fileRealName = fileRealName;
		this.content = content;
		this.submitHomeWork = submitHomeWork;
	}

	//각 변수 하나당 set,get메소드 추가 
	//alt + shift + s  r
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

	public String getSubmitHomeWork() {
		return submitHomeWork;
	}

	public void setSubmitHomeWork(String submitHomeWork) {
		this.submitHomeWork = submitHomeWork;
	}

	

}

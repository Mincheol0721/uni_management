package professor;
 // 교수 정보 테이블
public class Propessor {
	private String id; // 교수 번호 +아이디
	private String name; // 교수 이름
	private String tel; // 전화번호
	private String ssn; // 교수 주민등록번호
	private String email; //교수 이메일
	private String addr; //교수 주소
	private String pwd; //교수 비밀번호
	private String faculty; // 교수 소속 전공
	private String dept; // 교수 소속 전공
	// getter & setter
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
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getSsn() {
		return ssn;
	}
	public void setSsn(String ssn) {
		this.ssn = ssn;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getFaculty() {
		return faculty;
	}
	public void setFaculty(String faculty) {
		this.faculty = faculty;
	}
	
	
}

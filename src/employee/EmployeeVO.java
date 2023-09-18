package employee;

public class EmployeeVO {
	private String id; // 교직원(관리자) 고유번호 + 아이디
	private String name; // 교직원 이름
	private String tel; // 전화번호
	private String ssn; // 교직원 주민등록번호
	private String pwd; // 교직원 비밀번호
	private String addr; // 교직원  주소
	
	//getter & setter
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
}

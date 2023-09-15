package member;

import java.sql.Timestamp;

//VO역할을 하는 자바빈 클래스
//가입하는 한 사람의 회원정보를 임시로 변수에 저장시킬수도 있고
//DB의 member테이블에 저장된 한 사람의 정보를 조회 후 저장할 변수를 가지고 있는 클래스
public class MemberDTO {
	//멤버변수(인스턴스변수)
	//private으로 은닉보호되게 생성
	private String id, pwd, name, email, addr, tel, ssn, faculty, dept, professor;
	private int jobCode;
	private Timestamp reg_date;
	
	//생성자
	public MemberDTO() {}

	//변수들을 초기화할 생성자
	public MemberDTO(String id, String pwd, String name, String email, String addr, String tel, String ssn,
			String dept, String faculty) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.addr = addr;
		this.tel = tel;
		this.ssn = ssn;
		this.dept = dept;
		this.faculty = faculty;
	}
	
	public MemberDTO(String id, String name, String email, String addr, String tel, String ssn,
			String dept, String faculty) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.addr = addr;
		this.tel = tel;
		this.ssn = ssn;
		this.dept = dept;
		this.faculty = faculty;
	}
	
	public MemberDTO(String id, String pwd, String name, String email, String addr, String tel, String ssn) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.addr = addr;
		this.tel = tel;
		this.ssn = ssn;
	}
	
	public MemberDTO(String id, String name, String email, String addr, String tel, String ssn) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.addr = addr;
		this.tel = tel;
		this.ssn = ssn;
	}

	public MemberDTO(String id, String pwd, String name, String email, String addr, String tel, String ssn,
			String dept, String faculty, Timestamp reg_date) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.addr = addr;
		this.tel = tel;
		this.ssn = ssn;
		this.dept = dept;
		this.faculty = faculty;
		this.reg_date = reg_date;
	}
  
	//professor까지 있는 생성자
	public MemberDTO(String id, String pwd, String name, String email, String addr, String tel, String ssn,
			String professor, String dept, String faculty) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.addr = addr;
		this.tel = tel;
		this.ssn = ssn;
		this.dept = dept;
		this.faculty = faculty;
		this.professor = professor;
	}
	
	//getter, setter 메소드
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPwd() {
		return pwd;
	}
	
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
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
	
	public String getDept() {
		return dept;
	}
	
	public void setDept(String dept) {
		this.dept = dept;
	}
	
	public String getFaculty() {
		return faculty;
	}
	
	public void setFaculty(String faculty) {
		this.faculty = faculty;
	}
	
	public Timestamp getReg_date() {
		return reg_date;
	}
	
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	public int getJobCode() {
		return jobCode;
	}

	public void setJobCode(int jobCode) {
		this.jobCode = jobCode;
	}

	
	public String getProfessor() {
		return professor;
	}

	
	public void setProfessor(String professor) {
		this.professor = professor;
	}
	
	
	
	
	
	
}

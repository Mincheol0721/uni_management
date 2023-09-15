package faculty;

public class DeptDTO {
	
	private int fcode, dcode;
	private String fname, dname;
	
	public DeptDTO() {}

	public DeptDTO(int fcode, int dcode, String fname, String dname) {
		super();
		this.fcode = fcode;
		this.dcode = dcode;
		this.fname = fname;
		this.dname = dname;
	}

	public int getFcode() {
		return fcode;
	}

	public void setFcode(int fcode) {
		this.fcode = fcode;
	}

	public int getDcode() {
		return dcode;
	}

	public void setDcode(int dcode) {
		this.dcode = dcode;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}

	

}

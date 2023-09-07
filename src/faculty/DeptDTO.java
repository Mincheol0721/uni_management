package faculty;

public class DeptDTO {
	
	private String fname;
	
	public DeptDTO() {}

	public DeptDTO(String fname) {
		super();
		this.fname = fname;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	};
	
}

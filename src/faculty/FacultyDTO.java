
package faculty;

public class FacultyDTO {
	
	private int fcode;
	private String fname;
	
	public FacultyDTO() {}

	public FacultyDTO(int fcode, String fname) {
		super();
		this.fcode = fcode;
		this.fname = fname;
	}
	
	public int getFcode() {
		return fcode;
	}

	public void setFcode(int fcode) {
		this.fcode = fcode;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	};
	
}


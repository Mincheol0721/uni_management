package faculty;

public class FacultyDTO {
	
	private String fname;
	
	public FacultyDTO() {}

	public FacultyDTO(String fname) {
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

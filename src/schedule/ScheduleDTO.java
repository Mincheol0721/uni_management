package schedule;

import java.sql.Date;

public class ScheduleDTO {
	private int no;
	private String title, content, sclass, id, sdate;
	private Date writeDate;
	
	public ScheduleDTO() {}

	public ScheduleDTO(String title, String content, String sclass, String id, String sdate) {
		super();
		this.title = title;
		this.content = content;
		this.sclass = sclass;
		this.id = id;
		this.sdate = sdate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
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

	public String getSclass() {
		return sclass;
	}

	public void setSclass(String sclass) {
		this.sclass = sclass;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	};
	
	
	
}

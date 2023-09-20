package courseList;

//moreInfo 테이블 참조
public class MoreInfoBean {

	//멤버변수
	private String cname;
	private int week;
	private int session;
	private String topic;
	private String way;
	private String time;
	private String homework;
	
	public MoreInfoBean() {
		
	}

	public MoreInfoBean(String cname, int week, int session, String topic, String way, String time, String homework) {
		super();
		this.cname = cname;
		this.week = week;
		this.session = session;
		this.topic = topic;
		this.way = way;
		this.time = time;
		this.homework = homework;
	}

	//getter, setter 메소드들
	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public int getWeek() {
		return week;
	}

	public void setWeek(int week) {
		this.week = week;
	}

	public int getSession() {
		return session;
	}

	public void setSession(int session) {
		this.session = session;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getWay() {
		return way;
	}

	public void setWay(String way) {
		this.way = way;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getHomework() {
		return homework;
	}

	public void setHomework(String homework) {
		this.homework = homework;
	}

	
	
	
}

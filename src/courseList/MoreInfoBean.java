package courseList;

//moreInfo 테이블 참조
public class MoreInfoBean {

	//멤버변수
	private String cname;
	private int week;
	private int session;
	private String topic;
	private String way;
	private String day;
	private String starttime;
	private String endtime;	
	private String homework;
	private String id;
	
	
	public MoreInfoBean() {
		
	}


	public MoreInfoBean(String cname, int week, int session, String topic, String way, String day, String starttime,
			String endtime, String homework, String id) {
		super();
		this.cname = cname;
		this.week = week;
		this.session = session;
		this.topic = topic;
		this.way = way;
		this.day = day;
		this.starttime = starttime;
		this.endtime = endtime;
		this.homework = homework;
		this.id = id;
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


	public String getDay() {
		return day;
	}


	public void setDay(String day) {
		this.day = day;
	}


	public String getStarttime() {
		return starttime;
	}


	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}


	public String getEndtime() {
		return endtime;
	}


	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}


	public String getHomework() {
		return homework;
	}


	public void setHomework(String homework) {
		this.homework = homework;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}

	

	
	
	
	
}

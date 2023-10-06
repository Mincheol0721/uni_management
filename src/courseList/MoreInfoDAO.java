package courseList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MoreInfoDAO {
	
	//DB작업에 쓰일 객체들을 저장할 변수들
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	//DataSource 얻는 기능의 생성자
	public MoreInfoDAO() {
		
		try {
			
			//InitialContext객체 생성
			Context ctx = new InitialContext();
			
			//기본 경로 주소 설정
			Context envContext = (Context) ctx.lookup("java:comp/env");

			//DataSource커넥션풀 객체 찾아 반환
			ds = (DataSource) envContext.lookup("jdbc/studyplannerdb");
			
		} catch (Exception e) {
			System.out.println("MoreInfoDAO의 생성자 내부에서 커넥션풀 얻기 실패 : " + e.toString());
		}
		
		
	}//생성자 end
	
	//DB연결 후 작업하는 객체들 사용한 뒤에 자원해제 할 때 공통으로 쓰이는 메소드
		public void freeResource() {
			try {
				
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				if(con != null) con.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
	}//자원해제 end
		
		
	//DB로부터 세부 강의 리스트 조회해옴
	public ArrayList<MoreInfoBean> getList() {
		
		//등록된 과목들을 담을 객체
		ArrayList<MoreInfoBean> list = new ArrayList<MoreInfoBean>();
		
		//쿼리를 담을 변수 선언
		String sql = "";	
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			//sql문
			sql = "select * from moreInfo";
			
			//DB에 쿼리문 문자열 전송
			pstmt = con.prepareStatement(sql);
			
			//쿼리 실행
			rs = pstmt.executeQuery();
			
			//rs객체에 담겨있음 -> 컬렉션 객체에 담기
			while(rs.next()) {
				
				MoreInfoBean bean = new MoreInfoBean();
				
				//하나씩 저장
				bean.setCname(rs.getString("cname"));
				bean.setWeek(rs.getInt("week"));
				bean.setSession(rs.getInt("session"));
				bean.setTopic(rs.getString("topic"));
				bean.setWay(rs.getString("way"));
				bean.setDay(rs.getString("day"));
				bean.setStarttime(rs.getInt("starttime"));
				bean.setEndtime(rs.getInt("endtime"));				
				bean.setHomework(rs.getString("homework"));
				
				list.add(bean);
				
				//System.out.println("과목 정보 저장 완료");				
			}			
			
			System.out.println("세부 강의 조회 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 freeResource();
		}

		return list;
	
	}//세부 강의 조회 end		
	
	
	//특정 과목의 세부 강의를 보여주기 위한 메소드
	public ArrayList<MoreInfoBean> getmoreList(String cname) {
		
		//등록된 과목들을 담을 객체
		ArrayList<MoreInfoBean> list = new ArrayList<MoreInfoBean>();				
					
		System.out.println("getmoreList메소드가 받는 과목명: " + cname);
		
		String sql = "select * from moreInfo where cname=? order by week asc";	
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(sql);			

			pstmt.setString(1, cname);
			
			rs = pstmt.executeQuery();
			
			//특정 과목 데이터들을 bean객체에 저장
			while(rs.next()) {
				
				MoreInfoBean bean = new MoreInfoBean();	
				
				bean.setCname(rs.getString("cname"));
				bean.setWeek(rs.getInt("week"));
				bean.setSession(rs.getInt("session"));
				bean.setTopic(rs.getString("topic"));
				bean.setWay(rs.getString("way"));
				bean.setDay(rs.getString("day"));				
				bean.setStarttime(rs.getInt("starttime"));
				bean.setEndtime(rs.getInt("endtime"));
				bean.setHomework(rs.getString("homework"));
				bean.setId(rs.getString("id"));
			
		
				list.add(bean);
			}	
			
			System.out.println("세부 강의 리스트 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getmoreList메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
		
		//보여줄 내용 전달
		return list;

	}//getmoreList end
	
	
	//세부강의 수정을 위해 선택한 한 강의의 정보를 modMoreInfo.jsp에 뿌려주기 위해 리턴하는 메소드
	public MoreInfoBean getMoreInfo(int week) {
		
		System.out.println("getMoreInfo메소드가 받는 주차: " + week);
		String sql = "select * from moreInfo where week=?";
		
		MoreInfoBean bean = new MoreInfoBean();
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(sql);
			
			//DB에 전달할 ?값 세팅
			pstmt.setInt(1, week);
			
			rs = pstmt.executeQuery();
			
			//수정할 과목 하나의 데이터들을 bean객체에 저장
			if (rs.next()) {
		
				bean.setWeek(rs.getInt("week"));
				bean.setSession(rs.getInt("session"));
				bean.setTopic(rs.getString("topic"));
				bean.setWay(rs.getString("way"));
				bean.setDay(rs.getString("day"));
				bean.setStarttime(rs.getInt("starttime"));
				bean.setEndtime(rs.getInt("endtime"));
				bean.setHomework(rs.getString("homework"));
				
			}	
			
			System.out.println("수정할 세부강의 불러오는 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getMoreInfo메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
		
		return bean;

	}//getMoreInfo end

	
	//세부강의 수정하는 기능의 메소드
	public void modifyMoreInfo(MoreInfoBean bean) {			
		
		try {
			
			//DB연결
			con = ds.getConnection();
			String sql = "update moreInfo set topic=?, way=?, day=?, starttime=?, endtime=?, homework=?, week=? where cname=? and week=? and session=?";
			pstmt = con.prepareStatement(sql);
			
//			System.out.println("MOD타는중... cname=" + bean.getCname());
								
			pstmt.setString(1, bean.getTopic());
			pstmt.setString(2, bean.getWay());
			pstmt.setString(3, bean.getDay());
	        pstmt.setInt(4, bean.getStarttime());
	        pstmt.setInt(5, bean.getEndtime());	        
			pstmt.setString(6, bean.getHomework());
			pstmt.setInt(7, bean.getWeek());
			pstmt.setString(8, bean.getCname());
			pstmt.setInt(9, bean.getWeek());
			pstmt.setInt(10, bean.getSession());
	
			
			pstmt.executeUpdate();
			
			System.out.println("세부강의 수정 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("modifyMoreInfo메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
		
	}//modifyMoreInfo end
	
	
	//세부 정보 삭제하는 기능의 메소드
	public void delMoreInfo(String cname, int week) {
		
		String sql = "delete from moreInfo where cname=? and week=?";
		
		try {
			
			//DB연결
			con = ds.getConnection();
	
			pstmt = con.prepareStatement(sql);			
			pstmt.setString(1, cname);
			pstmt.setInt(2, week);
			
			pstmt.executeUpdate();
						
			System.out.println("세부정보 삭제 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("delMoreInfo메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
			
	}//delMoreInfo end
	
	//해당 과목에 대한 세부 정보를 studyplannerdb 데이터베이스의 moreInfo에 추가시키는 기능의 메소드
	public int insertMI(MoreInfoBean moreInfoBean) {
		
		try {
			
			//DB연결 
			con = ds.getConnection();
			
			//insert sql문 만들기
			String sql = "insert into moreInfo (cname, week, session, topic, way, day, starttime, endtime, homework, id)"
					   + "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

			//insert문 실행할 pstmt 실행 객체 얻기
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, moreInfoBean.getCname());
			pstmt.setInt(2, moreInfoBean.getWeek()); 
			pstmt.setInt(3, moreInfoBean.getSession()); 
			pstmt.setString(4, moreInfoBean.getTopic()); 		
			pstmt.setString(5, moreInfoBean.getWay()); 
			pstmt.setString(6, moreInfoBean.getDay()); 			
			pstmt.setInt(7, moreInfoBean.getStarttime());  
			pstmt.setInt(8, moreInfoBean.getEndtime());  			
			pstmt.setString(9, moreInfoBean.getHomework()); 
			pstmt.setString(10, moreInfoBean.getId());

			//insert문 실행
			return pstmt.executeUpdate();			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 freeResource();	
		}
		return 0;
		
	}//insertMI end

}

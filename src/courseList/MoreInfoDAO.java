package courseList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board_course.BoardBean;

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
				bean.setTime(rs.getString("time"));
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
		
		String sql = "select * from moreInfo where cname=?";	
		
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
				bean.setTime(rs.getString("time"));
				bean.setHomework(rs.getString("homework"));
		
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
}

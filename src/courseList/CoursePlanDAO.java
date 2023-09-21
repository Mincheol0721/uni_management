package courseList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CoursePlanDAO {

	//DB작업에 쓰일 객체들을 저장할 변수들
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	//DataSource 얻는 기능의 생성자
	public CoursePlanDAO() {
		
		try {
			
			//InitialContext객체 생성
			Context ctx = new InitialContext();
			
			//기본 경로 주소 설정
			Context envContext = (Context) ctx.lookup("java:comp/env");

			//DataSource커넥션풀 객체 찾아 반환
			ds = (DataSource) envContext.lookup("jdbc/studyplannerdb");
			
		} catch (Exception e) {
			System.out.println("CoursePlanDAO의 생성자 내부에서 커넥션풀 얻기 실패 : " + e.toString());
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
	
		//DB로부터 모든 강의들의 정보를 가져오는 메소드(조회)
		public ArrayList<CoursePlanBean> getPlan(String course) {
			
			//등록된 과목들을 담을 객체
			ArrayList<CoursePlanBean> list = new ArrayList<CoursePlanBean>();
			
			System.out.println("getPlan메소드가 받는 과목명: " + course);
			
			//쿼리를 담을 변수 선언
			String sql = "select * from cPlan where course=?";	
			
			try {
				
				//DB연결
				con = ds.getConnection();
				
				//DB에 쿼리문 문자열 전송
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, course);
		        
				//쿼리 실행
				rs = pstmt.executeQuery();
				
				//rs객체에 담겨있음 -> 컬렉션 객체에 담기
				while(rs.next()) {
					
					CoursePlanBean bean = new CoursePlanBean();
					
					//하나씩 저장
					bean.setCourse(rs.getString("course")); //과목명
				    bean.setDept(rs.getString("dept")); //학과
				    bean.setGrade(rs.getInt("grade")); //학점 1~3
				    bean.setTime(rs.getString("time"));  //시간
				    bean.setCompdiv(rs.getString("compdiv"));  //이수구분
				    bean.setCompyear(rs.getInt("compyear"));  //대상학년
				    bean.setCompsem(rs.getInt("compsem"));  //학기
				    bean.setEmail(rs.getString("email"));  //연락이메일
				    bean.setContent(rs.getString("content"));  //교과목 개요
				    bean.setPurpose(rs.getString("purpose"));  //교육목표
				    bean.setBooks(rs.getString("books"));  //주 교재	
					
					list.add(bean);
					
					//System.out.println("과목 정보 저장 완료");				
				}			
				
				System.out.println("강의 계획서 sql구문 실행 완료");
				
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("getPlan메소드 실행 오류 : " + e);
			} finally {
				 freeResource();
			}

			return list;
		
		}//조회 end	
		
		
		
}

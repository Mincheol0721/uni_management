package grade_professor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import courseList.CourseBean;
import courseList.MoreInfoBean;

public class GradePDAO {

	//DB작업에 쓰일 객체들을 저장할 변수들
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	//DataSource 얻는 기능의 생성자
	public GradePDAO() {
		
		try {
			
			//InitialContext객체 생성
			Context ctx = new InitialContext();
			
			//기본 경로 주소 설정
			Context envContext = (Context) ctx.lookup("java:comp/env");

			//DataSource커넥션풀 객체 찾아 반환
			ds = (DataSource) envContext.lookup("jdbc/studyplannerdb");
			
		} catch (Exception e) {
			System.out.println("GradePDAO의 생성자 내부에서 커넥션풀 얻기 실패 : " + e.toString());
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
		
	//DB로부터 본인의 모든 강의에 대한 학생들의 성적을 조회
	public ArrayList<GradeBean> getGrade() {
		
		//등록된 과목들을 담을 객체
		ArrayList<GradeBean> list = new ArrayList<GradeBean>();
		
		//쿼리를 담을 변수 선언
		String sql = "";	
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			//sql문
			sql = "SELECT c.ccode, c.cname, c.id AS propid, s.name AS student_name, ch.rate, ch.grade, s.id AS student_id " +
		             "FROM course c " +
		             "INNER JOIN cHistory ch ON c.ccode = ch.ccode " +
		             "INNER JOIN student s ON ch.id = s.id";


			//DB에 쿼리문 문자열 전송
			pstmt = con.prepareStatement(sql);
	        
			//쿼리 실행
			rs = pstmt.executeQuery();
			
			//rs객체에 담겨있음 -> 컬렉션 객체에 담기
			while(rs.next()) {
				
				GradeBean bean = new GradeBean();
				
				//하나씩 저장
				bean.setCcode(rs.getInt("ccode"));
				bean.setCname(rs.getString("cname"));
				bean.setId(rs.getString("student_id"));
				bean.setName(rs.getString("student_name"));
				bean.setGrade(rs.getInt("grade"));
				bean.setRate(rs.getString("rate"));
				bean.setPropId(rs.getString("propid"));
				
				list.add(bean);
									
			}			
			
			System.out.println("성적 조회 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 freeResource();
		}

		return list;
	
	}//조회 end	
	
	//점수와 등급을 0과 X로 초기화시키는 기능의 메소드
	public void resetGradeAndRate(int ccode, String id) {
		
		int grade = 0;
		String rate = "X";
		
		String sql = "UPDATE cHistory "
					+ "SET grade =?, rate =? "
					+ "WHERE ccode =? AND id =?;";
		try {
			
			//DB연결
			con = ds.getConnection();
	
			pstmt = con.prepareStatement(sql);		
			pstmt.setInt(1, grade);
			pstmt.setString(2, rate);
			pstmt.setInt(3, ccode);
			pstmt.setString(4, id);
			
			pstmt.executeUpdate();
						
			System.out.println("초기화 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("resetGradeAndRate메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
			
	}//resetGradeAndRate end
	
	//성적 수정을 위해 선택한 한 학생의 성적 정보를 modGrade.jsp에 뿌려주기 위해 리턴하는 메소드
	public GradeBean getModGrade(int ccode, String name, String id) {
		
		System.out.println("getModGrade메소드가 받는 과목코드: " + ccode);
		
		String sql = "SELECT c.ccode, c.cname, s.name, ch.rate, ch.grade, s.id " 
	             	+ "FROM course c " 
	             	+ "INNER JOIN cHistory ch ON c.ccode = ch.ccode " 
	             	+ "INNER JOIN student s ON ch.id = s.id " 
	             	+ "WHERE c.ccode = ? " 
	             	+ "AND s.name = ? " 
	             	+ "AND s.id = ?;";

		
		GradeBean bean = new GradeBean();
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(sql);
			
			//DB에 전달할 ?값 세팅
			pstmt.setInt(1, ccode);
			pstmt.setString(2, name);
			pstmt.setString(3, id);
			
			rs = pstmt.executeQuery();
						
			if (rs.next()) {

				bean.setCcode(rs.getInt("ccode"));
				bean.setCname(rs.getString("cname"));
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setGrade(rs.getInt("grade"));
				bean.setRate(rs.getString("rate"));								
			}	
			
			System.out.println("성적 수정할 행의 정보를 불러오는 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getModGrade메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
		
		return bean;

	}//getModGrade end

	
	//성적을 수정하는 기능의 메소드
	public void modifyGrade(GradeBean bean) {			
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			String sql = "UPDATE cHistory "
						+ "SET rate =?, grade =? "
						+ "WHERE ccode =? "
						+ "AND id =?;";
			
			pstmt = con.prepareStatement(sql);
								
			pstmt.setString(1, bean.getRate());
			pstmt.setInt(2, bean.getGrade());
			pstmt.setInt(3, bean.getCcode());
			pstmt.setString(4, bean.getId());

	
			
			pstmt.executeUpdate();
			
			System.out.println("성적 수정 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("modifyGrade메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
		
	}//modifyGrade end
	

	
		
}

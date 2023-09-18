package grade;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//DAO(DB연결 후 DB작업하는 클래스)
public class GradeDAO {

	//DB작업에 쓰일 객체들을 저장할 변수들
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
		
	//DataSource 얻는 기능의 생성자
	public GradeDAO() {
		
		try {
			
			//InitialContext객체 생성
			Context ctx = new InitialContext();
			
			//기본 경로 주소 설정
			Context envContext = (Context) ctx.lookup("java:comp/env");

			//DataSource커넥션풀 객체 찾아 반환
			ds = (DataSource) envContext.lookup("jdbc/studyplannerdb");
			
		} catch (Exception e) {
			System.out.println("GradeDAO의 생성자 내부에서 커넥션풀 얻기 실패 : " + e.toString());
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
	
	
}

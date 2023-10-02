package homework;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import courseList.CourseBean;

public class HomeworkProfessorDAO {

	//DB작업에 쓰일 객체들을 저장할 변수들
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	//DataSource 얻는 기능의 생성자
	public HomeworkProfessorDAO() {
		
		try {
			
			//InitialContext객체 생성
			Context ctx = new InitialContext();
			
			//기본 경로 주소 설정
			Context envContext = (Context) ctx.lookup("java:comp/env");

			//DataSource커넥션풀 객체 찾아 반환
			ds = (DataSource) envContext.lookup("jdbc/studyplannerdb");
			
		} catch (Exception e) {
			System.out.println("HomeworkProfessorDAO의 생성자 내부에서 커넥션풀 얻기 실패 : " + e.toString());
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
		
	//DB로부터 해당 과제의 설정 내용을 불러오는 메소드
	public HomeWorkBoardDTO getHWList(String cname, int week, int sess) {
		
		String sql = "select * from homeworkboard where tasktitle=" 
				 	+ "(select homework from moreInfo where cname=? and week=? and session=?);";
		
		HomeWorkBoardDTO dto = new HomeWorkBoardDTO();
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			System.out.println("str: " + cname);
			System.out.println("week: " + week);
			System.out.println("sess: " + sess);
			
			//DB에 쿼리문 문자열 전송
			pstmt = con.prepareStatement(sql);
	        
			pstmt.setString(1, cname);
			pstmt.setInt(2, week);
			pstmt.setInt(3, sess);					
			
			//쿼리 실행
			rs = pstmt.executeQuery();
			
			//rs객체에 담겨있음 -> 컬렉션 객체에 담기
			if(rs.next()) {
				
				//하나씩 저장
				dto.setCname(rs.getString("cname"));
				dto.setTasktype(rs.getString("tasktype"));
				dto.setTasktitle(rs.getString("tasktitle"));
				dto.setTaskmethod(rs.getString("taskmethod"));
				dto.setPeriod(rs.getString("period"));		
				
			}		
			
			System.out.println("과제 조회 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 freeResource();
		}

		return dto;
	
	}//조회 end	
		
		
		
	
}

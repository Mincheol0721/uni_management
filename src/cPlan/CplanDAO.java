package cPlan;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import courseList.MoreInfoBean;

public class CplanDAO {
	
	
	// 데이터베이스 작업관련 객체들을 저장할 변수들
		DataSource ds;// 커넥션풀 역할을 하는 DataSouce객체의 주소를 저장할 변수
		Connection con; // 커넥션풀에 미리 만들어 놓고 DB와의 접속이 필요하면 빌려와서 사용할 DB접속정보를 가지고 있는 Connection객체의 주소를 저장할
						// 변수
		PreparedStatement pstmt;// 생성한 SQL문을 DB에 전송해서 실행할 역할을하는 PreparedStatement실행객체의 주소를 저장할 변수
		ResultSet rs;// DB의 테이블에 저장된 정보를 조회한 결과를 임시로 얻기 위한 ResultSet객체 메모리의 주소를 저장할 변수

		// 커넥션풀 생성 및 커넥션 객체를 얻어 커넥션객체자체를 반환 하는 기능의 메소드
		private Connection getConnection() throws Exception {

			// 1. InitialContext객체 생성
			// 생성하는 이유는 자바의 네이밍 서비스(JNDI)에서 이름과 실제 객체를 연결해주는 개념이 Context이며,
			// InitialContext객체는 네이밍 서비스를 이용하기위한 시작점입니다.
			Context initCtx = new InitialContext();
			// 2. "java:comp/env"라는 주소를 전달하여 Context객체를 얻었습니다.
			// "java:comp/env" 주소는 현재 웹 애플리케이션의 루트 디렉터리 라고 생각 하면됩니다.
			// 즉! 현재 웹애플리케이션이 사용할수 있는 모든 자원은 "java:comp/env"아래에
			// 위치합니다.(<Context></Context/>이위치를 말합니다.)
			Context ctx = (Context) initCtx.lookup("java:comp/env");
			// 3. "java:comp/env 경로 아래에 위치한 "jdbc/studyplannerdb" Recource태그의
			// DataSource커넥션풀을 얻는다
			ds = (DataSource) ctx.lookup("jdbc/studyplannerdb");
			// 4. 마지막으로 커넥션풀(DataSouce)객체 메모리 에 저장된 Connection객체를 반환받아 사용
			con = ds.getConnection();
			return con;
		}

		// DB연결후 작업하는 객체들 사용후 자원해제할 공통으로 쓰이는 메소드
		public void freeResource() {
			try {
				if (pstmt != null)
					pstmt.close();
				if (rs != null)
					rs.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		
		public CplanDTO selectBoard(String cnam) {
			
			CplanDTO cPlanDTO = null;
			try {
				//DB연결
				con = getConnection();
				
				//sql문 작성
				String sql = "select * from cplan where cname =?";
				
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, cnam);
					
					rs = pstmt.executeQuery();
				
					if (rs.next()) {
						String cname = rs.getString("cname");
						String dept = rs.getString("dept");
						int grade = rs.getInt("grade");
						String time = rs.getString("time");
						String compdiv = rs.getString("compdiv");
						int compyear = rs.getInt("compyear");
						int compsem = rs.getInt("compsem");
						String email = rs.getString("email");
						String content = rs.getString("content");
						String purpose = rs.getString("purpose");
						String books = rs.getString("books");
						
						 cPlanDTO = new CplanDTO(cname, dept, grade, time, compdiv, compyear, compsem, email, content, purpose, books);
					}
					
			} catch (Exception e) {
				System.out.println("cPlanDAO클래스의 selectBoard메소드의 sql문 오류 발생" + e);
			}finally {
				freeResource();
			}
			return cPlanDTO;
		}
		
	public int getCount(String cname) {
		int count = 0;
		try {
			//db연결
			con = getConnection();
			//sql문 작성
			String sql = "select count(*) from cplan where cname =?";
			
			pstmt = con.prepareStatement(sql);
				pstmt.setString(1, cname);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
				
			
			
		} catch (Exception e) {
			System.out.println("cPlanDAO클래스의 getCount 메소드에서 sql문 오류 발생" + e);
		}finally {
			freeResource();
		}
		return count;
	}
	
	//강의리스트 화면에서 강의 계획서를 눌렀을때 누른 과목의 수강내역을 확인하는 메소드
	public int cHistoryCheck(String id, String cname) {
		int check = 0;
		try {
			//DB연결
			con = getConnection();
			//sql문 작성
			String sql = "select count(*) \n" + 
					"					from chistory \n" + 
					"					join course\n" + 
					"					on course.ccode = chistory.ccode\n" + 
					"					where chistory.id = ? and course.cname = ?";
				
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, cname);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				check = rs.getInt(1);
			}else {
				check = 0;
			}
		} catch (Exception e) {
			System.out.println("cPlanDAO클래스의 cHistoryCheck메소드의 sql문 오류 발생" + e);
		}finally {
			freeResource();
		}
		return check;
	}
	
	//cPlan 수정하는 기능의 메소드
	public void modifyCplan(CplanDTO dto) {			
		
		try {
			
			//DB연결
			con = getConnection();
			String sql = "update cPlan set time=?, books=?, purpose=? where cname=? and compdiv=?";
			pstmt = con.prepareStatement(sql);
			
//			System.out.println("MOD타는중... cname=" + bean.getCname());
								
			pstmt.setString(1, dto.getTime());
			pstmt.setString(2, dto.getBooks());
			pstmt.setString(3, dto.getPurpose());
			pstmt.setString(4, dto.getCname());
			pstmt.setString(5, dto.getCompdiv());
	
			pstmt.executeUpdate();
			
			System.out.println("cPlan 수정 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("modifyCplan메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
		
	}//modifyCplan end
	
	
	
	//강의리스트 화면에서 강의 계획서를 눌렀을때 누른 과목의 수강내역을 확인하는 메소드
	public int cHistoryPCheck(String id, String cname) {
		int check = 0;
		try {
			//DB연결
			con = getConnection();
			//sql문 작성
			String sql = "select count(*) \n" + 
					"					from chistory \n" + 
					"					join course\n" + 
					"					on course.ccode = chistory.ccode\n" + 
					"					where course.id = ? and course.cname = ?";
				
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, cname);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				check = rs.getInt(1);
			}else {
				check = 0;
			}
		} catch (Exception e) {
			System.out.println("cPlanDAO클래스의 cHistoryPCheck메소드의 sql문 오류 발생" + e);
		}finally {
			freeResource();
		}
		return check;
	}
}

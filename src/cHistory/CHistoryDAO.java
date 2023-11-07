package cHistory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.mail.Session;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import course.CourseVO;

public class CHistoryDAO {

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

	// 강의내역테이블과 강의내역테이블을 join해서 조회할 메소드
	public List<CourseVO> getBoardList(String id) {
		// int startRow, int pageSize
		List<CourseVO> boardList = new ArrayList<CourseVO>(); // 배열

		try {
			// DB연결
			con = getConnection();

			// SELECT 구문 만들기
			String sql = "select chistory.ccode,course.cname,course.compdiv,course.compyear,course.compsem,course.grade,course.professor,course.startTime,course.endTime,course.day \r\n"
					+ "from chistory\r\n" 
					+ "join course\r\n" 
					+ "on course.ccode = chistory.ccode\r\n"
					+ "where chistory.id = ?;";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// ResultSet에서 꺼내와서 CourceVO객체에 한줄 단위로 저장
				int ccode = rs.getInt("ccode");
				String cname = rs.getString("cname"); // 조회한 전공
				String compdiv = rs.getString("compdiv");// 조회한 학년
				int compyear = rs.getInt("compyear");// 조회한 학점
				int compsem = rs.getInt("compsem");// 조회한 학기
				int grade = rs.getInt("grade"); // 조회한 성적
				String professor = rs.getString("professor"); // 조회한 담당교수
				String startTime = rs.getString("starttime");
				String endTime = rs.getString("endTime");
				String day = rs.getString("day");
				
				CourseVO bfbb = new CourseVO(ccode,cname, compdiv, compyear, compsem, grade, professor,startTime,endTime,day);

				boardList.add(bfbb);// ArrayList배열에 추가

			} // while

		} catch (Exception e) {
			System.out.println("cHistoryDAO의 getBoardList메소드 내부에서 sql문 실행 오류" + e);
		} finally {
			// DB와 관련작업하는 객체 메모리들 사용후 자원해제
			freeResource();
		}

		return boardList;// ReferenceNotice.jsp로 ArrayList배열 반환
	}

	// lecture 페이지에서 수강신청을 눌렀을떄 insert할 메소드

	public void insertBoard(String id, String Ccode, String rate) {
		
		rate = "-";
		
		try {
			// 1. 커넥션풀에서 커넥션 객체 빌려오기
			con = getConnection();

			String sql = "insert into chistory(id,ccode,rate) values(?,?,?);";

			// PreparedStatement객체 얻기
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, Ccode);
			pstmt.setString(3, rate);
			

			// insert문 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("cHistoryDAO의 inserBoard메소드 내부에서 SQL문 실행오류 : " + e.toString());

		} finally {
			// 자원해제
			freeResource();
		}
	}// insertBoard메소드 끝
	
	public int checked(String Ccode) {
		
		int check = 0;
		
		try {
			//커넥션풀에서 커넥션 객체 빌려오기
			con = getConnection();
			
			//sql문 작성
			String sql = "select * FROM chistory WHERE Ccode=?";
			
			pstmt = con.prepareStatement(sql);
			
			//pstmt.setString(1, id);
			pstmt.setString(1, Ccode);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if(Ccode.equals(rs.getString("Ccode")))
				check = 1;
			}else {
				check = 0;
			}
		} catch (Exception e) {
			System.out.println("cHistoryDAO의 checked메소드 내부에서 SQL문 실행오류 : " + e.toString());
		}finally {
			freeResource();
		}
		return check;
	}
	
	
	// 강의 개설 테이블에서 삭제를 처리할 메소드
	public void deleteBoard(String id, String Ccode) {

		try {
			// 1. 커넥션풀에서 커넥션 객체 빌려오기
			con = getConnection();

			String sql = "delete from chistory where id =? and Ccode =? and grade is null;";

			// PreparedStatement객체 얻기
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, Ccode);

			// insert문 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("cHistoryDAO의 inserBoard메소드 내부에서 SQL문 실행오류 : " + e);

		} finally {
			// 자원해제
			freeResource();
		}
	}// insertBoard메소드 끝
	
	// 이메일보내기를 눌렀을때 누른 이벤트에 해당하는 교수의 이메일 조회해오는 메소드
	public String selectProfessorEmail(String id,String professorName) {
			String email = null;
		try {
			//커넥션풀에서 커넥션 객체 빌려오기
			con = getConnection();
			
			String sql = "select professor.email\r\n"
					+ "						from course\r\n"
					+ "						join chistory\r\n"
					+ "						on course.ccode = chistory.ccode\r\n"
					+ "                        join professor\r\n"
					+ "                        on course.professor = professor.name\r\n"
					+ "						where chistory.grade is not null and chistory.id =? and course.professor = ?\r\n"
					+ "                        limit 1;";
					
				pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, professorName);
					
					rs = pstmt.executeQuery();
				if(rs.next()) {
					email = rs.getString(1);
				}
			
		} catch (Exception e) {
			System.out.println("cHistoryDAO클래스의 selectProfessorEmail메소드에서 sql문 오류" + e);
			
		}finally {
			freeResource();
		}
		
		return email;
	}
}// class의 마지막

package course;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;




public class CourseDAO {
	
	//데이터베이스 작업관련 객체들을 저장할 변수들
			DataSource ds;//커넥션풀 역할을 하는 DataSouce객체의 주소를 저장할 변수 
			Connection con; //커넥션풀에 미리 만들어 놓고 DB와의 접속이 필요하면 빌려와서 사용할 DB접속정보를 가지고 있는 Connection객체의 주소를 저장할 변수 
			PreparedStatement pstmt;//생성한 SQL문을 DB에 전송해서 실행할 역할을하는 PreparedStatement실행객체의 주소를 저장할 변수 
			ResultSet rs;//DB의 테이블에 저장된 정보를 조회한 결과를 임시로 얻기 위한 ResultSet객체 메모리의 주소를 저장할 변수 
			
			//커넥션풀 생성 및 커넥션 객체를 얻어 커넥션객체자체를 반환 하는  기능의 메소드 
			private Connection getConnection() throws Exception {
				
				//1. InitialContext객체 생성
				//생성하는 이유는  자바의 네이밍 서비스(JNDI)에서 이름과 실제 객체를 연결해주는 개념이 Context이며,
				//InitialContext객체는 네이밍 서비스를 이용하기위한 시작점입니다.
				Context initCtx = new InitialContext();
				//2. "java:comp/env"라는 주소를 전달하여  Context객체를 얻었습니다.
				//"java:comp/env" 주소는 현재 웹 애플리케이션의 루트 디렉터리 라고 생각 하면됩니다.
				//즉! 현재 웹애플리케이션이 사용할수 있는 모든 자원은 "java:comp/env"아래에 위치합니다.(<Context></Context/>이위치를 말합니다.)
				Context ctx = (Context)initCtx.lookup("java:comp/env");
				//3. "java:comp/env 경로 아래에 위치한  "jdbc/studyplannerdb" Recource태그의  DataSource커넥션풀을 얻는다
				ds = (DataSource)ctx.lookup("jdbc/studyplannerdb");		 
				//4. 마지막으로 커넥션풀(DataSouce)객체 메모리 에 저장된 Connection객체를 반환받아 사용
				con = ds.getConnection();
				return con;
			}
		

		//DB연결후 작업하는 객체들 사용후 자원해제할 공통으로 쓰이는 메소드
		public void freeResource() {
			try {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				if(con != null) con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		//studyplannerdb데이터베이스의 cource게시판테이블에  저장된
		//지정한 갯수 만큼 글목록을 조회 하여 반환 하는 메소드 
		public List<CourseVO>  getBoardList(String id,int startRow, int pageSize){
			//int startRow, int pageSize
			List<CourseVO> boardList = new ArrayList<CourseVO>(); //배열
			System.out.println(startRow);
			System.out.println(pageSize);
			try {
				//DB연결
				con = getConnection();
				
				//SELECT 구문 만들기
				//참고. select 구문에 limit이라는 구문이 있습니다.
				
				String sql  = "select c.* from course c where c.ccode not in(\n" + 
						"select chistory.ccode\n" + 
						"					from chistory \n" + 
						"					join course \n" + 
						"					on course.ccode = chistory.ccode\n" + 
						"					where chistory.id = ?  \n" + 
						")\n" + 
						"limit ?,?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, id);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, pageSize);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					//ResultSet에서 꺼내와서 CourceVO객체에 한줄 단위로 저장
					int ccode = rs.getInt("ccode");//조회한 과목코드
					String cname = rs.getString("cname"); //조회한 전공
					String compdiv = rs.getString("compdiv");//조회한 학년
					int compyear = rs.getInt("compyear");//조회한 학점
					int compsem = rs.getInt("compsem");
					int grade = rs.getInt("grade"); // 조회한 성적
					String professor = rs.getString("professor");//조회한 담당교수
					String startTime = rs.getString("starttime");
					String endTime = rs.getString("endTime");
					String day = rs.getString("day");
					
					CourseVO bfbb = new CourseVO(ccode,cname,compdiv,compyear,compsem,grade,professor,startTime,endTime,day);
																
									  
					boardList.add(bfbb);//ArrayList배열에  추가
					
				}//while
				
			} catch (Exception e) {
				System.out.println("CourseDAO의 getBoardlist메소드 내부에서 sql문 실행 오류"+e);
			} finally {
				//DB와 관련작업하는 객체 메모리들 사용후 자원해제
				freeResource();
			}
		
			return boardList;//ReferenceNotice.jsp로 ArrayList배열 반환
		}
		
		public int getBoardCount(String id) {
			int count = 0;
		try {
			//DB연결
			con = getConnection();
			
			// sql문 작성 LectureBoard 테이블의 모든 글개수 가져오기
			String sql = "select count(*) from course c where c.ccode not in( \n" + 
					"						select chistory.ccode \n" + 
					"											from chistory  \n" + 
					"											join course  \n" + 
					"											on course.ccode = chistory.ccode \n" + 
					"											where chistory.id = ?  \n" + 
					"						)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //만약 조회해서 글개수가 있으면
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("LectureDAO클래스의 getBoardCount메소드의 sql문 오류" + e);
		}finally {
			//자원해제
			freeResource();
		}
		return count;
	}
}

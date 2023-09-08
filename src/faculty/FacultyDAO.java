package faculty;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FacultyDAO {
	
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
	
	public void freeResource() {
		//6.자원해제
		try {
			if(pstmt != null) {
				pstmt.close();
			}
			if(rs != null) {
				rs.close();
			}
			if(con != null) {
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public ArrayList fList() {
		
		
		ArrayList list = new ArrayList();		
		
		String sql = "";
		
		try {
			getConnection();
			
			sql = "select * from faculty order by fcode";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				FacultyDTO dto = new FacultyDTO();
				
				dto.setFcode(rs.getInt("fcode"));
				dto.setFname(rs.getString("fname"));
				
				list.add(dto);
			}
			
			
		} catch (Exception e) {
			System.out.println("FacultyDAO의 fList메소드 내부에서 예외발생: " + e);
		} finally {
			freeResource();
		}
		
		
		return list;
	}
	
	public int getFcode(String fname) {
		DeptDTO dto = new DeptDTO();
		
		int fcode = 0;
		
		String sql = "";
		
		try {
			getConnection();
			
			sql = "select fcode from faculty where fname=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fname);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				fcode = rs.getInt("fcode");
			}
			
			
			
		} catch (Exception e) {
			System.out.println("FacultyDAO의 getFcode메소드 내부에서 예외발생: " + e);
		} finally {
			freeResource();
		}
		
		return fcode;
	}
	
	
	
		
}

package schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ScheduleDAO {
	//DB작업에 쓰일 객체들을 저장할 변수들
		private DataSource ds;	//커넥션풀 DataSource 저장할 변수
		private Connection con;	
		private PreparedStatement pstmt;
		private ResultSet rs;
		private String sql;
		
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
		
		//DB연결 후 작업하는 객체들 사용 후 자원해제할 공통으로 쓰이는 메소드
		public void freeResource() {
			try {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				if(con != null) con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		public List<ScheduleDTO> getScheduleList(){
			List<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
			
			try {
				con = getConnection();
				String sql = "select * from bschedule";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ScheduleDTO dto = new ScheduleDTO();
					
					dto.setNo(rs.getInt("no"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setWriteDate(rs.getDate("writeDate"));
					dto.setSclass(rs.getString("sclass"));
					dto.setId(rs.getString("id"));
					dto.setSdate(rs.getString("sdate"));
					
					list.add(dto);
				}
				
			} catch (Exception e) {
				System.out.println("ScheduleDAO내부 getScheduleList메소드에서 쿼리 실행 오류: " + e);
			} finally {
				freeResource();
			}
			
			return list;
		}
}

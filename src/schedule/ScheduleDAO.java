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
				String sql = "select * from bschedule order by no asc limit 5";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ScheduleDTO dto = new ScheduleDTO();
					
					dto.setNo(rs.getInt("no"));
					dto.setTitle(rs.getString("title"));
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
		
		public List<ScheduleDTO> getSClass(){
			List<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
			
			try {
				con = getConnection();
				String sql = "select clsname as sclass from boardclass";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
//				System.out.println("sql문: " + sql);
				
				while(rs.next()) {
					ScheduleDTO dto = new ScheduleDTO();
					
					dto.setSclass( rs.getString("sclass") );
					
					list.add(dto);
				}
//				System.out.println("dto.getSclass: " + list.get(0).getSclass());
//				System.out.println("dto.getSclass: " + list.get(1).getSclass());
//				System.out.println("dto.getSclass: " + list.get(2).getSclass());
//				System.out.println("dto.getSclass: " + list.get(3).getSclass());
//				System.out.println("list.get(): " + list.get(0));
//				System.out.println("list.get(): " + list.get(1));
//				System.out.println("list.get(): " + list.get(2));
//				System.out.println("list.get(): " + list.get(3));
				
			} catch (Exception e) {
				System.out.println("ScheduleDAO내부 getSClass메소드에서 쿼리문 실행 오류: " + e);
			} finally {
				freeResource();
			}
			
			return list;
		}
		
		//게시판의 새 글 정보를 DB의 board테이블에 추가하는 기능의 메소드
		public void insertBoard(ScheduleDTO dto, String sdate) {
			
			try {
				//1. 커넥션풀에서 커넥션 객체 빌려오기
				con = getConnection();
				//insert문 작성
				sql = "insert into bschedule (title, writeDate, sclass, id, sdate) " + 
							"values(?, now(), ?, ?, ?)";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, dto.getTitle());
				pstmt.setString(2, dto.getSclass());
				pstmt.setString(3, dto.getId());
				pstmt.setString(4, sdate);
				
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("ScheduleDAO의 insertBoard메소드 내부에서 쿼리문 실행오류: " + e.toString());
			} finally {
				//자원해제
				freeResource();
			}
			
		}//insertBoard메소드 끝
		
		public List<String> getSdate() {
			List<String> list = new ArrayList<String>();
			String sdate = null;
			
			try {
				con = getConnection();
				String sql = "select sdate from bschedule ";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					sdate = rs.getString("sdate");
					
					list.add(sdate);
				}
				
			} catch (Exception e) {
				System.out.println("ScheduleDAO의 getSdate메소드 내부에서 쿼리 실행 오류: " + e);
			} finally {
				freeResource();
			}
			
			return list;
		}
		
		public ScheduleDTO getTitle(String sdate) {
			ScheduleDTO dto = null;
//			System.out.println("getTitle메소드 sdate: " + sdate);
			try {
				con = getConnection();
				String sql = "select * from bschedule where sdate=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, sdate);
//				System.out.println("sql문 : " + sql);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto = new ScheduleDTO();
					
					dto.setNo(rs.getInt("no"));
					dto.setId(rs.getString("id"));
					dto.setTitle(rs.getString("title"));
					dto.setSclass(rs.getString("sclass"));
					dto.setSdate(rs.getString("sdate"));
				}
				
//				System.out.println("title: " + title);
				
			} catch (Exception e) {
				System.out.println("ScheduleDAO의 getTitle메소드 내부에서 쿼리 실행 오류: " + e);
			} finally {
				freeResource();
			}
			
			return dto;
		}
		
		//bnotice테이블에 저장된 레코드의 개수를 반환하는 메소드
		public int getBoardCount(int year, int month) {
			int count = 0;
			
			try {
				con = getConnection();
				
				sql = "select count(*) from bschedule where sdate like '" + year + "-";
				if(month < 10) {
					sql += "0"; 
				} 
				sql += month + "%'";
				
//				System.out.println("getBoardCount.year: " + year);
//				System.out.println("getBoardCount.month: " + month);
				
				pstmt = con.prepareStatement(sql);
				
//				System.out.println("sql문: " + sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
			} catch (Exception e) {
				System.out.println("ScheduleDAO내부의 getBoardCount메소드에서 예외 발생: " + e);
			} finally {
				freeResource();
			}
			
			return count;
		} 
		
		//startRow, pageSize를 매개변수로 받아 글 정보를 ArrayList에 담은 후 리턴하는 메소드
		public List<ScheduleDTO> getScheduleList(int startRow, int pageSize, int year, int month) { 
			
			List<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
			
			System.out.println("startRow: " + startRow);
			System.out.println("pageSize: " + pageSize);
			
			try {
				//1. 커넥션풀(DataSource)에서 DB와 미리 연결 맺은 접속정보를 갖고있는 커넥션 객체 빌려오기
				//DB와의 연결
				con = getConnection();
				//2. SELECT문장을 만들어 PreparedStatement실행객체에 로드 후 얻기
				//SELECT문장 → 글번호에 해당하는 글을 조회하는 SELECT문장 만들기
				sql = "select * from bschedule where sdate like '" + year + "-";
				if(month < 10) {
					sql += "0";
				}
				sql += month + "%' order by no asc limit ?, ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				
//				System.out.println("getSchedulList(4) sql문: " + sql);
				
				//3. rs에 sql문 실행 후 결과 담기
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					ScheduleDTO dto = new ScheduleDTO();
					
					dto.setNo( rs.getInt("no") );
					dto.setTitle( rs.getString("title") );
					dto.setSclass( rs.getString("sclass") );
					dto.setSdate( rs.getString("sdate") );
					dto.setWriteDate( rs.getDate("writeDate") );
					dto.setId( rs.getString("id") );
					
					list.add(dto);
					
				}
				
				
			} catch (Exception e) {
				System.out.println("ScheduleDAO내부의 getScheduleList메소드 내부에서 쿼리문 실행 오류: " + e);
			} finally {
				freeResource();
			}
			
			return list; //글제목 클릭 시 전달한 글번호에 해당되는 글의 정보를 NoticeDTO객체에 담아서 NoticeDTO객체 자체를 반환
		}
		
		public String idCheck(int no) {
			String checked_id = null;
			
			try {
				con = getConnection();
				
				String sql = "select id from bschedule where no=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, no);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					checked_id = rs.getString("id");
				}
				
			} catch (Exception e) {
				System.out.println("ScheduleDAO내부의 idCheck메소드에서 쿼리문 실행 오류: " + e);
			} finally {
				freeResource();
			}
			
			
			return checked_id;
		}
		
		public ScheduleDTO getSchedule(int no) {
			ScheduleDTO dto = null;
			
			try {
				con = getConnection();
				String sql = "select * from bschedule where no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, no);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dto = new ScheduleDTO();
					
					dto.setId(rs.getString("id"));
					dto.setSclass(rs.getString("sclass"));
					dto.setSdate(rs.getString("sdate"));
					dto.setTitle(rs.getString("title"));
				}
				
			} catch (Exception e) {
				System.out.println("ScheduleDAO내부의 getSchedule메소드에서 쿼리문 실행 오류: " + e);
			} finally {
				freeResource();
			}
			
			return dto;
		}
		
		public void deleteSchedule(int no) {
			
			try {
				//1. DB와의 연결(커넥션풀에서 커넥션객체 빌려오기)
				con = getConnection();
				//2. board테이블의 삭제할 글이 no열에 저장된 글 번호가 ?와 일치하고
				//   passwd열에 저장된 비밀번호가 입력한 삭제할 글 번호 ?와 일치하며,
				//   member테이블의 id열에 저장된 글을 작성한 사람의 아이디 값이 ?일때만
				//   해당 글 하나 삭제시키는 sql문 작성
				sql = "DELETE FROM bschedule WHERE no = ?";
				//3. PreparedStatement객체 얻기
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, no); //삭제할 글 번호를 매개변수 no으로 설정
				//4. DELETE구문 전체 실행
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("ScheduleDAO의 deleteBoard내부에서 쿼리문 실행 오류: " + e);
			} finally {
				//자원해제
				freeResource();
			}
			
		}
		
		//UPDATE구문 완성 후 글의 정보를 수정
		public void updateBoard(ScheduleDTO dto) {
			
			try {
				//1. 커넥션풀에서 커넥션 객체 빌려오기
				//DB와의 접속
				con = getConnection();
				//2. UPDATE문 만들기
				//→ 매개변수로 전달받은 NoticeDTO객체에 저장된 no 변수의 수정할 글 번호에 해당되는 글 수정을 위해 입력한
				//  글 제목, 글 내용을 수정하는 UPDATE구문 만들기
				sql = "UPDATE bschedule SET title=?, sclass=? WHERE no=?";
				//3. PreparedStatement실행객체 얻기
				pstmt = con.prepareStatement(sql);
				//3.1  ?에 대응되는 값 설정
				pstmt.setString(1, dto.getTitle()); //글 제목
				pstmt.setString(2, dto.getSclass()); //글 대분류
				pstmt.setInt(3, dto.getNo()); //글 번호
				//4. UPDATE문 실행
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("ScheduleDAO내부의 updateBoard 메소드 내부에서 쿼리문 실행 오류: " + e);
			} finally {
				//자원해제
				freeResource();
			}
			
		}
		
}//ScheduleDAO

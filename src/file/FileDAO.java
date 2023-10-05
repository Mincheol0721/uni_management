package file;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//DB의 테이블과 연결해서 작업하는 클래스 
public class FileDAO {
	
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
	
	//서버 upload폴더 경로에 업로드된 실제파일명 과 원본파일명을 DB의 file테이브르에 INSERT시키는 메소드
	public int upload( String TaskTitle,String cname,String studentName, String title, String content, String fileName, String fileRealName) {
						//    과목                 과제제목                 	학생이름                     비밀번호                글제목                         본문    			원본파일명,        실제업로드된 파일명
		
		
		
		String sql = "INSERT INTO homeWork(taskTitle,cname,studentName,title,content,fileName,fileRealName,date,homeworkOk) VALUES(?,?,?,?,?,?,?,current_timestamp(),1)"; 
		
		try {
				con = getConnection();
			
				//PreparedStatement실행객체 얻어 저장
				pstmt = con.prepareStatement(sql);
				//? 설정
				pstmt.setString(1, TaskTitle); //서버에 업로드요청시 선택한 과제제목
				pstmt.setString(2, cname);
				pstmt.setString(3, studentName);// 학생이름
			
				pstmt.setString(4, title);
				pstmt.setString(5, content);
				pstmt.setString(6, fileName);
				pstmt.setString(7, fileRealName);
				
				
				return pstmt.executeUpdate(); //insert에 성공하면 1을 반환해서 또 반환  실패하면 0을 반환 후 또 반환 
				
		} catch (Exception e) {
			System.out.println("FileDAO클래스의 upload메소드 sql문 오류" + e);
		}finally {
			freeResource();
		}
		
		return -1; //insert에 실패하면 -1을 반환
	}
	
	
	//다운로드할 파일명들을 DB로부터 검색해서 가져와 각각 FileDTO객체의 변수에 저장한 후  최종적으로 ArrayList가변길이 배열에 담아 반환하는 메소드
	public ArrayList<FileDTO>  AllSelect(){
		
		//가변길이 배열
		ArrayList<FileDTO>  list = new ArrayList<FileDTO>();
		
		//DB의 File테이블에 저장된 모든 업로드한 파일의 정보 조회
		String sql = "SELECT * FROM homework";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			//while반복문을 이용해 ResultSet객체의 커서의 위치를 한줄 내려 조회된 파일목록이 있으면 
			//반복해서 ResultSet에서 꺼내와서 한줄 단위로 FileDTO객체에 저장
			//그리고 저장된 FileDTO객체를 반복해서 ArrayList배열에 추가 
			while(rs.next()) {
				//ResultSet객체에 저장된 검색한 파일정보 한행씩 꺼내어서  FileDTO객체의 변수에 저장
				FileDTO dto = new FileDTO(rs.getString("FILENAME"), rs.getString("FILEREALNAME"),rs.getInt("DOWNLOADCOUNT"));
				
				//ArrayList배열에 add메소드 이용해 바로위 FileDTO객체를 하나씩 추가 
				list.add(dto);
			}
		}catch (Exception e) {
			e.printStackTrace();//예외가 발생하면 예외 메세지 이클립스 콘솔창에 출력
		}
		
		return list;//fileDownloadList.jsp페이지로 배열 리턴 
		
	}
	
	
	//사용자가 파일을 다운로스 시킬때마다 다운로드한 횟수를 DB에 UPDATE하기 위한 메소드
	public int hit(String fileRealName) { //다운로드한 파일의 실제 이름을 매개변수로 전달 받기
		
		//사용자가 파일을 다운로드할떄마다 다운로드한 파일의 다운로드 횟수 1증가 시키는 UPDATE구문 만들기
		String sql = "UPDATE FILE SET downloadCount=downloadCount+1 "
				   + "WHERE fileRealName = ?";
		
		try {
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1, fileRealName); //실제 톰캣서버의 upload폴더에 업로드되어 올라가 있는 다운로드한 실제 파일명 설정
			 return pstmt.executeUpdate();//파일 다운로드 횟수 1증가에 성공하면 1을 반환
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //파일 다운로드 횟수 1증가에 실패 하면 -1을 반환
	}
	
	public int updateFile(String title, String content, String fileName, String fileRealName, String num) {
		int check = -1;
		try {
			//DB연결
			con = getConnection();
			//sql문 작성
			String sql = "update homework set title = ?, content = ?, fileName = ?, fileRealName = ? where num = ?"; 
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, fileName);
			pstmt.setString(4, fileRealName);
			pstmt.setString(5, num);
			
			check = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("FileDAO클래스 updateFile메소드의 sql문 오류 발생" + e);
		}finally {
			freeResource();
		}
		return check;
	}
	
	// 물리적인 파일 삭제하기위해 서치하는 메소드
			public String deleteSearch(String num) {
				String sql = null;
				String fileName = null;
				try {
					//DB연결
					con= getConnection();
					//sql문 작성
					sql = "select fileRealName from homework where num = ?";
					
					pstmt = con.prepareStatement(sql);
						pstmt.setString(1, num);
						rs = pstmt.executeQuery();
						
						if (rs.next()) {
							fileName = rs.getString(1);
						}
						
				} catch (Exception e) {
					System.out.println("HomeWorkDAO클래스의 deleteHomework메소드의 sql문 오류" + e);
				}finally {
					freeResource();
				}
				return fileName;
			}
	
}










package homework;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class HomeWorkDAO {
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


	public int getBoardCount() {
			int count = 0;
		try {
			//DB연결
			con = getConnection();
			
			// sql문 작성 LectureBoard 테이블의 모든 글개수 가져오기
			String sql = "select count(*) from homework";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //만약 조회해서 글개수가 있으면
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("HomeWorkDAO클래스의 getBoardCount메소드의 sql문 오류" + e);
		}finally {
			//자원해제
			freeResource();
		}
		return count;
	}
	
	public List<HomeWorkDTO> getBoardList(int startRow, int pageSize, String cname) {
		
		List<HomeWorkDTO> lectureList = new ArrayList<HomeWorkDTO>();
		
		try {
			//DB연결
			con = getConnection();
			
			//sql문 작성
			// 정렬 re_ref 내림차순 re_seq 오름차순
			// limit 각페이지 마다 맨위에 첫번째로 보여질 시작글번호, 한페이지당 보여줄 글개수
			String sql = "select * from homework where cname = ? limit ?,?";
			pstmt = con.prepareStatement(sql);
				pstmt.setString(1, cname);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, pageSize);
				
				//rs 실행 저장
				rs = pstmt.executeQuery();
				
				//while 데이터 있으면
				// rs => 자바빈 => boardList추가
				while(rs.next()) {
					//LectureVo 객체 생성
					HomeWorkDTO homeWorkDTO = new HomeWorkDTO();
					//rs => lectureVO 객체에 저장
					
					homeWorkDTO.setNum(rs.getInt("num"));
					homeWorkDTO.setStudentName(rs.getString("studentName"));
					homeWorkDTO.setDate(rs.getTimestamp("date"));
					homeWorkDTO.setCname(rs.getString("cname"));
					homeWorkDTO.setTaskTitle(rs.getString("tasktitle"));
					homeWorkDTO.setTitle(rs.getString("title"));
					homeWorkDTO.setContent(rs.getString("content"));
					
					homeWorkDTO.setFileName(rs.getString("fileName"));
					homeWorkDTO.setFileRealName(rs.getString("fileRealName"));
					
						//lectureVO객체 => lectureList에 추가
						lectureList.add(homeWorkDTO);
				}
			
		} catch (Exception e) {
			System.out.println("HomeWorkDAO클래스에서 getBoardList메소드의 sql문 실행 오류" + e);
		}finally {
			//자원해제
			freeResource();
		}
		return lectureList;
	}
	//num을 course로 변환
	public HomeWorkDTO gethomeworkModifyNum(String num) {
		
		HomeWorkDTO HomeV = null;
		
		try {
			//db연결
			con = getConnection();
			//sql문 작성
			String sql = "select * from homework where num = ?";
			pstmt = con.prepareStatement(sql);
			
				pstmt.setString(1, num);
				rs = pstmt.executeQuery();
				//rs.next이용해서 LectureVo객체에 조회해온 값 넣어주기
				 rs.next(); 
					String studentName = rs.getString("studentName");
					String cname = rs.getString("cname");
					String taskTitle = rs.getString("taskTitle");
					String title = rs.getString("title");
					String content = rs.getString("content");
				
					String fileName = rs.getString("fileName");
					String fileRealName = rs.getString("fileRealName");
					
					
					HomeV = new HomeWorkDTO();
					HomeV.setStudentName(studentName);
					HomeV.setCname(cname);
					HomeV.setTaskTitle(taskTitle);
					HomeV.setTitle(title);
					HomeV.setContent(content);
				
					HomeV.setFileName(fileName);
					HomeV.setFileRealName(fileRealName);
					
					
					
					
		} catch (Exception e) {
			System.out.println("HomeWorkDAO클래스에서 gethomeworkModifyNum메소드의 sql문 실행 오류"+e);
		}finally {
			freeResource();
		}
		return HomeV;
	}
	
	
	
	//검색버튼을 눌렀을때 조회해올 메소드
	public List<HomeWorkDTO> searchBoard(String searchField,String searchText, String cnam) {
		
		List<HomeWorkDTO> boardlist = new ArrayList<HomeWorkDTO>();
		
		try {
			//DB연결
			con = getConnection();
			
			//sql문 작성
			
			String sql = "select * from homework where cname = ? && " + searchField.trim();
				
			
				sql += " like '%" + searchText.trim() + "%';";
			
				
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, cnam);

 			rs =pstmt.executeQuery();
			
			while(rs.next()) {
				String studentName = rs.getString("studentName");
				String cname = rs.getString("cname");
				Timestamp date =  rs.getTimestamp("date");
				String taskTitle = rs.getString("taskTitle");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String fileName = rs.getString("fileName");
				String fileRealName = rs.getString("fileRealName");
				
				HomeWorkDTO HomeVO = new HomeWorkDTO(studentName, cname, taskTitle, title, content,fileName, fileRealName,date);
				boardlist.add(HomeVO);
			}
			
					
				
		} catch (Exception e) {
			System.out.println("HomeWorkDAO클래스에서 searchBoard메소드의 sql문 오류" + e);
		}finally {
			freeResource();
		}
		return boardlist;
	}
	
	// 검색한 글의 총 갯수 가져오는 메소드
			public int getSearchCount(String searchField, String searchText, String cname) {
				int count = 0;
			try {
				//DB연결
				con = getConnection();
				
				// sql문 작성 LectureBoard 테이블의 모든 글개수 가져오기
				String sql = "select count(*) from homework where cname = ? && " + searchField.trim();
				
				sql += " like '%" + searchText.trim() + "%';";
				
				pstmt = con.prepareStatement(sql);
					pstmt.setString(1, cname);
				rs = pstmt.executeQuery();
					
				if(rs.next()) { //만약 조회해서 글개수가 있으면
					count = rs.getInt(1);
				}
				
			} catch (Exception e) {
				System.out.println("HomeWorkBoardDAO클래스의 getBoardCount메소드의 sql문 오류" + e);
			}finally {
				//자원해제
				freeResource();
			}
			return count;
		}
			
		public String getHomeWorkOK(String studentName, String taskTitle) {
			String check = "미제출";
			try {
				//db연결
				con = getConnection();
				//sql문 작성
				String sql = "select homework.homeworkOk from homeworkboard\r\n" + 
						"join homework\r\n" + 
						"on homeworkboard.tasktitle = homework.TaskTitle\r\n" + 
						"where homework.studentName = ? and homework.TaskTitle = ?";
					
				pstmt = con.prepareStatement(sql);
					pstmt.setObject(1, studentName);
					pstmt.setString(2, taskTitle);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
					check = "제출완료";
					}else {
						check = "미제출";
					}
			} catch (Exception e) {
				System.out.println("HomeWorkDAO클래스의 getHomeWorkOk메소드의 sql문 오류" + e);
			}finally {
				freeResource();
			}
			
			return check;
		}
		
}//class의 끝

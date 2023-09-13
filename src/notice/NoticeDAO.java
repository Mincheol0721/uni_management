package notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

//DAO역할(DB연결 후 DB작업하는 클래스)
public class NoticeDAO {
	
	//DB작업에 쓰일 객체들을 저장할 변수들
	private DataSource ds;	//커넥션풀 DataSource 저장할 변수
	private Connection con;	
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	//커넥션풀(DataSource)얻는 기능의 생성자
	public NoticeDAO() { }
	
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
	

	//bnotice테이블에 저장된 레코드의 개수를 반환하는 메소드
	public int getBoardCount() {
		int count = 0;
		
		try {
			con = getConnection();
			
			sql = "select count(*) from bnotice";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("NoticeDAO내부의 getBoardCount메소드에서 예외 발생: " + e);
		} finally {
			freeResource();
		}
		
		return count;
	}
	
	//모든 글의 레코드정보를 조회, 반환하는 메소드
	public List<NoticeDTO> getBoardList() { //content.jsp에서 호출한 메소드
		
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		
		try {
			//1. 커넥션풀(DataSource)에서 DB와 미리 연결 맺은 접속정보를 갖고있는 커넥션 객체 빌려오기
			//DB와의 연결
			con = getConnection();
			//2. SELECT문장을 만들어 PreparedStatement실행객체에 로드 후 얻기
			//SELECT문장 → 글번호에 해당하는 글을 조회하는 SELECT문장 만들기
			pstmt = con.prepareStatement("select * from bnotice order by no desc limit 5");

			//3. rs에 sql문 실행 후 결과 담기
			rs = pstmt.executeQuery();

			while(rs.next()) {
				
				NoticeDTO dto = new NoticeDTO();
				
				dto.setNo( rs.getInt("no") );
				dto.setTitle( rs.getString("title") );
				dto.setContent( rs.getString("content") );
				dto.setNclass( rs.getString("nclass") );
				dto.setReadCount( rs.getInt("readCount") );
				dto.setWriteDate( rs.getDate("writeDate") );
				dto.setId( rs.getString("id") );
				
				list.add(dto);
				
			}
			
		} catch (Exception e) {
			System.out.println("NoticeDAO내부의 getBoard메소드 내부에서 쿼리문 실행 오류: " + e);
		} finally {
			freeResource();
		}
		
		return list; //글제목 클릭 시 전달한 글번호에 해당되는 글의 정보를 NoticeDTO객체에 담아서 NoticeDTO객체 자체를 반환
	}

	//startRow, pageSize를 매개변수로 받아 글 정보를 ArrayList에 담은 후 리턴하는 메소드
	public List<NoticeDTO> getBoardList(int startRow, int pageSize) { 
		
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		
		try {
			//1. 커넥션풀(DataSource)에서 DB와 미리 연결 맺은 접속정보를 갖고있는 커넥션 객체 빌려오기
			//DB와의 연결
			con = getConnection();
			//2. SELECT문장을 만들어 PreparedStatement실행객체에 로드 후 얻기
			//SELECT문장 → 글번호에 해당하는 글을 조회하는 SELECT문장 만들기
			sql = "select * from bnotice order by no desc limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			//3. rs에 sql문 실행 후 결과 담기
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				NoticeDTO dto = new NoticeDTO();
				
				dto.setNo( rs.getInt("no") );
				dto.setTitle( rs.getString("title") );
				dto.setContent( rs.getString("content") );
				dto.setNclass( rs.getString("nclass") );
				dto.setReadCount( rs.getInt("readCount") );
				dto.setWriteDate( rs.getDate("writeDate") );
				dto.setId( rs.getString("id") );
				
				list.add(dto);
				
			}
			
		} catch (Exception e) {
			System.out.println("NoticeDAO내부의 getBoard메소드 내부에서 쿼리문 실행 오류: " + e);
		} finally {
			freeResource();
		}
		
		return list; //글제목 클릭 시 전달한 글번호에 해당되는 글의 정보를 NoticeDTO객체에 담아서 NoticeDTO객체 자체를 반환
	}
	
	
	//게시판의 새 글 정보를 DB의 board테이블에 추가하는 기능의 메소드
	public void insertBoard(NoticeDTO dto) {
		
		int no = 0;	//추가할 새 글의 글번호를 구해서 저장할 변수
		
		try {
			//1. 커넥션풀에서 커넥션 객체 빌려오기
			con = getConnection();
			//insert문 작성
			sql = "insert into bnotice (title, content, writeDate, nclass, id) " + 
						"values(?, ?, now(), ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getNclass());
			pstmt.setString(4, dto.getId());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("NoticeDAO의 insertBoard메소드 내부에서 쿼리문 실행오류: " + e.toString());
		} finally {
			//자원해제
			freeResource();
		}
		
	}//insertBoard메소드 끝
	
	//notice.jsp에서 글 제목 클릭 시 클릭한 글 정보 중 글 조회수 1 증가 시키는 기능의 메소드
	public void updateReadCount(int no) { //content.jsp페이지에서 호출하는 메소드
		
		try {
			//1. 커넥션풀에서 커넥션 객체 빌려오기
			//DB 접속
			con = getConnection();
			//2. UPDATE 쿼리문 작성
			//→ 매개변수 int no으로 전달받는 글번호에 해당하는 글의 정보 중 글 조회수가 저장되는 count열에 대한 값을 1누적
			sql = "update bnotice set count=count+1 where no=?";
			//3. PreparedStatement UPDATE문 실행 객체 얻기
			pstmt = con.prepareStatement(sql);
			//3.1  ?기호에 대응되는 값 설정
			pstmt.setInt(1, no);
			//4. UPDATE문 DB의 board테이블에 전송해서 실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("NoticeDAO클래스 내부에 만든 updateReadCount내부에서 쿼리문 실행 오류: " + e);
		} finally {
			freeResource();
		}
	}

	//updatePro.jsp에서 호출하는 메소드
	//수정을 위해 입력한 글 제목 + 글 내용 + 수정할 글 번호가 저장된 NoticeDTO객체를 매개변수로 받아 
	//UPDATE구문 완성 후 글의 정보를 수정
	public void updateBoard(NoticeDTO dto) {
		
		try {
			//1. 커넥션풀에서 커넥션 객체 빌려오기
			//DB와의 접속
			con = getConnection();
			//2. UPDATE문 만들기
			//→ 매개변수로 전달받은 NoticeDTO객체에 저장된 no 변수의 수정할 글 번호에 해당되는 글 수정을 위해 입력한
			//  글 제목, 글 내용을 수정하는 UPDATE구문 만들기
			sql = "UPDATE bnotice SET title=?, content=? writeDate=now() WHERE no=?";
			//3. PreparedStatement실행객체 얻기
			pstmt = con.prepareStatement(sql);
			//3.1  ?에 대응되는 값 설정
			pstmt.setString(1, dto.getTitle()); //글 제목
			pstmt.setString(2, dto.getContent()); //글 내용
			pstmt.setInt(3, dto.getNo()); //글 번호
			//4. UPDATE문 실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("NoticeDAO내부의 updateBoard 메소드 내부에서 쿼리문 실행 오류: " + e);
		} finally {
			//자원해제
			freeResource();
		}
		
	}

	//deletePro.jsp페이지에서 호출하는 메소드
	//삭제할 글번호, 삭제를 위해 입력한 비밀번호, 글을 작성한 사람의 아이디를 매개변수로 전달받아
	//삭제를 위해 입력한 비밀번호가 DB에 저장된 글의 비밀번호가 일치하면 글을 작성한 사람의 id + 삭제할 글번호에 해당하는 글 정보 하나를 삭제하는 기능의 메소드
	public void deleteBoard(int no, String id) {
		
		try {
			//1. DB와의 연결(커넥션풀에서 커넥션객체 빌려오기)
			con = getConnection();
			//2. board테이블의 삭제할 글이 no열에 저장된 글 번호가 ?와 일치하고
			//   passwd열에 저장된 비밀번호가 입력한 삭제할 글 번호 ?와 일치하며,
			//   member테이블의 id열에 저장된 글을 작성한 사람의 아이디 값이 ?일때만
			//   해당 글 하나 삭제시키는 sql문 작성
			sql = "DELETE FROM notice" + 
				  " WHERE no = ?" + 
				  " AND id=(SELECT id FROM employee WHERE id = ?)";
			//3. PreparedStatement객체 얻기
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no); //삭제할 글 번호를 매개변수 no으로 설정
			pstmt.setString(2, id); //삭제를 위해 글을 작성한 작성자의 아이디를 매개변수 id로 설정
			//4. DELETE구문 전체 실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("NoticeDAO의 deleteBoard내부에서 쿼리문 실행 오류: " + e);
		} finally {
			//자원해제
			freeResource();
		}
		
	}
	
}

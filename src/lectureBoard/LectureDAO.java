package lectureBoard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LectureDAO {
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
//강의평가 등록을 눌렀을 때 그값을 LectureBoard테이블에 집어넣을 기능을 할 메소드
public void insertBoard(LectureVO lecVO) {
	int num =0;
	try {
		// DB연결
		con = getConnection();
		
		//sql문 작성
		//3num 구하기
		//글이 없을 경우 : 글번호1
		//글이 있을 경우 : 최근글번호(번호가 가장큰값) + 1
		//sql 내장함수 MAX(컬럼명)
		String sql = "select max(num) from lectureBoard"; //가장 큰 글번호 가져오기
			
		pstmt = con.prepareStatement(sql);
			
			//rs = 실행 저장
			rs = pstmt.executeQuery();
			// 데이터 있으면 num = max(num)+1
			// 데이터 없으면 num=1
			if(rs.next()) {
				num = rs.getInt(1)+1; //글이 있을경우 최대값 +1
			}else {
				num=1; //글이 없을 경우
			}
			
			sql = "insert into lectureBoard"
					+ "(num,name,title,lectureName,professorName,lectureYear,semesterdivide,"
					+ "lecturedivide,mainText,rate,re_ref,re_lev,re_seq,readcount,date)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, lecVO.getName());
				pstmt.setString(3, lecVO.getTitle());
				pstmt.setString(4, lecVO.getLectureName());
				pstmt.setString(5, lecVO.getProfessorName());
				pstmt.setString(6, lecVO.getLectureYear());
				pstmt.setString(7, lecVO.getSemesterDivide());
				pstmt.setString(8, lecVO.getLectureDivide());
				pstmt.setString(9, lecVO.getMainText());
				pstmt.setString(10, lecVO.getRate());
				pstmt.setInt(11, 0);
				pstmt.setInt(12, 0);
				pstmt.setInt(13, 0);
				pstmt.setInt(14, 0);
				pstmt.setTimestamp(15, lecVO.getDate());
				// 실행
				pstmt.executeUpdate();
				
				
	} catch (Exception e) {
		System.out.println("lectureDAO클래스에서 insertBoard메소드의 sql문 오류" + e);
	}finally {
		freeResource();
	}
}
	public int getBoardCount() {
			int count = 0;
		try {
			//DB연결
			con = getConnection();
			
			// sql문 작성 LectureBoard 테이블의 모든 글개수 가져오기
			String sql = "select count(*) from lectureBoard";
			pstmt = con.prepareStatement(sql);
			
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
	
	public List<LectureVO> getBoardList(int startRow, int pageSize) {
		
		List<LectureVO> lectureList = new ArrayList<LectureVO>();
		
		try {
			//DB연결
			con = getConnection();
			
			//sql문 작성
			// 정렬 re_ref 내림차순 re_seq 오름차순
			// limit 각페이지 마다 맨위에 첫번째로 보여질 시작글번호, 한페이지당 보여줄 글개수
			String sql = "select * from lectureboard order by re_ref desc, re_seq asc limit ?,?";
			pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				
				//rs 실행 저장
				rs = pstmt.executeQuery();
				
				//while 데이터 있으면
				// rs => 자바빈 => boardList추가
				while(rs.next()) {
					//LectureVo 객체 생성
					LectureVO lectureVO = new LectureVO();
					//rs => lectureVO 객체에 저장	
						lectureVO.setMainText(rs.getString("mainText"));
						lectureVO.setDate(rs.getTimestamp("date"));
						lectureVO.setName(rs.getString("name"));
						lectureVO.setNum(rs.getInt("num"));
						lectureVO.setProfessorName(rs.getString("professorName"));
						lectureVO.setLectureName(rs.getString("LectureName"));
						lectureVO.setRate(rs.getString("rate"));
						lectureVO.setRe_lev(rs.getInt("re_lev"));
						lectureVO.setRe_ref(rs.getInt("re_ref"));
						lectureVO.setRe_seq(rs.getInt("re_seq"));
						lectureVO.setReadcount(rs.getInt("readcount"));
						lectureVO.setTitle(rs.getString("title"));
						//lectureVO객체 => lectureList에 추가
						lectureList.add(lectureVO);
				}
			
		} catch (Exception e) {
			System.out.println("LectureDAO클래스에서 getBoardList메소드의 sql문 실행 오류" + e);
		}finally {
			//자원해제
			freeResource();
		}
		return lectureList;
	}
	
	public LectureVO getLectureModify(String num) {
		
		LectureVO lecV = null;
		
		try {
			//db연결
			con = getConnection();
			//sql문 작성
			String sql = "select * from lectureboard where num = ?";
			pstmt = con.prepareStatement(sql);
			
				pstmt.setString(1, num);
				rs = pstmt.executeQuery();
				//rs.next이용해서 LectureVo객체에 조회해온 값 넣어주기
				 rs.next(); 
					String name = rs.getString("name");
					String title = rs.getString("title");
					String lectureName = rs.getString("lectureName");
					String professorName = rs.getString("professorName");
					String lectureYear = rs.getString("lectureYear");
					String semesterDivide = rs.getString("semesterDivide");
					String lectureDivide = rs.getString("lectureDivide");
					String mainText = rs.getString("mainText");
					String rate = rs.getString("rate");
					
					lecV = new LectureVO();
					lecV.setName(name);
					lecV.setTitle(title);
					lecV.setLectureName(lectureName);
					lecV.setProfessorName(professorName);
					lecV.setLectureYear(lectureYear);
					lecV.setSemesterDivide(semesterDivide);
					lecV.setLectureDivide(lectureDivide);
					lecV.setMainText(mainText);
					lecV.setRate(rate);
					
					
					
		} catch (Exception e) {
			System.out.println("LectureDAO객체에서 getLectureModify메소드의 sql문 실행 오류"+e);
		}finally {
			freeResource();
		}
		return lecV;
	}
	
	
	//강의평가 게시판의 수정반영하기 버튼을 눌렀을때 수정반영할 메소드
	public int getUpdateBoard(String title, String lectureYear, String semesterDivide, String lectureDivide, String mainText, String num, String rate) {
			
			int check =0;
		try {
			//DB연결
			con = getConnection();
			
			//sql문 작성
			String sql = "update LectureBoard set title =?, lectureYear =?, "
					+ " semesterDivide=?, lectureDivide=?, rate=?, mainText=? where num = ?";
				pstmt = con.prepareStatement(sql);
					pstmt.setString(1, title);
					pstmt.setString(2, lectureYear);
					pstmt.setString(3, semesterDivide);
					pstmt.setString(4, lectureDivide);
					pstmt.setString(5, rate);
					pstmt.setString(6, mainText);
					pstmt.setString(7, num);
					
					
					
					check = pstmt.executeUpdate();
					
					
		} catch (Exception e) {
			System.out.println("LectureDAO의 클래스의 getUPdateBoard메소드의 sql문 오류 발생" + e);
		}
		return check;
	}
	
	//검색버튼을 눌렀을때 조회해올 메소드
	public List<LectureVO> searchBoard(String searchField,String searchText,int startRow, int pageSize) {
		
		List<LectureVO> boardlist = new ArrayList<LectureVO>();
		
		try {
			//DB연결
			con = getConnection();
			
			//sql문 작성
			
			String sql = "select * from lectureBoard where " + searchField.trim();
				
			
				sql += " like '%" + searchText.trim() + "%' limit ?,?";
			
				
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				
 			rs =pstmt.executeQuery();
			
			while(rs.next()) {
				int num = rs.getInt("num");
				String name = rs.getString("name");
				String title = rs.getString("title");
				String lectureName = rs.getString("lectureName");
				String professorName = rs.getString("professorName");
				String rate = rs.getString("rate");
				Timestamp date = rs.getTimestamp("date");
				LectureVO lecVO = new LectureVO(num, name, title, lectureName, professorName, rate,date);
				boardlist.add(lecVO);
			}
			
					
				
		} catch (Exception e) {
			System.out.println("LectureDAO의 searchBoard메소드의 sql문 오류" + e);
		}finally {
			freeResource();
		}
		return boardlist;
	}
	
	public int getSearchCount(String searchField, String searchText) {
		int count = 0;
		try {
			//DB연결
			con = getConnection();
			
			// sql문 작성 LectureBoard 테이블의 모든 글개수 가져오기
			String sql = "select count(*) from lectureBoard where " + searchField.trim();
			
			
			sql += " like '%" + searchText.trim() + "%';";
			
			pstmt = con.prepareStatement(sql);
			
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

}//class의 끝

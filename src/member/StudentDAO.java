package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//DAO는 데이터베이스 연결을 맺은 후 DB작업하는 자바빈클래스 종류중 하나!

public class StudentDAO {

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
	
	//Member테이블에 새 회원을 추가 하는 기능의 메소드 
	public int insertMember(MemberDTO dto){
		
		int result = 0; // insert에 성공하면 1을 저장, 실패하면 0을 저장 
		String sql = ""; // insert 쿼리문 저장할 변수 
		
		try {
			//1.커넥션풀에서 커넥션 객체 얻기 (DB와 MemberDAO.java와 연결을 맺은 정보를 가지고 있는 Connection객체 얻기)
			//  요약 : DB와의 연결
			con = getConnection();
			//2. insert 쿼리문(SQL문) 만들기
			sql = "insert into student(id,pwd,name,tel,ssn,email,addr,faculty,dept) " +
							     "values( ?,  ?,   ?,  ?,  ?,    ?,   ?,      ?,   ?)";
			
			//3. PreparedStatement insert 쿼리문 실행할 객체 얻기 
			pstmt = con.prepareStatement(sql);
			//3.1  ? 기호에 대응되게 insert할 값들을 설정 (순서대로)
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getSsn());
			pstmt.setString(6, dto.getEmail());
			pstmt.setString(7, dto.getAddr());
			pstmt.setString(8, dto.getFaculty());
			pstmt.setString(9, dto.getDept());
			
			//4. 완성된 insert 쿼리문 DB의 member테이블에 전송해 실행합니다.
			// excuteUpdate메소드는 insert, update, delete 문을 실행하는 메소드로  성공하면 1을 반환 실패하면 0을 반환 하는 메소드임.
			result = pstmt.executeUpdate();
		
		} catch (Exception e) {
			System.out.println("studentDAO클래스의 insertMember내부에서  insert문장 실행 예외발생 : " + e.toString());
		} finally {
			freeResource();
		}
	
		//5.   joinPro.jsp페이지에 insertMember메소드 호출구문을 작성한 줄로  1 또는 0을 반환
		return result;
	}
	
	//Member테이블에 회원정보를 수정하는 기능의 메소드 
	public int updateMember(MemberDTO dto){
		
		int result = 0; // insert에 성공하면 1을 저장, 실패하면 0을 저장 
		String sql = ""; // insert 쿼리문 저장할 변수 
		
		try {
			//1.커넥션풀에서 커넥션 객체 얻기 (DB와 MemberDAO.java와 연결을 맺은 정보를 가지고 있는 Connection객체 얻기)
			//  요약 : DB와의 연결
			con = getConnection();
			//2. insert 쿼리문(SQL문) 만들기
			sql = "update student set name=?, tel=?, ssn=?, email=?, addr=?, faculty=?, dept=?";
							     
			if(dto.getPwd() != "") {
				sql += ", pwd=?";
			} 
			sql += " where id=?";
			
			//3. PreparedStatement insert 쿼리문 실행할 객체 얻기 
			pstmt = con.prepareStatement(sql);
			//3.1  ? 기호에 대응되게 insert할 값들을 설정 (순서대로)
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTel());
			pstmt.setString(3, dto.getSsn());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getAddr());
			pstmt.setString(6, dto.getFaculty());
			pstmt.setString(7, dto.getDept());
			
			if(dto.getPwd() != "") {
				pstmt.setString(8, dto.getPwd());
				pstmt.setString(9, dto.getId());
			} else {
				pstmt.setString(8, dto.getId());
			}
			
			//4. 완성된 insert 쿼리문 DB의 member테이블에 전송해 실행합니다.
			// excuteUpdate메소드는 insert, update, delete 문을 실행하는 메소드로  성공하면 1을 반환 실패하면 0을 반환 하는 메소드임.
			result = pstmt.executeUpdate();
		
		} catch (Exception e) {
			System.out.println("StudentDAO클래스의 updateMember메소드 내부에서 예외 발생 : " + e.toString());
		} finally {
			freeResource();
		}
	
		//5.   joinPro.jsp페이지에 insertMember메소드 호출구문을 작성한 줄로  1 또는 0을 반환
		return result;
	}
	
	public MemberDTO selectMember(String id) {
		MemberDTO dto = null;
		
		try {
			con = getConnection();
			String sql = "select * from student where id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemberDTO();
				
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPwd(rs.getString("pwd"));
				dto.setSsn(rs.getString("ssn"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setAddr(rs.getString("addr"));
				dto.setFaculty(rs.getString("faculty"));
				dto.setDept(rs.getString("dept"));
			}
			
		} catch (Exception e) {
			System.out.println("StudentDAO클래스의 selectMember메소드 내부에서 예외 발생: " + e);
		} finally {
			freeResource();
		}
		
		return dto;
	}
	
	//회원가입을 위해 입력한 아이디를 매개변수로 id로 전달받아
	//DB의 테이블에 저장되어 있는지 유무를 검사하는 메소드
	//만약 입력한 아이디가 DB에 저장되어 있으면 1을 check변수에 저장하여 반환하고
	//만약 입력한 아이디가 DB에 저장되어 있지 않으면 0을 check변수에 저장하여 반환
	public int idCheck(String id) {
		
		int check = 0;
		
		String sql = "";
		
		try {
			//1.커넥션풀에서 커넥션 객체 얻기 (DB와 MemberDAO.java와 연결을 맺은 정보를 가지고 있는 Connection객체 얻기)
			//  요약 : DB와의 연결
			con = getConnection();
			//2. 입력한 아이디에 해당하는 회원레코드 조회 SELECT 쿼리문 만들기
			sql = "select * from student where id='"+id+"'";
			//3. PreparedStatement실행객체 얻기
			pstmt = con.prepareStatement(sql);
			//4. select문장 DB에 전송해서 실행 후 조회 결과를 ResultSet으로 반환받기
			rs = pstmt.executeQuery();
			//5. 입력한 아이디에 해당하는 회원 레코드가 조회 되면(아이디 중복)
			if(rs.next()) {
				check = 1;
			} else {
				check = 0;
			}
			
		} catch (Exception e) {
			System.out.println("studentDAO의 idCheck메소드 내부에서 SQL 실행오류: " + e);
		} finally {
			//7. 자원반납(커넥션풀에 Connection객체 사용 후 반납)
			freeResource();
		}
		//6. join_IDcheck.jsp로 반환
		return check;
	}
	
	//로그인 처리 시 사용하는 메소드
	//입력받은 아이디, 비밀번호가 DB(jspbeginner)내부의 member테이블에 저장되어 있는지 확인하기 위해 
	//입력받은 아이디, 비밀번호와 member테이블에 저장된 아이디, 비밀번호를 비교하는 메소드
	//입력한 아이디와 비밀번호가 맞으면(member테이블에 저장되어 있으면)check변수의 값을 1로 저장
	//입력한 아이디가 맞고 비밀번호가 틀리면 check변수의 값을 0으로 저장
	//입력한 아이디가 틀리고 비밀번호가 맞으면 check변수의 값을 -1로 저장
	public int userCheck(String id, String pwd) {
		int check = -1;
		
		String sql = "";
		
		try {
			//1.커넥션풀에서 커넥션 객체 얻기 (DB와 MemberDAO.java와 연결을 맺은 정보를 가지고 있는 Connection객체 얻기)
			//  요약 : DB와의 연결
			con = getConnection();
			//2.1 입력한 아이디에 해당하는 정보 조회(SELECT문 만들기)
			
			sql = "SELECT * FROM student WHERE id=?";
			//2.2 입력한 비밀번호에 해당하는 정보 조회(SELECT문 만들기)
			//sql = "SELECT * FROM MEMBER WHERE passwd=?";
			//3. PreparedStatement실행 객체 얻기
			pstmt = con.prepareStatement(sql);
			//3.1 ?에 대응되는 값을 입력한 아이디와 비밀번호 값으로 설정
			pstmt.setString(1, id);
			//pstmt.setString(2, passwd);
			//4. PreparedStatement 실행객체 메모리에 설정된 전체 SELECT문장을 DB의 테이블에 전송해서 실행
			//   실행 후 조회된 결과 데이터들을 ResultSet객체 메모리에 담아서 얻기
			rs = pstmt.executeQuery();
			
			//5. ResultSet에 커서위치를 그 다음행으로 옮겨서 조회한 정보가 있는지 확인
			if(rs.next()) {//입력한 아이디가 DB의 테이블에 존재하면
				//입력한 비밀번호와 DB의 테이블에서 조회된 비밀번호를 비교해서 같으면
				//(입력한 ID와 비밀번호가 모두 같으면)
				if( pwd.equals( rs.getString("pwd") ) ) {
					check = 1;	//아이디 비밀번호 모두 같음
				} else { //입력한 ID는 같으나 비밀번호가 틀리면
					check = 0;	//비밀번호 다름
				}
				
			} else {//입력한 아이디가 DB의 테이블에 저장되어 있지 않으면
				check = -1;		//아이디 다름
			}
			
		} catch (Exception e) {
			System.out.println("studentDAO의 userCheck메소드에서 sql문 실행 오류: " + e);
		} finally {
			//자원반납(커넥션풀에 Connection객체 사용 후 반납)
			freeResource();
		}
		
		
		return check;
	}
	
	public String checkPwd(String id) {
		String pwd = null;
		
		try {
			con = getConnection();
			
			String sql = "select pwd from student where id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pwd = rs.getString("pwd");
			}
			
			
		} catch (Exception e) {
			System.out.println("StudentDAO클래스의 checkPwd메소드 내부에서 예외 발생: " + e);
		} finally {
			freeResource();
		}
		
		
		return pwd;
	}//checkPwd닫는부분
	
	
	public ArrayList listStudent() {
		
		ArrayList list = new ArrayList();
		
		try {
		
			con = getConnection();
			
			String sql="select * from student";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				String id = rs.getString("id");
				String name = rs.getString("name");
				String tel = rs.getString("tel");
				String ssn = rs.getString("ssn");
				String email = rs.getString("email");
				String addr = rs.getString("addr");
				String pwd = rs.getString("pwd");
				String faculty = rs.getString("faculty");
				String dept = rs.getString("dept");
				String professor = rs.getString("professor");
				
				MemberDTO dto = new MemberDTO(id, pwd, name, email, addr, tel, ssn, professor, dept, faculty);
				
				list.add(dto);
			}
		} catch (Exception e) {
		
		}
		
		
		return list;
	}//listStudent끝
	
		public int insertStudent(MemberDTO dto){
				
				int result = 0; // insert에 성공하면 1을 저장, 실패하면 0을 저장 
				String sql = ""; // insert 쿼리문 저장할 변수 
				
				try {
					//1.커넥션풀에서 커넥션 객체 얻기 (DB와 MemberDAO.java와 연결을 맺은 정보를 가지고 있는 Connection객체 얻기)
					//  요약 : DB와의 연결
					con = getConnection();
					//2. insert 쿼리문(SQL문) 만들기
					sql = "insert into student(id,pwd,name,tel,ssn,email,addr,faculty,dept) " +
									     "values( ?,  ?,   ?,  ?,  ?,    ?,   ?,      ?,   ?)";
					
					//3. PreparedStatement insert 쿼리문 실행할 객체 얻기 
					pstmt = con.prepareStatement(sql);
					//3.1  ? 기호에 대응되게 insert할 값들을 설정 (순서대로)
					pstmt.setString(1, dto.getId());
					pstmt.setString(2, dto.getPwd());
					pstmt.setString(3, dto.getName());
					pstmt.setString(4, dto.getTel());
					pstmt.setString(5, dto.getSsn());
					pstmt.setString(6, dto.getEmail());
					pstmt.setString(7, dto.getAddr());
					pstmt.setString(8, dto.getProfessor());
					pstmt.setString(9, dto.getFaculty());
					pstmt.setString(10, dto.getDept());
					
					//4. 완성된 insert 쿼리문 DB의 member테이블에 전송해 실행합니다.
					// excuteUpdate메소드는 insert, update, delete 문을 실행하는 메소드로  성공하면 1을 반환 실패하면 0을 반환 하는 메소드임.
					result = pstmt.executeUpdate();
				
				} catch (Exception e) {
					System.out.println("studentDAO클래스의 insertMember내부에서  insert문장 실행 예외발생 : " + e.toString());
				} finally {
					freeResource();
				}
			
				//5.   joinPro.jsp페이지에 insertMember메소드 호출구문을 작성한 줄로  1 또는 0을 반환
				return result;
			}//insertStudent끝

			
				public int updateStudent(MemberDTO dto){
					
					int result = 0; // insert에 성공하면 1을 저장, 실패하면 0을 저장 
					String sql = ""; // insert 쿼리문 저장할 변수 
					
					try {
						//1.커넥션풀에서 커넥션 객체 얻기 (DB와 MemberDAO.java와 연결을 맺은 정보를 가지고 있는 Connection객체 얻기)
						//  요약 : DB와의 연결
						con = getConnection();
						//2. insert 쿼리문(SQL문) 만들기
						sql = "update student set name=?, tel=?, ssn=?, email=?, addr=?, pwd=?, professor=?, faculty=?, dept=? where id=?";
										     
						//3. PreparedStatement insert 쿼리문 실행할 객체 얻기 
						pstmt = con.prepareStatement(sql);
						//3.1  ? 기호에 대응되게 insert할 값들을 설정 (순서대로)
						pstmt.setString(1, dto.getName());
						pstmt.setString(2, dto.getTel());
						pstmt.setString(3, dto.getSsn());
						pstmt.setString(4, dto.getEmail());
						pstmt.setString(5, dto.getAddr());
						pstmt.setString(6, dto.getPwd());
						pstmt.setString(7, dto.getProfessor());
						pstmt.setString(8, dto.getFaculty());
						pstmt.setString(9, dto.getDept());
						pstmt.setString(10, dto.getId());
						
						System.out.println( dto.getName());
						System.out.println( dto.getTel());
						System.out.println( dto.getSsn());
						System.out.println( dto.getEmail());
						System.out.println( dto.getAddr());
						System.out.println( dto.getPwd());
						System.out.println( dto.getProfessor());						
						System.out.println( dto.getFaculty());
						System.out.println( dto.getDept());
						System.out.println( dto.getId());
						
						String queryString = pstmt.toString();
						System.out.println(queryString);
						//4. 완성된 insert 쿼리문 DB의 member테이블에 전송해 실행합니다.
						// excuteUpdate메소드는 insert, update, delete 문을 실행하는 메소드로  성공하면 1을 반환 실패하면 0을 반환 하는 메소드임.
						result = pstmt.executeUpdate();
					
					} catch (Exception e) {
						System.out.println("StudentDAO클래스의 updateStudent메소드 내부에서 예외 발생 : " + e.toString());
					} finally {
						freeResource();
					}
				
					//5.   joinPro.jsp페이지에 insertMember메소드 호출구문을 작성한 줄로  1 또는 0을 반환
					return result;
				}//updateStudent끝
				
				public void delStudent(String id) {
					
					
					try {
						con = getConnection();
						
						String sql = "delete from student where id=?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, id);
						
						pstmt.executeUpdate();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} finally {
						freeResource();
					}
					
				
			
			}//delProfessor끝
	
}







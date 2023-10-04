package courseList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board_course.BoardBean;

//DAO(DB연결 후 DB작업하는 클래스)
public class CourseDAO {
	
	//DB작업에 쓰일 객체들을 저장할 변수들
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	//DataSource 얻는 기능의 생성자
	public CourseDAO() {
		
		try {
			
			//InitialContext객체 생성
			Context ctx = new InitialContext();
			
			//기본 경로 주소 설정
			Context envContext = (Context) ctx.lookup("java:comp/env");

			//DataSource커넥션풀 객체 찾아 반환
			ds = (DataSource) envContext.lookup("jdbc/studyplannerdb");
			
		} catch (Exception e) {
			System.out.println("CourseDAO의 생성자 내부에서 커넥션풀 얻기 실패 : " + e.toString());
		}
		
		
	}//생성자 end
	
	//DB연결 후 작업하는 객체들 사용한 뒤에 자원해제 할 때 공통으로 쓰이는 메소드
		public void freeResource() {
			try {
				
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				if(con != null) con.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
	}//자원해제 end

	//테이블에 저장된 레코드의 개수를 반환하는 메소드
	public int getBoardCount() {
		int count = 0;
		String sql = "";
		try {
			con = ds.getConnection();
			
			sql = "select count(*) from course";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("CourseDAO내부의 getBoardCount메소드에서 예외 발생: " + e);
		} finally {
			freeResource();
		}
		
		return count;
	}
		
	//DB로부터 모든 과목들의 정보를 가져오는 메소드(조회)
	//검색어가 없으면? 모든 과목 정보 검색 후 리스트에 뿌려줌
	public ArrayList<CourseBean> getList(String search, String searchText, int startrow, int pagesize) {
		
		//등록된 과목들을 담을 객체
		ArrayList<CourseBean> list = new ArrayList<CourseBean>();
		
		//쿼리를 담을 변수 선언
		String sql = "";
		
		try {
			
			//DB연결
			con = ds.getConnection();
			if (searchText.equals("") || searchText.equals(null)) {
				sql = "select * from course";
			}else {
				sql = "select * from course where " + search + " like '%"+searchText+"%'";
			}
			
			sql += " limit ?, ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, pagesize);
			
			rs = pstmt.executeQuery();
			
			//rs객체에 담겨있음 -> 컬렉션 객체에 담기
			while(rs.next()) {
				
				CourseBean bean = new CourseBean();
				
				//하나씩 저장
				bean.setGrade(rs.getInt("grade"));
				bean.setCompyear(rs.getInt("compyear"));
				bean.setCompsem(rs.getInt("compsem"));
				bean.setCname(rs.getString("cname"));
				bean.setProfessor(rs.getString("professor"));
				bean.setCompdiv(rs.getString("compdiv"));
				
				list.add(bean);				
				
			}
			
			System.out.println("과목 조회 sql구문 실행 완료");
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 freeResource();
		}

		return list;		
			
		}//getList end
	
	
	//DB로부터 모든 강의들의 정보를 가져오는 메소드(조회)
	public ArrayList<CourseBean> getList(int startrow, int pagesize) {
		
		//등록된 과목들을 담을 객체
		ArrayList<CourseBean> list = new ArrayList<CourseBean>();
		
		//쿼리를 담을 변수 선언
		String sql = "";	
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			//sql문
			sql = "select * from course limit ?, ?";
			
			//DB에 쿼리문 문자열 전송
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, pagesize);
	        
			//쿼리 실행
			rs = pstmt.executeQuery();
			
			//rs객체에 담겨있음 -> 컬렉션 객체에 담기
			while(rs.next()) {
				
				CourseBean bean = new CourseBean();
				
				//하나씩 저장
				bean.setGrade(rs.getInt("grade"));
				bean.setCompyear(rs.getInt("compyear"));
				bean.setCompsem(rs.getInt("compsem"));
				bean.setCname(rs.getString("cname"));
				bean.setProfessor(rs.getString("professor"));
				bean.setCompdiv(rs.getString("compdiv"));
				
				list.add(bean);
				
				//System.out.println("과목 정보 저장 완료");				
			}			
			
			System.out.println("강의 조회 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 freeResource();
		}

		return list;
	
	}//조회 end
}

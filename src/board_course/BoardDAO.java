package board_course;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dbcp.DBConnectionMgr;

//DAO(DB연결 후 DB작업하는 클래스)
public class BoardDAO {

	//DB작업에 쓰일 객체들을 저장할 변수들
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	private DBConnectionMgr pool;
	
	//DataSource 얻는 기능의 생성자
	public BoardDAO() {
		
		try {
			
			//InitialContext객체 생성
			Context ctx = new InitialContext();
			
			//기본 경로 주소 설정
			Context envContext = (Context) ctx.lookup("java:/comp/env");

			//DataSource커넥션풀 객체 찾아 반환
			ds = (DataSource) envContext.lookup("jdbc/studyplannerdb");
			
			//pool = DBConnectionMgr.getInstance();
			
		} catch (Exception e) {
			System.out.println("BoardDAO의 생성자 내부에서 커넥션풀 얻기 실패 : " + e.toString());
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
	
	//DB로부터 모든 과목들의 정보를 가져오는 메소드(조회)
	public ArrayList<BoardBean> getList() {
		
		//등록된 과목들을 담을 객체
		ArrayList<BoardBean> list = new ArrayList<BoardBean>();
		
		//쿼리를 담을 변수 선언
		String sql = "";
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			//sql문
			sql = "select * from course";
			
			//DB에 쿼리문 문자열 전송
			pstmt = con.prepareStatement(sql);
	        
			//쿼리 실행
			rs = pstmt.executeQuery();
			
			//rs객체에 담겨있음 -> 컬렉션 객체에 담기
			while(rs.next()) {
				
				BoardBean bean = new BoardBean();
				
				//하나씩 저장
				bean.setCcode(rs.getInt("ccode"));
				bean.setCname(rs.getString("cname"));
				bean.setCompdiv(rs.getString("compdiv"));
				bean.setCompyear(rs.getInt("compyear"));
				bean.setCompsem(rs.getInt("compsem"));
				bean.setGrade(rs.getInt("grade"));
				bean.setProfessor(rs.getString("professor"));
				
				list.add(bean);
				
				System.out.println("과목 정보 저장 완료");
				
			}
			
			System.out.println("sql구문 실행 완료");
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 freeResource();
		}

		return list;
		
	}//조회 end
	
	
	//새 과목 하나를 studyplannerdb 데이터베이스의 Board에 추가시키는 기능의 메소드
	public int insertSB(BoardBean boardBean) {
		
		try {
			
			//DB연결 
			con = ds.getConnection();
			
			//insert sql문 만들기
			String sql = "insert into course (cname, compdiv, compyear, compsem, grade, professor)"
					   + "values (?, ?, ?, ?, ?, ?);";
			
			System.out.println("insertSB sql문 : " + sql);

			//insert문 실행할 pstmt 실행 객체 얻기
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, boardBean.getCname()); 		//과목명
			pstmt.setString(2, boardBean.getCompdiv()); 	//이수 구분
			pstmt.setInt(3, boardBean.getCompyear()); 		//이수 학년
			pstmt.setInt(4, boardBean.getCompsem()); 		//이수 학기
			pstmt.setInt(5, boardBean.getGrade()); 			//학점
			pstmt.setString(6, boardBean.getProfessor()); 	//담당 교수

			//insert문 실행
			return pstmt.executeUpdate();			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 freeResource();	
		}
		return 0;
		
	}//insertSB end
	

	// 새 과목들을 studyplannerdb 데이터베이스의 Board에 다중 추가시키는 기능의 메소드
	public void insertMultipleSB(List<BoardBean> arrayList) {
	    try {
	        // DB 연결
	        con = ds.getConnection();
	        System.out.println("DB 연결 성공");
	        
	        // insert SQL 문 만들기
	        StringBuilder sqlBuilder = new StringBuilder("INSERT INTO course (cname, compdiv, compyear, compsem, grade, professor) VALUES ");
	        for (int i = 0; i < arrayList.size(); i++) {
	            if (i > 0) {
	                sqlBuilder.append(", ");
	            }
	            sqlBuilder.append("(?, ?, ?, ?, ?, ?)");
	        }
	        
	     
	        
	        // insert 문 실행할 pstmt 실행 객체 얻기
	        String sql = sqlBuilder.toString();
	        
	        System.out.println("insertMultipleSB sql문 : " + sql);
	        
	        pstmt = con.prepareStatement(sql);
	        
	        for (int i = 0; i < arrayList.size(); i++) {
	            BoardBean boardBean = arrayList.get(i);
	            pstmt.setString(i * 6 + 1, boardBean.getCname());       //과목명
	            pstmt.setString(i * 6 + 2, boardBean.getCompdiv());     //이수 구분
	            pstmt.setInt(i * 6 + 3, boardBean.getCompyear());       //이수 학년
	            pstmt.setInt(i * 6 + 4, boardBean.getCompsem());        //이수 학기
	            pstmt.setInt(i * 6 + 5, boardBean.getGrade());          //학점
	            pstmt.setString(i * 6 + 6, boardBean.getProfessor());   //담당 교수
	        }
	        
	        // insert 문 실행
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        freeResource();
	    }
	}

	
	//과목 수정
	public void modifyCourse(BoardBean bean) {
		
		String sql = "update course set cname=?, compdiv=?, compyear=?, compsem=?, grade=? where ccode=?";
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, bean.getCname());
//			pstmt.setString(2, );
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}
		
	}
	
	
	
	
	
}

package board_course;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//DAO(DB연결 후 DB작업하는 클래스)
public class BoardDAO {

	//DB작업에 쓰일 객체들을 저장할 변수들
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	//private DBConnectionMgr pool;
	
	//DataSource 얻는 기능의 생성자
	public BoardDAO() {
		
		try {
			
			//InitialContext객체 생성
			Context ctx = new InitialContext();
			
			//기본 경로 주소 설정
			Context envContext = (Context) ctx.lookup("java:comp/env");

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
	//검색어가 없으면? 모든 과목 정보 검색 후 리스트에 뿌려줌
	public ArrayList<BoardBean> getList(String search, String searchText) {
		
		//등록된 과목들을 담을 객체
		ArrayList<BoardBean> list = new ArrayList<BoardBean>();
		
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
			
			pstmt = con.prepareStatement(sql);
			
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
				
			}
			
			System.out.println("과목 조회 sql구문 실행 완료");
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 freeResource();
		}

		return list;		
			
		}//getList end
		
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
				bean.setId(rs.getString("id"));
				
				list.add(bean);
				
				//System.out.println("과목 정보 저장 완료");				
			}			
			
			System.out.println("과목 조회 sql구문 실행 완료");
			
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
			
			//System.out.println("insertSB sql문 : " + sql);

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
	

	//새 과목들을 studyplannerdb 데이터베이스의 Board에 다중 추가시키는 기능의 메소드
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
	    
	}//insertMultipleSB end

	
	//과목 삭제하는 기능의 메소드
	public void delCourse(int ccode) {
		
		String sql = "delete from course where ccode=?";
		
		try {
			
			//DB연결
			con = ds.getConnection();
	
			pstmt = con.prepareStatement(sql);			
			pstmt.setInt(1, ccode);
			
			pstmt.executeUpdate();
						
			System.out.println("과목 삭제 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("delCourse메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
			
	}//delCourse end
	

	//과목 수정을 위해 선택한 한 과목의 정보를 modCourse.jsp에 뿌려주기 위해 리턴하는 메소드
	public BoardBean getCourseInfo(int ccode) {
		
		System.out.println("getCourseInfo메소드가 받는 과목코드: " + ccode);
		String sql = "select * from course where ccode=?";
		
		BoardBean bean = new BoardBean();
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(sql);
			
			//DB에 전달할 ?값 세팅
			pstmt.setInt(1, ccode);
			
			rs = pstmt.executeQuery();
			
			//수정할 과목 하나의 데이터들을 bean객체에 저장
			if (rs.next()) {
				
				bean.setCname(rs.getString("cname"));
				bean.setCompdiv(rs.getString("compdiv"));
				bean.setCompyear(rs.getInt("compyear"));
				bean.setCompsem(rs.getInt("compsem"));
				bean.setGrade(rs.getInt("grade"));
				bean.setProfessor(rs.getString("professor"));
				
			}	
			
			System.out.println("수정할 과목 불러오는 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getCourseInfo메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
		
		//수정할 과목명에 대한 과목 객체 전달
		return bean;

	}//getCourse end

	
	//과목 수정하는 기능의 메소드
	public void modifyCourse(BoardBean bean) {			
		
		try {
			
			//DB연결
			con = ds.getConnection();
			String sql = "update course set cname=?, compdiv=?, compyear=?, compsem=?, grade=? where ccode=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, bean.getCname());
			pstmt.setString(2, bean.getCompdiv());
			pstmt.setInt(3, bean.getCompyear());
			pstmt.setInt(4, bean.getCompsem());
			pstmt.setInt(5, bean.getGrade());
			pstmt.setInt(6, bean.getCcode());		
			
			pstmt.executeUpdate();
			
			System.out.println("과목 수정 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("modifyCourse메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
		
	}//modifyCourse end
	
	

	
}

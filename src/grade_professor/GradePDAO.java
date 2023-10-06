package grade_professor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.mysql.cj.Session;

import board_course.BoardBean;


public class GradePDAO {

	//DB작업에 쓰일 객체들을 저장할 변수들
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	//DataSource 얻는 기능의 생성자
	public GradePDAO() {
		
		try {
			
			//InitialContext객체 생성
			Context ctx = new InitialContext();
			
			//기본 경로 주소 설정
			Context envContext = (Context) ctx.lookup("java:comp/env");

			//DataSource커넥션풀 객체 찾아 반환
			ds = (DataSource) envContext.lookup("jdbc/studyplannerdb");
			
		} catch (Exception e) {
			System.out.println("GradePDAO의 생성자 내부에서 커넥션풀 얻기 실패 : " + e.toString());
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
	public int getBoardCount(Map<String, Object> map, String id) {
		
		int count = 0;
		String sql = "";
		System.out.println("id : " + id);
		
		try {
			con = ds.getConnection();
			
			sql = "SELECT count(*) AS count, c.ccode AS ccode, c.cname AS cname, s.id AS id, s.name AS name, ch.grade AS grade, ch.rate AS rate " + 
				  "FROM student AS s " +
				  "JOIN cHistory AS ch ON s.id = ch.id " +
				  "JOIN course c ON ch.ccode = c.ccode " +
				  "WHERE c.id = ? ";
			
			// 검색어가 존재하는 경우, WHERE 절에 추가
	        if (map.get("searchText") != null) {
	            sql += " AND c." + map.get("search") + " LIKE ?"; //AND c.ccode
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, id);
	            pstmt.setString(2, "%" + map.get("searchText") + "%");
	        } else {
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, id);
	        }
			System.out.println("sql문: " + sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("GradePDAO내부의 getBoardCount메소드에서 예외 발생: " + e);
		} finally {
			freeResource();
		}
		
		return count;
	}//getBoardCount end
	
	// 검색 조건에 맞는 게시물 목록을 반환합니다.
	public List<GradeBean> getList(Map<String, Object> map, String id) { 
	    List<GradeBean> vector = new Vector<GradeBean>();  // 결과(게시물 목록)를 담을 변수
	    System.out.println("id : " + id);
	    System.out.println("map_search : " + map.get("search"));	   
	    System.out.println("map_searchText : " + map.get("searchText"));

	    String sql = "SELECT * FROM ("
	    	    	+ "SELECT c.ccode AS ccode, c.cname AS cname, s.id AS id, s.name AS name, ch.grade AS grade, ch.rate AS rate, "
	    	    	+ "ROW_NUMBER() OVER (ORDER BY ccode ASC) AS rNum "
	    	    	+ "FROM student AS s "
	    	    	+ "JOIN cHistory AS ch ON s.id = ch.id "
	    	    	+ "JOIN course c ON ch.ccode = c.ccode "
	    	    	+ "WHERE c.id = ? ";

	    	if (map.get("searchText") != null) {
	    	    sql += "AND (";
	    	    	if(map.get("search") != null && map.get("search").equals("s.id")) {
	    	    		
	    	    		sql += " s.id LIKE '%" + map.get("searchText") + "%' ";
	    	    		
	    	    	}else if(map.get("search") != null && map.get("search").equals("s.name")) {
	    	    		
	    	    		sql += " s.name LIKE '%" + map.get("searchText") + "%' ";
	    	    		
	    	    	}else if(map.get("search") != null && map.get("search").equals("c.cname")) {
	    	    		
						sql += " c.cname LIKE '%" + map.get("searchText") + "%' ";

	    	    	}else if(map.get("search") != null && map.get("search").equals("c.ccode")) {
	    	    		
						sql += " c.ccode LIKE '%" + map.get("searchText") + "%' ";

	    	    	}
	    	    		    	        
	    	    	sql += ") ";
	    	}

	    	sql += ") AS Tb WHERE rNum BETWEEN ? AND ?";
	    
	    System.out.println(sql);
	    
	    try {
	        con = ds.getConnection();
	        pstmt = con.prepareStatement(sql);  // 쿼리문 생성   
	        pstmt.setString(1, id);
	        pstmt.setString(2, map.get("start").toString());
            pstmt.setString(3, map.get("end").toString());
	        
	        rs = pstmt.executeQuery();  // 쿼리 실행

	        while (rs.next()) {  // 결과를 순화하며...
	           // 한 행(게시물 하나)의 내용을 bean에 저장
	           GradeBean bean = new GradeBean(); 

	           // 하나씩 저장 
	           bean.setCcode(rs.getInt("ccode"));
	           bean.setCname(rs.getString("cname"));
	           bean.setId(rs.getString("id"));
	           bean.setName(rs.getString("name"));
	           bean.setGrade(rs.getInt("grade"));
	           bean.setRate(rs.getString("rate"));
	           
	           vector.add(bean);
	        }
	    } 
	    catch (Exception e) {
	        System.out.println("성적 검색 조회 중 예외 발생");
	        e.printStackTrace();
	    } finally {
	        freeResource();
	    }

	    return vector;
	}//getList end

	//점수와 등급을 0과 "-"로 초기화시키는 기능의 메소드
	public void resetGradeAndRate(int ccode, String id) {
		
		int grade = 0;
		String rate = "-";
		
		String sql = "UPDATE cHistory "
					+ "SET grade =?, rate =? "
					+ "WHERE ccode =? AND id =?;";
		try {
			
			//DB연결
			con = ds.getConnection();
	
			pstmt = con.prepareStatement(sql);		
			pstmt.setInt(1, grade);
			pstmt.setString(2, rate);
			pstmt.setInt(3, ccode);
			pstmt.setString(4, id);
			
			pstmt.executeUpdate();
						
			System.out.println("초기화 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("resetGradeAndRate메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
			
	}//resetGradeAndRate end
	
	//성적 수정을 위해 선택한 한 학생의 성적 정보를 modGrade.jsp에 뿌려주기 위해 리턴하는 메소드
	public GradeBean getModGrade(int ccode, String name, String id) {
		
		System.out.println("getModGrade메소드가 받는 과목코드: " + ccode);
		
		String sql = "SELECT c.ccode, c.cname, s.name, ch.rate, ch.grade, s.id " 
	             	+ "FROM course c " 
	             	+ "INNER JOIN cHistory ch ON c.ccode = ch.ccode " 
	             	+ "INNER JOIN student s ON ch.id = s.id " 
	             	+ "WHERE c.ccode = ? " 
	             	+ "AND s.name = ? " 
	             	+ "AND s.id = ?;";

		
		GradeBean bean = new GradeBean();
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(sql);
			
			//DB에 전달할 ?값 세팅
			pstmt.setInt(1, ccode);
			pstmt.setString(2, name);
			pstmt.setString(3, id);
			
			rs = pstmt.executeQuery();
						
			if (rs.next()) {

				bean.setCcode(rs.getInt("ccode"));
				bean.setCname(rs.getString("cname"));
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setGrade(rs.getInt("grade"));
				bean.setRate(rs.getString("rate"));								
			}	
			
			System.out.println("성적 수정할 행의 정보를 불러오는 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getModGrade메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
		
		return bean;

	}//getModGrade end

	
	//성적을 수정하는 기능의 메소드
	public void modifyGrade(GradeBean bean) {			
		
		try {
			
			//DB연결
			con = ds.getConnection();
			
			String sql = "UPDATE cHistory "
						+ "SET rate =?, grade =? "
						+ "WHERE ccode =? "
						+ "AND id =?;";
			
			pstmt = con.prepareStatement(sql);
								
			pstmt.setString(1, bean.getRate());
			pstmt.setInt(2, bean.getGrade());
			pstmt.setInt(3, bean.getCcode());
			pstmt.setString(4, bean.getId());

	
			
			pstmt.executeUpdate();
			
			System.out.println("성적 수정 sql구문 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("modifyGrade메소드 실행 오류 : " + e);
		} finally {
			freeResource();
		}
		
	}//modifyGrade end
	

	
		
}

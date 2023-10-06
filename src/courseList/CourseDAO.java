package courseList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

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
	public int getBoardCount(Map<String, Object> map) {
		
		int count = 0;
		String sql = "";
		
		try {
			con = ds.getConnection();
			
			sql = "select count(*) from course";
			
			 if (map.get("searchText") != null) {
		            sql += " WHERE " + map.get("search") + " "
		                 + " LIKE '%" + map.get("searchText") + "%'";
		        }
		
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
	}//getBoardCount end
	
	// 검색 조건에 맞는 게시물 목록을 반환합니다.
    public List<CourseBean> getList(Map<String, Object> map) { 
        List<CourseBean> vector = new Vector<CourseBean>();  // 결과(게시물 목록)를 담을 변수

        // 쿼리문 템플릿  
        String query = "SELECT * FROM ( " +
        	    	   "SELECT *, ROW_NUMBER() OVER (ORDER BY ccode ASC) AS rNum " +
        	    	   "FROM course ";

        //입력한 검색어가 있다면 WHERE 절이 추가 되도록  if문을 중간에 추가 하고
        if (map.get("searchText") != null) {
            query += " WHERE " + map.get("search")
                   + " LIKE '%" + map.get("searchText") + "%' ";
        }
        
        query += ") AS Tb "+
    			 "WHERE rNum BETWEEN ? AND ?"; // 시작 게시물과 끝 게시물을 조회 범위를 정하는 BETWEEN 부분 ? 로 설정 
           
        System.out.println(query);
        
        
        try {
        	con = ds.getConnection();
        	pstmt = con.prepareStatement(query);  // 쿼리문 생성
        	pstmt.setString(1, map.get("start").toString());
            pstmt.setString(2, map.get("end").toString());     	
        	
        	rs = pstmt.executeQuery();  // 쿼리 실행

            while (rs.next()) {  // 결과를 순화하며...
	           // 한 행(게시물 하나)의 내용을 bean에 저장
               CourseBean bean = new CourseBean(); 

           	   //하나씩 저장 	           
        	   bean.setCname(rs.getString("cname"));
        	   bean.setCompdiv(rs.getString("compdiv"));
        	   bean.setCompyear(rs.getInt("compyear"));
        	   bean.setCompsem(rs.getInt("compsem")); 
        	   bean.setGrade(rs.getInt("grade"));
        	   bean.setProfessor(rs.getString("professor"));        	   

        	   vector.add(bean);
            }
            
            System.out.println("CourseDAO검색 조회 중 예외 발생");
            
        } catch (Exception e) {          
            e.printStackTrace();
        } finally {
			freeResource();
		}
        
        return vector;
        
    }//getList end	

	//DB로부터 모든 강의들의 정보를 가져오는 메소드(조회)
	public ArrayList<CourseBean> getList() {
		
		//등록된 과목들을 담을 객체
		ArrayList<CourseBean> list = new ArrayList<CourseBean>();
		
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

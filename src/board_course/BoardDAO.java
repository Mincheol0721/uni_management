package board_course;

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
		
	//테이블에 저장된 레코드의 개수를 반환하는 메소드
	public int getBoardCount(Map<String, Object> map) {
		
		int count = 0;
		String sql = "";
		
		try {
			con = ds.getConnection();
			
			sql = "select count(*) from course";
			
			// 검색어가 존재하는 경우, WHERE 절에 추가
	        if (map.get("searchText") != null) {
	            sql += " WHERE " + map.get("search") + " LIKE ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, "%" + map.get("searchText") + "%");
	        } else {
	            pstmt = con.prepareStatement(sql);
	        }
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("BoardDAO내부의 getBoardCount메소드에서 예외 발생: " + e);
		} finally {
			freeResource();
		}
		
		return count;
	}//getBoardCount end

	// 검색 조건에 맞는 게시물 목록을 반환합니다.
    public List<BoardBean> getList(Map<String, Object> map) { 
        List<BoardBean> vector = new Vector<BoardBean>();  // 결과(게시물 목록)를 담을 변수

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
	           BoardBean bean = new BoardBean(); 

           	   //하나씩 저장 
	           bean.setCcode(rs.getInt("ccode"));
        	   bean.setCname(rs.getString("cname"));
        	   bean.setCompdiv(rs.getString("compdiv"));
        	   bean.setCompyear(rs.getInt("compyear"));
        	   bean.setCompsem(rs.getInt("compsem")); 
        	   bean.setGrade(rs.getInt("grade"));
        	   bean.setProfessor(rs.getString("professor"));
        	   bean.setDay(rs.getString("day")); 
        	   bean.setStarttime(rs.getInt("starttime"));
        	   bean.setEndtime(rs.getInt("endtime")); 
        	   bean.setId(rs.getString("id"));

        	   vector.add(bean);
            }
        } 
        catch (Exception e) {
            System.out.println("검색 조회 중 예외 발생");
            e.printStackTrace();
        }finally {
			freeResource();
		}

        return vector;
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
			sql = "select * from course order by ccode ASC";
			
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
				bean.setDay(rs.getString("day"));
				bean.setStarttime(rs.getInt("starttime"));
				bean.setEndtime(rs.getInt("endtime"));				
				bean.setProfessor(rs.getString("professor"));
				bean.setId(rs.getString("id"));
				
				list.add(bean);
			
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
			String sql = "insert into course (cname, compdiv, compyear, compsem, grade, day, starttime, endtime, professor, id)"
					   + " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";

			//insert문 실행할 pstmt 실행 객체 얻기
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, boardBean.getCname()); 		//과목명
			pstmt.setString(2, boardBean.getCompdiv()); 	//이수 구분
			pstmt.setInt(3, boardBean.getCompyear()); 		//이수 학년
			pstmt.setInt(4, boardBean.getCompsem()); 		//이수 학기
			pstmt.setInt(5, boardBean.getGrade()); 			//학점
			pstmt.setString(6, boardBean.getDay()); 		//요일
			pstmt.setInt(7, boardBean.getStarttime()); 		//시작 교시
			pstmt.setInt(8, boardBean.getEndtime()); 		//끝 교시
			pstmt.setString(9, boardBean.getProfessor()); 	//담당 교수 이름
			pstmt.setString(10, boardBean.getId());			//담당 교수 아이디

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
	        StringBuilder sqlBuilder = new StringBuilder("INSERT IGNORE INTO course (cname, compdiv, compyear, compsem, grade, day, starttime, endtime, professor, id) VALUES ");
	        for (int i = 0; i < arrayList.size(); i++) {
	            if (i > 0) {
	                sqlBuilder.append(", ");
	            }
	            sqlBuilder.append(" (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
	        }
	        	     	        
	        // insert 문 실행할 pstmt 실행 객체 얻기
	        String sql = sqlBuilder.toString();
	        
	        System.out.println("insertMultipleSB sql문 : " + sql);
	        
	        pstmt = con.prepareStatement(sql);
	        
	        for (int i = 0; i < arrayList.size(); i++) {
	        	
	            BoardBean boardBean = arrayList.get(i);
	            
	            pstmt.setString(i * 10 + 1, boardBean.getCname());       //과목명
	            pstmt.setString(i * 10 + 2, boardBean.getCompdiv());     //이수 구분
	            pstmt.setInt(i * 10 + 3, boardBean.getCompyear());       //이수 학년
	            pstmt.setInt(i * 10 + 4, boardBean.getCompsem());        //이수 학기
	            pstmt.setInt(i * 10 + 5, boardBean.getGrade());          //학점
	            pstmt.setString(i * 10 + 6, boardBean.getDay()); 		 //요일
	            pstmt.setInt(i * 10 + 7, boardBean.getStarttime()); 	 //시작 교시
	            pstmt.setInt(i * 10 + 8, boardBean.getEndtime()); 		 //끝 교시
	            pstmt.setString(i * 10 + 9, boardBean.getProfessor());   //담당 교수 이름
	            pstmt.setString(i * 10 + 10, boardBean.getId());   		 //담당 교수 아이디
	            
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
				bean.setDay(rs.getString("day"));
				bean.setStarttime(rs.getInt("starttime"));
				bean.setEndtime(rs.getInt("endtime"));
				bean.setProfessor(rs.getString("professor"));
				bean.setId(rs.getString("id"));				
				
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
			String sql = "update course set cname=?, compdiv=?, compyear=?, compsem=?, grade=?, day=?, starttime=?, endtime=? where ccode=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, bean.getCname());
			pstmt.setString(2, bean.getCompdiv());
			pstmt.setInt(3, bean.getCompyear());
			pstmt.setInt(4, bean.getCompsem());
			pstmt.setInt(5, bean.getGrade());
			pstmt.setString(6, bean.getDay());
			pstmt.setInt(7, bean.getStarttime());
			pstmt.setInt(8, bean.getEndtime());
			pstmt.setInt(9, bean.getCcode());		
			
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

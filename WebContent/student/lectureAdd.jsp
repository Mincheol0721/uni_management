<%@page import="course.CourseVO"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="cHistory.CHistoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//강의개설테이블을 조회한 Ccode의 값을 배열로 담아서 저장
	String[] Ccodes = request.getParameterValues("Ccodes");
	
	//String 배열으로 가져온 Ccode의 값을 for문을 사용하기 위해서 list배열에 저장
	List<String> list = Arrays.asList(Ccodes);  
	
	//Session객체에서 Id값을 가져옴
	String id = (String) session.getAttribute("id");
	
	//cHistoryDAO의 checked메소드의 값을 저장할 변수
	int check = 0;
	
	// cHistoryDAO객체 생성
	CHistoryDAO cHistoryDAO = new CHistoryDAO();
	
	for (String Ccode : list) {
	
		cHistoryDAO.insertBoard(id, Ccode);
		 
	} 
	// cHistoryVO를 담을 배열 생성
	List<CourseVO> list2 = null;
	// cHistoryDAO의 getBoardList메소드를 통해 테이블목록을 가져와서 List배열에 저장
	list2 = cHistoryDAO.getBoardList(id); // 강의내역과 강의목록을 테이블을 join해서 배열에 담아 저장함
%>
<%=check%>

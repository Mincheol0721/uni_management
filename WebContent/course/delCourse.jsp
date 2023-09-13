<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@page import="java.sql.*"%>

<jsp:useBean id="dao" class="board_course.BoardDAO"/>
	
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//listCourse.jsp 에서 삭제할 과목 코드 받아오기
	int ccode = Integer.parseInt(request.getParameter("ccode"));
	
	//DB작업
	dao.delCourse(ccode);
	
%>

<script>

	alert("선택한 과목이 삭제되었습니다.");
	location.href="listCourse.jsp";
	
</script>
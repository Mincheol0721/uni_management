<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<jsp:useBean id="dao" class="grade_professor.GradePDAO"/>
	
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//listGrade.jsp 에서 초기화할 과목명, 학생아이디 받아오기	
	String id = request.getParameter("id");
	
	int ccode = Integer.parseInt(request.getParameter("ccode"));
	
	System.out.println("성적 초기화시킬 과목 코드 : " + ccode);
	
	System.out.println("성적 초기화시킬 학생아이디 : " + id);
	
	//DB작업
	dao.resetGradeAndRate(ccode,id);
	
%>

<script>

	alert("초기화되었습니다.");
	var cnameParam = encodeURIComponent("<%=ccode%>");
	location.href = "listGrade.jsp?ccode=" + cnameParam;
	
</script>
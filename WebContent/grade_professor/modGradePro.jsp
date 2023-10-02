<%@page import="grade_professor.GradeBean"%>
<%@page import="grade_professor.GradePDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

%>

<%

	GradePDAO pdao = new GradePDAO();

	GradeBean bean = new GradeBean(					
			Integer.parseInt(request.getParameter("ccode")),
			request.getParameter("cname"),
			request.getParameter("id"),
			request.getParameter("name"),
			Integer.parseInt(request.getParameter("grade")),			
			request.getParameter("rate"),
			(String)session.getAttribute("propid")
			);
	
	//DB작업
	pdao.modifyGrade(bean);	
%>

<script>

	alert("성적이 수정되었습니다.");
	location.href = "listGrade.jsp";

	
</script>
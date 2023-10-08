<%@page import="cPlan.CplanDTO"%>
<%@page import="cPlan.CplanDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

// 	System.out.println("Pro타는중... week=" + request.getParameter("week"));

	int grade = Integer.parseInt(request.getParameter("grade"));
	int compyear = Integer.parseInt(request.getParameter("compyear"));
	int compsem = Integer.parseInt(request.getParameter("compsem"));
	
	CplanDAO dao = new CplanDAO();

	CplanDTO dto = new CplanDTO(
			request.getParameter("cname"),
			request.getParameter("dept"),
			grade,
			request.getParameter("time"),
			request.getParameter("compdiv"),
			compyear,
			compsem,		
			request.getParameter("email"),			
			request.getParameter("content"),			
			request.getParameter("purpose"),			
			request.getParameter("books")				
			);
 
	//DB작업
	dao.modifyCplan(dto);
%>

<script>

	alert("선택한 강의계획서가 수정되었습니다.");
	location.href = "cPlanMod.jsp?cname=" + encodeURIComponent("<%=dto.getCname()%>");

	
</script>
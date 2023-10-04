<%@page import="homework.HomeWorkBoardDTO"%>
<%@page import="homework.HomeworkProfessorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

%>

<%
	
	HomeworkProfessorDAO dao = new HomeworkProfessorDAO();

	HomeWorkBoardDTO dto = new HomeWorkBoardDTO(		
			request.getParameter("name"),
			Integer.parseInt(request.getParameter("num")),
			request.getParameter("cname"),
			request.getParameter("tasktype"),
			request.getParameter("tasktitle"),
			request.getParameter("taskmethod"),
			request.getParameter("period"),
			request.getParameter("homework"),			
			Integer.parseInt(request.getParameter("numpeople"))
			);
 
	//DB작업
	dao.modHomework(dto);	
%>

<script>

	alert("선택한 과제 양식이 수정되었습니다.");
	location.href = "homework_professor.jsp?cname=" + encodeURIComponent("<%=dto.getCname()%>");

	
</script>
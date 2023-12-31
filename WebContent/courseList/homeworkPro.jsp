<%@page import="homework.HomeWorkBoardDTO"%>
<%@page import="homework.HomeworkProfessorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	int week = Integer.parseInt(request.getParameter("week"));
	int sess = Integer.parseInt(request.getParameter("session"));
	int num = Integer.parseInt(request.getParameter("num"));
	
	HomeworkProfessorDAO dao = new HomeworkProfessorDAO();
	String period = request.getParameter("period1") + "~" + request.getParameter("period2");
	
	HomeWorkBoardDTO dto = new HomeWorkBoardDTO(		
			request.getParameter("name"),
			num,
			request.getParameter("cname"),
			request.getParameter("tasktype"),
			request.getParameter("tasktitle"),
			request.getParameter("taskmethod"),
			period,
			request.getParameter("homework"),			
			Integer.parseInt(request.getParameter("numpeople"))
			);
 
	//DB작업
	dao.modHomework(dto,num);	  
%>

<script>

	alert("선택한 과제 양식이 수정되었습니다.");
	location.href = "moreInfo_professor.jsp?cname=" + encodeURIComponent("<%=dto.getCname()%>");

	
</script>

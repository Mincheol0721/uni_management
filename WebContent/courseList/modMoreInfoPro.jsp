<%@page import="courseList.MoreInfoBean"%>
<%@page import="courseList.MoreInfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

%>


<%

	MoreInfoDAO dao = new MoreInfoDAO();

	MoreInfoBean bean = new MoreInfoBean(		
			request.getParameter("cname"),
			Integer.parseInt(request.getParameter("week")),
			Integer.parseInt(request.getParameter("session")),
			request.getParameter("topic"),
			request.getParameter("way"),
			request.getParameter("day"),
			Integer.parseInt(request.getParameter("starttime")),
			Integer.parseInt(request.getParameter("endtime")),			
			request.getParameter("homework"),
			(String)session.getAttribute("id")
			);
 
	//DB작업
	dao.modifyMoreInfo(bean);	
%>

<script>

	alert("선택한 강의가 수정되었습니다.");
	location.href = "moreInfo_professor.jsp?cname=" + encodeURIComponent("<%=bean.getCname()%>");

	
</script>
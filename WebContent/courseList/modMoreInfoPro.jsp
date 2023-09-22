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
			request.getParameter("time"),
			request.getParameter("homework")
			);
	
	   System.out.println("받아오는 주차 : " + request.getParameter("modweek"));	
       System.out.println("받아오는 강의명 : " + request.getParameter("cname"));
 
	//DB작업
	dao.modifyMoreInfo(bean);	
%>

<script>

	alert("선택한 강의가 수정되었습니다.");
	location.href = "moreInfo.jsp?cname=" + encodeURIComponent("<%=bean.getCname()%>");

	
</script>
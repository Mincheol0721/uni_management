<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<jsp:useBean id="dao" class="courseList.MoreInfoDAO"/>
	
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//moreInfo_professor.jsp 에서 삭제할 과목명, 해당 주차 받아오기
	String cname = request.getParameter("cname");
	
	int week = Integer.parseInt(request.getParameter("week"));
	
	System.out.println("받아온 삭제할 과목명 : " + cname);
	
	System.out.println("받아온 삭제할 과목 교육 주차 : " + week);
	
	//DB작업
	dao.delMoreInfo(cname,week);
	
%>

<script>

	alert("선택한 세부 정보가 삭제되었습니다.");
	var cnameParam = encodeURIComponent("<%=cname%>");
	location.href = "moreInfo_professor.jsp?cname=" + cnameParam;
	
</script>
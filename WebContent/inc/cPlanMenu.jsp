<%@page import="member.EmployeeDAO"%>
<%@page import="member.StudentDAO"%>
<%@page import="member.ProfessorDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%!
	String job;
	String id;
	MemberDTO dto;
	String cname;
%>

<% 
	request.setCharacterEncoding("UTF-8"); 
	
	job = (String)session.getAttribute("job");
	id = (String)session.getAttribute("id");
	
	cname = request.getParameter("cname");
	dto = new MemberDTO();
	
	if(id != null) {
		ProfessorDAO pdao = new ProfessorDAO();
		StudentDAO sdao = new StudentDAO();
		EmployeeDAO edao = new EmployeeDAO();
		
		System.out.println("직업: " + job);
		System.out.println("id: " + id);
		
		
		if(job.equals("교수")){
			dto = pdao.selectMember(id);
		} else if(job.equals("학생")){
			dto = sdao.selectMember(id);
		} else if(job.equals("교직원")){
			dto = edao.selectMember(id);
		}
	}

%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<c:set var="job" value="${sessionScope.job}" />
<c:set var="id" value="${sessionScope.id}" />
<a class="nav-link menu" href="${path}/student/cHistory.jsp">수강 강좌</a>
<a class="nav-link menu" href="${path}/moreInfo/moreInfo.jsp?cname=<%=cname%>">세부강의 페이지</a>
<a class="nav-link menu" href="${path}/homework/homeworkBoard.jsp?cname=<%=cname%>">과제 제출 게시판</a> 
<a class="nav-link menu" href="${path}/homework/homework.jsp?cname=<%=cname%>">과제 확인 게시판</a>
<%@page import="schedule.ScheduleDAO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="schedule.ScheduleDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	String sdate = startDate + " ~ " + endDate;
	String sclass= request.getParameter("sclass");
// 	System.out.println("sclass: " + sclass);
	
	dto.setSdate(sdate);
	
 	new ScheduleDAO().insertBoard(dto); 

 	response.sendRedirect(request.getContextPath() + "/menu/schedule.jsp"); 


%>
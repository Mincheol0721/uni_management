<%@page import="notice.NoticeDAO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
	request.setCharacterEncoding("UTF-8"); 
	String nclass = request.getParameter("select");
%>

<jsp:useBean id="dto" class="notice.NoticeDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	dto.setNclass(nclass);
	System.out.println("Proclass: " + dto.getNclass());
	new NoticeDAO().insertBoard(dto);

	response.sendRedirect(request.getContextPath() + "/menu/notice.jsp");


%>
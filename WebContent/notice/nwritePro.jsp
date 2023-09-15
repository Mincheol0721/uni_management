<%@page import="notice.NoticeDAO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="notice.NoticeDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	
	new NoticeDAO().insertBoard(dto);

	response.sendRedirect(request.getContextPath() + "/menu/notice.jsp");


%>
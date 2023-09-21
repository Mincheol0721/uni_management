<%@page import="qna.QnaDAO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="qna.QnaDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	
	new QnaDAO().insertBoard(dto); 

	response.sendRedirect(request.getContextPath() + "/menu/qna.jsp"); 


%>
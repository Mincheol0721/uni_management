<%@page import="qna.QnaDAO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="qna.QnaDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	int no = Integer.parseInt( request.getParameter("no") );
	
	System.out.println("answerpro: " + no);
	
	new QnaDAO().insertBoard(dto);  

	response.sendRedirect(request.getContextPath() + "/qna/viewQna.jsp?no="+no);


%>
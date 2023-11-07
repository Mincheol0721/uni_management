<%@page import="qna.QnaDAO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="qna.QnaDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	int pno = Integer.parseInt( request.getParameter("no") );
	int pos = Integer.parseInt( request.getParameter("pos") );
	int level = Integer.parseInt( request.getParameter("level") );
	
	System.out.println("answer pno: " + pno);
	System.out.println("answer pos: " + pos);
	System.out.println("answer lvl: " + level);
	
	QnaDAO dao = new QnaDAO();

	dao.replyUppos(pos);
	
	dao.insertAnswer(dto, pno); 

	response.sendRedirect(request.getContextPath() + "/menu/qna.jsp");


%>
<%@page import="java.util.List"%>
<%@page import="qna.QnaDTO"%>
<%@page import="qna.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
   request.setCharacterEncoding("UTF-8"); 
   response.setContentType("text/html; charset=utf-8");
   
   String keyField = request.getParameter("keyField");
   String searchText = request.getParameter("searchText");


	byte[] utf8Bytes = searchText.getBytes("UTF-8");
	String searchText_ = new String(utf8Bytes, "ISO-8859-1");

   
//    System.out.println(keyField + " + " + searchText);
   
   QnaDAO dao = new QnaDAO();
   
   List list = dao.getBoardList(keyField, searchText);
   
   if(searchText != null || searchText.length() != 0) {
      response.sendRedirect(request.getContextPath() + "/menu/qna.jsp?keyField=" + keyField + "&searchText=" + searchText_);   
   } else {
      response.sendRedirect(request.getContextPath() + "/menu/qna.jsp");   
   }
   
   
%>

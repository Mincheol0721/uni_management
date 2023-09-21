<%@page import="cHistory.CHistoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	//이메일보내기를 클릭한 교수명 가져오기
	String professorName = request.getParameter("professorName"); 
	//professorName = 김교수 박교수 올바르게 들고옴
	//세션객체에서 id를 들고와서 id변수에 저장
	String id = (String)session.getAttribute("id");
	//cHistoryDao 객체 생성
	CHistoryDAO cHistoryDAO = new CHistoryDAO();
		//성적 데이터베이스의 교수명과 클릭한 교수명이랑 비교해서 이메일을 가져올 메소드
 	String email = cHistoryDAO.selectProfessorEmail(id,professorName);	
%>
<%=email%>
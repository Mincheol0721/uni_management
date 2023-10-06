<%@page import="homework.HomeWorkDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//요청한 값 얻기
	String num = request.getParameter("num");
	
	String cname = request.getParameter("cname");
	
	String path = application.getRealPath("/upload/");
	
	//데이터베이스와 연동해 컬럼을 삭제할 DAO객체 생성
	HomeWorkDAO homeworkDAO = new HomeWorkDAO();
	
	homeworkDAO.deleteSearch(num,path);
	
	homeworkDAO.deleteHomework(num);
	
%>
<script>
	alert("과제가 삭제 되었습니다.");
	location.href = 'homework.jsp?cname=<%=cname%>';
</script>
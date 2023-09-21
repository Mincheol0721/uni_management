<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	String course = request.getParameter("course");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 파일 업로드 요청 화면</title>
</head>
<body>
	
	<%-- 파일 업로드 요청!(실제 업로드되는 파일은 웹서버의 하드디스크에 저장되고, 업로드되는 파일명만?DB에 저장됩니다.  --%>
	<form action="fileUploadAction.jsp" method="post" enctype="multipart/form-data">
		<input type="text" hidden="" value="" name="id">
		<input type="text" hidden="" value="" name="course">
		제목: <input type="text" name="title"><br>
		<textarea rows="20" cols="60" name="content"></textarea><br>
		<input hidden="" type="text" name="submitHomeWork" value="y">
		첨부파일 :	<input type="file" name="file"> 
		<input type="submit" value="전송하기">
		<input type="button" value="취소">
	</form>

	<br>
	
	
</body>
</html>



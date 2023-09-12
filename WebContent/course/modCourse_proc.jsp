<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

%>

<jsp:useBean id="dao" class="board_course.BoardDAO"/>

<jsp:useBean id="bean" class="board_course.BoardBean"/>
<jsp:setProperty property="*" name="bean"/>

<%
	dao.modifyCourse(bean);

%>

<script>

	alert("수정 완료되었습니다.");
	location.href="listCourse.jsp";

</script>






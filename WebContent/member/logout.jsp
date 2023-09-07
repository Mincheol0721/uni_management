<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//session객체 메모리에 접근해서 저장되어 있는 입력한아이디 제거
	session.removeAttribute("id");
%>
<script type="text/javascript">
	alert("로그아웃되셨습니다.");
	location.href = "../index.jsp";
</script>
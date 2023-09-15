<%@page import="member.MemberDTO"%>
<%@page import="member.ProfessorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% 
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String ssn = request.getParameter("ssn");
	String email = request.getParameter("email");
	String addr = request.getParameter("addr");
	String pwd = request.getParameter("pwd");
	String faculty = request.getParameter("faculty");
	String dept = request.getParameter("dept");
	
	

	
	ProfessorDAO dao = new ProfessorDAO();
	
	MemberDTO dto = new MemberDTO(id,pwd,name,email,addr,tel,ssn,
			dept,faculty);
	
	dao.updateProfessor(dto);
	 
	RequestDispatcher dispatcher = request.getRequestDispatcher("professorList.jsp");
		dispatcher.forward(request, response);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
<%@page import="member.StudentDAO"%>
<%@page import="member.MemberDTO"%>
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

	
	StudentDAO dao = new StudentDAO();
	
	MemberDTO dto = new MemberDTO(id, pwd, name, email, addr, tel, ssn,
			 dept, faculty);
	
	dao.insertMember(dto);
	
	response.sendRedirect("professorList.jsp");
%>
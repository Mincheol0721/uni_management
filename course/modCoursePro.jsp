<%@page import="board_course.BoardBean"%>
<%@page import="board_course.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

%>


<%

	BoardDAO dao = new BoardDAO();

	BoardBean bean = new BoardBean(		
			Integer.parseInt(request.getParameter("ccode")),
			request.getParameter("cname"),
			request.getParameter("compdiv"),
			Integer.parseInt(request.getParameter("compyear")),
			Integer.parseInt(request.getParameter("compsem")),
			Integer.parseInt(request.getParameter("grade"))
			);
	
	   System.out.println("");	
       System.out.println("받아오는 코드값 : " + request.getParameter("ccode"));
//     System.out.println(request.getParameter("cname"));
//     System.out.println(request.getParameter("compdiv"));
//     System.out.println(request.getParameter("compyear"));
//     System.out.println(request.getParameter("compsem"));
//     System.out.println(request.getParameter("grade"));
    
	//DB작업
	dao.modifyCourse(bean);	
%>

<script>

	alert("선택한 과목이 수정되었습니다.");
	location.href="listCourse.jsp";
	
</script>
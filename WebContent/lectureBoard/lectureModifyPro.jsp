<%@page import="lectureBoard.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//요청한 값 얻기
	String lectureYear = request.getParameter("lectureYear");// 수강년도	
	String semesterDivide = request.getParameter("semesterDivide"); //수강학기
	String rate = request.getParameter("rate"); //평가
	String lectureDivide = request.getParameter("lectureDivide"); // 강의구분
	String title = request.getParameter("title"); //글 제목
	String mainText = request.getParameter("mainText"); // 글내용
	String num =  request.getParameter("num");
	String path = request.getContextPath();
	
	//수정반영하기를 누르면 쓰여있던글을 수정시킬 DAO객체 생성및 메소드 사용
	LectureDAO lectureDAO = new LectureDAO();
		int check = lectureDAO.getUpdateBoard(title, lectureYear, semesterDivide, lectureDivide, mainText, num, rate);
		
		if(check == 1) {
%>
		<script>
		alert("수정되었습니다.");
		location.href = 'lectureModify.jsp?num='+ <%=num%>;
		</script>
		
<% 
	}else {
%>
	<script>
		alert("수정에 실패하였습니다.")
	</script>
<%
	}
%>			
		    

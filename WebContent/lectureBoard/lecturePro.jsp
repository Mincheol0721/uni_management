<%@page import="java.sql.Timestamp"%>
<%@page import="lectureBoard.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%

//한글처리
request.setCharacterEncoding("UTF-8"); 
%>
<jsp:useBean id="lecVO" class="lectureBoard.LectureVO"></jsp:useBean>
<jsp:setProperty property="*" name="lecVO"/>        
<%
	lecVO.setDate(new Timestamp(System.currentTimeMillis()));

	//요청한 값 얻기
	String name = request.getParameter("name");
	String lectureName = request.getParameter("lectureName");
	String title = request.getParameter("title");
	String professorName = request.getParameter("professorName");
	String lectureYear = request.getParameter("lectureYear");
	String semesterDivide = request.getParameter("semesterDivide");
	String lectureDivide = request.getParameter("lectureDivide");
	String mainText = request.getParameter("mainText");
	String rate = request.getParameter("rate");
	
	String path = request.getContextPath();
	
	out.print(path);
	//모든 입력공간에 입력안된게 하나라도 있으면?
	if(name == null || lectureYear == null || semesterDivide == null || lectureDivide == null || title == null 
	|| title.equals("") || mainText.equals("")) {
%>
	<script>
		alert("입력안된사항이 있습니다.");
		history.back();
	</script>
<%
		return;
	}else{
		//DAO객체 생성 하기
		LectureDAO lectureDAO = new LectureDAO();
		
		//DAO객체의 insertBoard메소드를 이용해서 등록하기를 누른후에 <input>값을 LectureBoard 테이블에 집어넣기!
		lectureDAO.insertBoard(lecVO);
%>
		<script type="text/javascript">
			alert("등록 되었습니다.");
			
			window.close();
			opener.document.location.reload();
		</script>

<%		
	}
	
	
	
	
%>
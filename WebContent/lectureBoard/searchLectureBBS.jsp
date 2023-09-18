<%@page import="lectureBoard.LectureDAO"%>
<%@page import="lectureBoard.LectureVO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	// courseVO를 담을 배열 생성
	List<LectureVO> list = null;

	//검색 버튼을 눌렀을때 처리할 DAO객체생성 및 메소드 사용
	LectureDAO lectureDAO = new LectureDAO();

	//전체글 개수
	int count = lectureDAO.getBoardCount();

	//요청한 값 얻기
	String searchField = request.getParameter("searchField");
	String searchText = request.getParameter("searchText");
	
	list = lectureDAO.searchBoard(searchField, searchText);
	
	 SimpleDateFormat sdf = new SimpleDateFormat("yyy.MM.dd");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 처리 페이지</title>
</head>
<body>
	<div class="row">
                        	
                        	<p class="mb-0">
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec"> 
                   	           		<tr bgcolor="lightgrey" align="center" id="menu_re">
                   	           			<td width=5% hidden="">글번호</td>
                   	           			<td width=5%>학생명</td>
                   	           			<td width=5%>글제목</td>
                   	           			<td width=5%>강의명</td>
                   	           			<td width=5%>교수명</td>
                   	           			<td width=5%>평가</td>
                   	           			<td width=5%>작성날짜</td>
                   	           		</tr>
                   	           		<span id="searchAddZone">
                   	           		</span>
                   	           		
                   	          <% 
                   	          	//만약 게시판글개수가 존재하고(게시판에 글이 있다면)
                   	          	if(count > 0) {
                   	          		for(int i=0; i <list.size(); i++) {
                   	          			LectureVO lec = list.get(i);
                   	          	%>
                   	          		
                   	          		<tr align="center" style="border-bottom: 1px, solid, lightgrey;" id="searchZone">
                   	           			<td width=5% hidden=""><%=lec.getNum()%></td>
                   	           			<td width=5%><%=lec.getName()%></td>
                   	           			<td width=5%><a href="lectureModify.jsp?num=<%=lec.getNum()%>" style="text-decoration: none"><%=lec.getTitle()%></a></td>
                   	           			<td width=5%><%=lec.getLectureName()%></td>
                   	           			<td width=5%><%=lec.getProfessorName()%></td>
                   	           			<td width=5%><%=lec.getRate()%></td>
                   	           			<td width=5%><%=sdf.format(lec.getDate())%></td>
                   	           		</tr>
                   	           		
                   	          	<%	
                   	          		}//for 끝 
                   	          	}else { //게시판이 글개수가 존재하지 않으면
                   	          %> 		
                   	           	<tr>
                   	           		<td colspan="7" align="center">게시판 글 없음</td>
                   	           	</tr>
                   	           	<%
                   	          	} // if ~ else의 끝
                   	         	%>
                   	           </table>
                            </p>
                        </div>
	
</body>
</html>

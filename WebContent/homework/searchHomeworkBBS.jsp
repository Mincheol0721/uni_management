<%@page import="homework.HomeWorkBoardDAO"%>
<%@page import="homework.HomeWorkBoardDTO"%>
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
	List<HomeWorkBoardDTO> list = null;

	//검색 버튼을 눌렀을때 처리할 DAO객체생성 및 메소드 사용
	HomeWorkBoardDAO homeDAO = new HomeWorkBoardDAO();

	String cname = request.getParameter("cname");
	
// 	out.print(cname);
	//요청한 값 얻기
	String searchField = request.getParameter("searchField");
	String searchText = request.getParameter("searchText");
	
	list = homeDAO.searchBoard(searchField, searchText,cname);
			
	int count = homeDAO.getSearchCount(searchField, searchText,cname);
	
	 

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
                   	           			<td width=5%>과제유형</td>
                   	           			<td width=5%>과제제목</td>
                   	           			<td width=5%>제출방법</td>
                   	           			<td width=5%>제출기간</td>
                   	           			<td width=5%>제출여부</td>
                   	           			<td width=5% hidden="">제출인원</td>
                   	           		</tr>
                   	           		<span id="searchAddZone">
                   	           		</span>
                   	           		
                   	          <% 
                   	          	//만약 게시판글개수가 존재하고(게시판에 글이 있다면)
                   	          	if(count > 0) {
                   	          		for(int i=0; i <list.size(); i++) {
                   	          			HomeWorkBoardDTO home = list.get(i);
                   	          			
                   	          	%>
                   	          		
                   	          		<tr align="center" style="border-bottom: 1px, solid, lightgrey;" id="searchZone">
                   	           			<td width=5% hidden=""><%=home.getNum()%></td>
                   	           			<td width="5%" hidden=""><%=home.getCname()%></td>
                   	           			<td width=5%><%=home.getTasktype()%></td>
                   	           			<td width=5%><a href="homeWorkBoardModify.jsp?num=<%=home.getNum()%>&cname=<%=home.getCname()%>&tasktitle=<%=home.getTasktitle()%>" style="text-decoration: none"><%=home.getTasktitle()%></a></td>
                   	           			<td width=5%><%=home.getTaskmethod()%></td>
                   	           			<td width=5%><%=home.getPeriod()%></td>
       									<td width=5%>미제출</td>
                   	  
                   	           			<td width=5% hidden=""><%=home.getNumpeople()%></td>
                   	           			
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

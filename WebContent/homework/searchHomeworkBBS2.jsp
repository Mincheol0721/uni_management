<%@page import="homework.HomeWorkDAO"%>
<%@page import="homework.HomeWorkDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();	
	

	//한글처리
	request.setCharacterEncoding("UTF-8");

	// courseVO를 담을 배열 생성
	List<HomeWorkDTO> list = null;

	//검색 버튼을 눌렀을때 처리할 DAO객체생성 및 메소드 사용
	HomeWorkDAO homeDAO = new HomeWorkDAO();

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
                   	           			
                   	           			<td width=5%>학생명</td>
                   	           			<td width=5%>과제명</td>
                   	           			<td width=5%>제목</td>
                   	           			<td width=5%>제출 일자</td>
                   	           			<td width=5%>다운로드</td>
                   	           		</tr>
                   	           		<span id="searchAddZone">
                   	           		</span>
                   	           		
                   	          <%
              	           		         //만약 게시판글개수가 존재하고(게시판에 글이 있다면)
             	           		               if(count > 0) {
              	           		       for(int i=0; i <list.size(); i++) {
              	           		     HomeWorkDTO home = list.get(i);
              	          		%>
                   	          		
                   	          		<tr align="center" style="border-bottom: 1px, solid, lightgrey;" id="searchZone">
                   	           			
                   	           			<td width="5%"><%=home.getStudentName()%></td>
                   	           			<td width=5%><%=home.getTaskTitle()%></td>
                   	           			<td width=5%><a href="homeWorkModify.jsp?num=<%=home.getNum()%>" style="text-decoration: none"><%=home.getTitle()%></a></td>
                   	           			<td width=5%><%=home.getDate()%></td>
                   	           			<td width=5% ><a href="<%=contextPath%>/homework/fileDownAction.jsp?directory=upload&fileRealName=<%=home.getFileRealName()%>"   class="btn btn-primary me-md-2" id="down">다운로드</a></td>
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

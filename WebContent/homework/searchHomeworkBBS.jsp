<%@page import="homework.HomeWorkDAO"%>
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
	
	String id =  (String)session.getAttribute("id");

	// courseVO를 담을 배열 생성
	List<HomeWorkBoardDTO> list = null;

	//검색 버튼을 눌렀을때 처리할 DAO객체생성 및 메소드 사용
	HomeWorkBoardDAO homeDAO = new HomeWorkBoardDAO();

	String cname = request.getParameter("cname");
	
	//사용자의 이름을 가져오는 구문
	HomeWorkBoardDTO name = homeDAO.getStudentName(id);
	
	String studentName = name.getName();
	
// 	out.print(cname);
	//요청한 값 얻기
	String searchField = request.getParameter("searchField");
	String searchText = request.getParameter("searchText");
	
	//--------------------------------------------------------
	
	//하나의 화면 마다 보여줄 글개수 = 5
	 int pageSize = 5;
	
	 int count = homeDAO.getSearchCount(searchField, searchText,cname);
	 
	 //---------------------------
	 //현재 보여질(선택한) 페이지번호 가져오기.
	 String pageNum = request.getParameter("pageNum");
	 //현재보여질(선택한) 페이지번호가 없으면 1페이지 처리
	 if(pageNum == null) {
		 pageNum = "1";
	 }
	 /* 현재 보여질(선택한) 페이지 번호*/
	 //현재보여질(선택한) 페이지번호 "1"을 -> 기본점수 1로 변경
	 int currentPage = Integer.parseInt(pageNum);
	 //------------------------------------------------
	 
	 /* 각페이지 마다 맨위에 첫번째로 보여질 시작 글번호 구하기*/
	 //(현재 보여질 페이지번호 -1) * 한페이지당 보여줄 글개수 5
	 int startRow = (currentPage-1)*pageSize;
	
	 if(count > 0) {
	list = homeDAO.searchBoard(searchField, searchText,cname,startRow,pageSize);
	 }		
	
	
	 

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
                   	          	HomeWorkDAO homeWork = new HomeWorkDAO();
                   	          	//만약 게시판글개수가 존재하고(게시판에 글이 있다면)
                   	          	if(count > 0) {
                   	          		for(int i=0; i <list.size(); i++) {
                   	          			HomeWorkBoardDTO home = list.get(i);
                   	          			
                   	          		String taskTitle = home.getTasktitle();
           	           				String check = homeWork.getHomeWorkOK(studentName, taskTitle);
                   	          			
                   	          	%>
                   	          		
                   	          		<tr align="center" style="border-bottom: 1px, solid, lightgrey;" id="searchZone">
                   	           			<td width=5% hidden=""><%=home.getNum()%></td>
                   	           			<td width="5%" hidden=""><%=home.getCname()%></td>
                   	           			<td width=5%><%=home.getTasktype()%></td>
                   	           			<%
                   	           				if(check.equals("제출완료")){
                   	           			%>
                   	           				<td width=5%><a style="text-decoration: none" id="tasktit"><%=home.getTasktitle()%></a></td>
                   	           			<%
                   	           				}else {
                   	           			%>
                   	           				<td width=5%><a href="homeWorkBoardModify.jsp?num=<%=home.getNum()%>&cname=<%=home.getCname()%>&tasktitle=<%=home.getTasktitle()%>" style="text-decoration: none" id="tasktit"><%=home.getTasktitle()%></a></td>
                   	           			<%
                   	           				} 
                   	           			%>
                   	           			
                   	           			<td width=5%><%=home.getTaskmethod()%></td>
                   	           			<td width=5%><%=home.getPeriod()%></td>
                   	           			
                   	           			
       									<td width=5% id="check"><%=check%></td>
                    	  				<%-- 	<td>체크 값 :<%=check%></td> --%>
                  	  			        <%--		<td>과제명 : <%=taskTitle%></td> --%>
                  	  			        
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
                             <%
                        	if(count>0) {
                        		//전체 페이지수 구하기 글 20개 한페이지 보여줄 글수 10개 => 2페이지
                        		//				글 25개 한페이지 보여줄 글수 10개 => 3페이지
                        		//				조건(삼항)연산자 조건?참!거짓
                        		//전체 페이지수 = 전체글 / 한페이지에 보여줄 글수 + (전체글수를 한페이지에 보여줄 글수로 나눈 나머지값)
                        		int pageCount = count/pageSize + (count%pageSize == 0 ? 0:1);
                        		//한 화면(한블럭)에 보여줄 페이지수 설정
                        		int pageBlock = 1;
                        		
                        		/* 시작페이지 번호 구하기*/
                        		//1~10 =>1 11 ~ 20 => 11 21~30 => 21
                        		//((현재보여질(선택한)페이지 번호 / 한화면(한블럭)에 보여줄 페이지수))
                        		//(현재 보여질(선택한) 페이지 번호를 한화면에 보여줄 페이지수로 나눈 나머지값)
                        		//한화면(한블럭)에 보여줄 페이지수 +1
                        		int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock==0?1:0))*pageBlock+1;
                        		
                        		//끝페이지 번호 구하기 1~10 => 10 11~20 21~30 => 30
                        		int endPage = startPage+pageBlock-1; // 시작페이지번호 + 현재블럭에 보여줄 페이지수 -1
                        		//끝페이지번호가 전체페이지수보다 클때...
                        		if(endPage > pageCount) {
                        			//끝페이지번호를 전체페이지수로 저장
                        			endPage = pageCount;
                        		}
                        		//[이전] 시작페이지 번호가 한화면에 보여줄 페이지수 보다 클때...
                        		if(startPage > pageBlock) {
                        			%><a href="homeworkBoard.jsp?pageNum=<%=startPage-pageBlock%>&cname=<%=cname%>&searchText=<%=searchText%>&searchField=<%=searchField%>">[이전]</a><%
                        		}
                        		//[1][2][3][4]...[10]
                        		for(int i=startPage; i<=endPage; i++) {
                        			%><a href="homeworkBoard.jsp?pageNum=<%=i%>&cname=<%=cname%>&searchText=<%=searchText%>&searchField=<%=searchField%>" id="a">[<%=i%>]</a><%
                        		}
                        		//[다음] 끝페이지 번호가 전체페이지수 보다 작을때..
                        		if(endPage < pageCount) {
                        			%><a href="homeworkBoard.jsp?pageNum=<%=startPage+pageBlock%>&cname=<%=cname%>&searchText=<%=searchText%>&searchField=<%=searchField%>" id="b">[다음]</a><%
                        		}
                        	}
                        %>
                        </div>              

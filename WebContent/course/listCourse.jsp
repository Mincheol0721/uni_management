<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.ProfessorDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board_course.BoardBean"%>
<%@page import="board_course.BoardDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
//한글처리
	request.setCharacterEncoding("UTF-8"); 

	//id, 직업 값 얻어오기
	String id = (String)session.getAttribute("id");
	String job = (String)session.getAttribute("job");
	
//	System.out.println("listCourse.jsp id: " + id);
//	System.out.println("listCourse.jsp job: " + job);
	 
	BoardDAO dao = new BoardDAO();
	BoardBean bean = new BoardBean();
	List<BoardBean> list = null; 
	
	//전체 글 개수
	int count = dao.getBoardCount(); 
//	System.out.println("count: " + count);
	//하나의 화면에 띄워줄 글 개수 10
	int pageSize = 10;
	
	//현재 보여질 페이지번호 가져오기
	String pageNum = request.getParameter("pageNum");
	
	//현재 보여질 페이지 번호가 없으면 1페이지 처리
	if(pageNum == null) {
		pageNum = "1";
	}
//	System.out.println("pageNum: " + pageNum);
	
	//현재 보여질 페이지 번호 "1"을 기본정수 1로 변환
	int currentPage = Integer.parseInt(pageNum);
//	System.out.println("currentPage: " + currentPage);
	
	//각 페이지마다 맨 위에 보여질 시작 글번호 구하기
	//(현재 보여질 페이지 번호 - 1) * 한페이지당 보여줄 글 개수
	int startRow = (currentPage - 1) * pageSize;
//	System.out.println("startRow: " + startRow);
	
	
	//날짜 포맷
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

	MemberDTO dto = new ProfessorDAO().selectMember(id);

%>

<c:set  var="contextPath"  value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 강의</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="../js/scripts.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
   		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script> 
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">    
  	<script> 
 				
 		$(function(){
 			var loggedInProfessor = '<%= session.getAttribute("id") %>';
 			var startRow = '<%=startRow%>';
 			var pageSize = '<%=pageSize%>';
			 
 			console.log('loginprof', loggedInProfessor);
 			//검색어를 입력하는 <input>을 가져와 클릭 이벤트가 발생했을 때 실행되게 선언
 			$("#searchText").on("keyup", function(){
 				
 				//listCourse.jsp 서버페이지로 요청할 값 얻기
 				//검색 기준값 얻기
 				var search = $("select[name=search]").val();
 				
 				//입력한 검색어 값 얻기
 				var searchText = $(this).val();
 				
 				//서버페이지(listCourse.jsp)로 AJAX비동기 방식으로 요청해서 응답 받기
 				$.ajax({
 					
 					//SearchServlet.java 서블릿 페이지로 검색 요청!
 					url : '<%=request.getContextPath()%>/searchCourse.do',
 					type : 'post',
 					data : {search:search, searchText:searchText, startRow:startRow, pageSize:pageSize},
 					dataType : 'json',
 					success : function(data){
 						
 						console.log(data);
 						
 						//서버로부터 받아온 데이터를 동적으로 표시
 						var $resultsTable = $('#results');
 						
 						//이전에 조회된 <tr>태그 요소들은 <tbody>요소 영역에서 삭제
 						$resultsTable.empty();
 						
 						if(data.length > 0){
 							
 							$.each(data, function(index, boardbean){
 								$resultsTable.append(
 										
 								"<tr align='center' style='border-bottom: 1px, solid, lightgrey;'>" + 
               	           			"<td width=5%>" + boardbean.ccode + "</td>" + 
               	           			"<td width=5%>" + boardbean.cname + "</td>" + 
               	           			"<td width=5%>" + boardbean.compdiv + "</td>" + 
               	           			"<td width=5%>" + boardbean.compyear + "학년" + "</td>" + 
               	           			"<td width=5%>" + boardbean.compsem + "학기" +"</td>" + 
               	           			"<td width=5%>" + boardbean.grade + "학점" +"</td>" + 
               	           			"<td width=10%>" + boardbean.day + " "+ boardbean.starttime + "교시 - " + boardbean.endtime + "교시</td>" +              	           			
               	           			"<td width=5%>" + boardbean.professor + "</td>"  + 
               	           			"<td width='5%'>" +
                                    (loggedInProfessor != null && "<%=dto.getName()%>" === boardbean.professor ?
                                    "<a href='modCourse.jsp?ccode=" + boardbean.ccode + "'>과목 수정</a>" :
                                    "-") +
                                    "</td>" +
                                    "<td width='5%'>" +
                                    (loggedInProfessor != null && "<%=dto.getName()%>" === boardbean.professor ?
                                    "<a href='delCourse.jsp?ccode=" + boardbean.ccode + "'>과목 삭제</a>" :
                                    "-") +
               	              		"</td>" +
 								"</tr>"							
 								);
							
 							});
 							
 						}else{
 							
 							$resultsTable.append("<tr><td colpsan='10' style='text-align:center;'>검색 결과가 없습니다.</td></tr>");
 						}											
 					}					 					
 				});								
 			}); 			
 		});

	 	//삭제할 과목 한번 더 확인하는 함수
	 	function delC(ccode){ 		

 			var result = confirm("해당 과목을 삭제하시겠습니까?");
 			
 			if (result == true) {
				
 				location.href = "delCourse.jsp?ccode=" + ccode;
			}			
 		}	 		
 	 	
 	</script>
 	
 		<style>     	   	  	
		  a {text-decoration-line: none;}			
    	</style>
 	
 	
    </head>
    <body class="sb-nav-fixed">    
        	<%
				//한글처리
				request.setCharacterEncoding("UTF-8");	
        	
        		String search = request.getParameter("search");
        		String searchText = request.getParameter("searchText");
        		
			%>		
			
			<jsp:useBean id="boardDAO" class="board_course.BoardDAO"/>			
					
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <jsp:include page="/inc/logo.jsp" />
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
	           		<%--사이드바--%>
	                <jsp:include page="/inc/menu.jsp" />
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">전체 강의</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">listCourse</li>
                        </ol>
                        <form action="listCourse.jsp" method="post">
                        	<select name="search">
                        		<option value="ccode">과목코드</option>
                        		<option value="cname">과목명</option>
                        		<option value="compdiv">이수구분</option>
                        		<option value="compyear">이수학년</option>
                        		<option value="compsem">이수학기</option>
                        		<option value="grade">학점</option>
                        		<option value="professor">담당교수</option>                       		                      		                   		
                        	</select>
                        	<input type="text" name="searchText" id="searchText"/>
                        	
                        	<%
							    String loggedInProfessor = (String) session.getAttribute("id");
							
							    list = boardDAO.getList(startRow, pageSize);
							
							    String professorName = "";
							
							    for (int i = 0; i < list.size(); i++) {
							    	
							        bean = (BoardBean) list.get(i);
							        
							        if (loggedInProfessor.equals(bean.getId())) {
							        	
							        	// professorName 값을 세션에 저장
							            professorName = bean.getProfessor();							            
							            session.setAttribute("professorName", professorName);
							            
							            break; // 교수명을 찾았으므로 반복문 종료
							        }
							    }
							%>

                        	<%-- 교수님이 과목을 직접 추가하는 페이지로 이동하는 링크 --%>
                        	<a href="addCourse.jsp">과목 추가</a>
                        </form>
                        <div class="row">
                        	<p class="mb-0">
                        		
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" id="resultsTable" class="table table-striped"> 
                   	           		<thead>
	                   	           		<tr bgcolor="lightgrey" align="center">
	                   	           			<th width=5%>과목코드</th>
	                   	           			<th width=5%>과목명</th>
	                   	           			<th width=5%>이수구분</th>
	                   	           			<th width=5%>이수학년</th>
	                   	           			<th width=5%>이수학기</th>
	                   	           			<th width=5%>학점</th>
	                   	           			<th width=10%>강의시간</th>
	                   	           			<th width=5%>담당교수</th>   
	                   	           			<th width=5%>수정</th> 
	                   	           			<th width=5%>삭제</th>                	           			
	                   	           		</tr>
                   	           		</thead>
                   	           		
                  	           		<%-- 과목 리스트 --%>
                  	           		<tbody id="results">
                  	           	
                  	           	<%
                  	           		for(int i=0; i < list.size(); i++){
                  	           			
                  	           			bean = (BoardBean)list.get(i);
                  	           			              	               
                  	           	%>
                  	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
                  	           			<td><%= bean.getCcode() %></td>
							            <td><%= bean.getCname() %></td>
							            <td><%= bean.getCompdiv() %></td>
							            <td><%= bean.getCompyear() %>학년</td>
							            <td><%= bean.getCompsem() %>학기</td>
							            <td><%= bean.getGrade() %>학점</td>
							            <td><%= bean.getDay() %> <%= bean.getStarttime() %>교시 - <%= bean.getEndtime() %>교시</td>
							            <td><%= bean.getProfessor() %></td>							            
									<!--   // 교수 정보가 일치하면 수정 및 삭제 링크 생성 -->
							     <% 
									System.out.println(loggedInProfessor + " : " + bean.getId());

							     if(loggedInProfessor != null && loggedInProfessor.equals(bean.getId()))  {  
							     								     	
							     %>
						            <td><a href="modCourse.jsp?ccode=<%= bean.getCcode() %>">과목 수정</a></td>
						            <td><a href="javascript:delC('<%=bean.getCcode()%>')">과목 삭제</a></td>	
         	           			<% }else{
         	           				//System.out.println(loggedInProfessor + " : " + bean.getId());
         	           			%>	
		       	           			<td>-</td>
							        <td>-</td>	
							    <% } %>
         	           				</tr>                 	           		
                  	           	<% } %>		
                  	           		</tbody>
     	           										           		                 	           		
                   	           </table>
                   	           
                   	           <br>
	                   	           	<div class="datatable-bottom">

									    <div class="datatable-info">
									    	전체 강의: <%=count%>개
									    </div>
									    <nav>
											<ul class="pagination">
<%
									    	//전체 페이지 수 구하기
											//전체 페이지 수 = 전체 글 / 한페이지에 보여줄 글 수 + (전체 글 수를 한페이지에 보여줄 글수로 나눈 나머지 값)
											int pageCount = count / pageSize + (count%pageSize == 0 ? 0:1);
											//한 화면에 보여줄 페이지 수 설정
											int pageBlock = 5;
											
											//시작페이지 번호 구하기
											//( 현재 보여질 페이지 번호 / 한 블럭에 보여줄 페이지 수 ) - ( 현재 보여질 페이지 번호 % 한 화면에 보여줄 페이지수 == 0 ? 1:0 )
											// * 한 블럭에 보여줄 페이지 수 + 1
											int startPage = ( (currentPage / pageBlock) - (currentPage % pageBlock == 0 ? 1 : 0) ) * pageBlock + 1;
											
											//끝페이지 번호 구하기
											int endPage = startPage + pageBlock - 1;
											//끝 페이지 번호가 전체 페이지수보다 클 때
											if(endPage > pageCount) {
												endPage = pageCount;
											}
											/* 
											System.out.println("startPage: " + startPage);
											System.out.println("pageBlock: " + pageBlock);
											System.out.println("pageCount: " + pageCount);
											System.out.println("endPage: " + endPage);
											 */
											//[이전] 시작 페이지 번호가 한 화면에 보여줄 페이지수보다 클 때
											if(startPage > pageBlock) {
%>
												<li class="page-item">
									    			<a href="listCourse.jsp?pageNum=<%=startPage - pageBlock%>" class="page-link">‹</a>
									    		</li>
<%
											}
											
											for(int i = startPage; i <= endPage; i++) {
												if(i == currentPage) {
%>											
									    			<li class="page-item active"><a href="listCourse.jsp?pageNum=<%=currentPage%>" class="page-link"><%=currentPage %></a></li>
<%
												} else {
%>	
									    			<li class="page-item"><a href="listCourse.jsp?pageNum=<%=i%>" class="page-link"><%=i %></a></li>
<%	
												}
											
											}
											//[다음] 끝페이지 번호가 전체 페이지수 보다 작을 때
											if(endPage < pageCount) {
%>													
												<li class="page-item">
									    			<a href="listCourse.jsp?pageNum=<%=startPage + pageBlock%>" class="page-link">›</a>
									    		</li>
<%													
											}
											
%>
									    	</ul>
										</nav>
									</div>
                   	           
                            </p>
                            
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2023</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>

<%@page import="board_course.BoardPage"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
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
//------------------------------------------------------------------	
	// 사용자가 입력한 검색 조건을 Map에 저장
	Map<String, Object> param = new HashMap<String, Object>();
	String search = request.getParameter("search");
	String searchText = request.getParameter("searchText");
	System.out.println(search);
	System.out.println(searchText);
	
	//검색어를 입력 했다면?
	if (searchText != null) {
		// 사용자가 입력한 검색 조건을 Map에 저장
	    param.put("search", search);
	    param.put("searchText", searchText);
	}
//-------------------------------------------------------------------	
	
	//전체 글 개수
	int totalCount = dao.getBoardCount(param); 
	//System.out.println("count: " + count);

	//하나의 화면에 띄워줄 글 개수 10
	int pageSize = 10;
	
	//한 화면(블록)에 출력할 게시물의 개수
	int blockPage = 5;
	
	/*** 페이지 처리 start ***/
	//단계3. 전체 페이지 수를 계산 합니다.
	//계산식 : Math.ceil(전체 게시물 수 / 한페이지에 출력할 게시물의 개수)
	//	    Math.ceil(totalCount / pageSize)
	//계산 예:
	//- 게시물 수가 총 105개 이면?
	//  전체 페이지 수는?   Math.ceil(105/10)   ->  Math.ceil(10.5)  =   전체 페이지 수는  11 이다.
	int totalPage = (int)Math.ceil((double)totalCount / pageSize); // 전체 페이지 수
	
	// 현재 보여지는(현재 클릭한) 페이지 번호를 구합니다.
	// 처음에는 무조건 1로 설정 해 두고, 클라이언트가 특정 페이지번호를 클릭했을때 요청받는 페이지 번호를 사용합니다.
	int pageNum = 1;  // 기본값
	String pageTemp = request.getParameter("pageNum");
	if (pageTemp != null && !pageTemp.equals(""))
	    pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 수정
	    
	//System.out.println("pageNum: " + pageNum);
	
	  //단계2. 각 페이지에서 조회해서 출력할 게시물의 범위를 계산합니다.
	  //계산식 :
//	  	 범위의 시작값 : (현재페이지-1)*한페이지에 출력할 게시물의 개수 + 1
//	         범위의 종료값 : (현재페이지 * 한페이지에 출력할 게시물의 개수)
	  //계산예
//	  		현재 선택한 페이지번호가 1페이지일때
//	  					범위의 시작값 (1-1)*10+1 = 1 
//	  							  10-10 + 1 = 1
//	  					범위의 종료값 (1*10) = 10
//	  		현재 선택한 페이지 번호가 2페이지일때
//	  					범위의 시작값 (2-1)*10+1 = 1
//	                               20-10 + 1 = 11
//	  					범위의 종료값 (1*10) = 10
	      
    // 목록에 출력할 게시물 범위 계산
    int start = (pageNum - 1) * pageSize + 1;  // 첫 게시물 번호
    int end = pageNum * pageSize; // 마지막 게시물 번호
    param.put("start", start);
    param.put("end", end);
    /*** 페이지 처리 end ***/
	
	//사용자가 입력한 검색 조건 (searchField,searchWord) 그리고  조회 할 게시물 목록 범위 첫 게시물 번호(시작값),마지막 게시물 번호(종료값)이 
	//저장된 HashMap을 DAO의 매개변수로 전달해 조회 해 옵니다.
	List<BoardBean> vectorBoardLists = dao.getList(param);   // 게시물 목록 받기	
	
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
                        <form method="get">
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
                        	<input type="submit" value="검색"/>                       	
                        	<%
							    String loggedInProfessor = (String) session.getAttribute("id");						
							
							    String professorName = "";
							
								for(BoardBean bean : vectorBoardLists ){							    	
							        
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
	                   	           			<th width=5%>번호</th>
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
                  	           		if(vectorBoardLists.isEmpty()) { //등록된 게시물이 없을 때                 	           			
	                  	        %>
			                  	    <tr>
			                  	       <td colspan="10" align="center">
			                  	        	검색 결과가 없습니다
			                  	       </td>
			                  	    </tr>
				                <%                	           			
                  	           		}else{
                  	           	    // 게시물이 있을 때
                  	           	    int virtualNum = 0;  // 화면상에서의 게시물 번호
                  	           	    int countNum = 0;
                  	           		for(BoardBean bean : vectorBoardLists ){
              	           			
	                  	           	   // virtualNumber = totalCount--;  // 전체 게시물 수에서 시작해 1씩 감소
	                  	           	   virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);	                  	           	   
	                  	        %>	                  	           	
									<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
										<td><%= virtualNum %></td>
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
                  	           	 <% } }%>	                	           	 
                  	           	 </tbody>                            		                 	           		
                   	           </table>                   	           
                  	           <br>
                   	           	<div class="datatable-bottom">
								    <div class="datatable-info">
								    	전체 강의(조회된 강의): <%=totalCount%>개
								    </div>
								    <nav>
										<ul class="pagination">																									    	   
								            <!--페이징 처리   	전체 게시물의 개수,
								            			 	한페이지에 출력할 게시물의 개수,
								            				한 화면(블록)에 출력할 페이지 번호의 개수,
								            			 	현재 보여지는(현재 클릭한) 페이지 번호,
								            			 	실행된 목록 파일명  -->								           
									      <%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %>  								           									  	
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

<%@page import="courseList.CoursePlanDAO"%>
<%@page import="courseList.CoursePlanBean"%>
<%@page import="courseList.MoreInfoBean"%>
<%@page import="courseList.MoreInfoDAO"%>
<%@page import="courseList.CourseDAO"%>
<%@page import="courseList.CourseBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<c:set  var="contextPath"  value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 전체강의</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
   		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script> 
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  	<script> 
 				
 		$(function(){
 			
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
 					url : '<%=request.getContextPath()%>/search.do',
 					type : 'post',
 					data : {search:search, searchText:searchText},
 					dataType : 'json',
 					success : function(data){
 						
 						console.log(data);
 						
 						//서버로부터 받아온 데이터를 동적으로 표시
 						var $resultsTable = $('#results');
 						
 						//이전에 조회된 <tr>태그 요소들은 <tbody>요소 영역에서 삭제
 						$resultsTable.empty();
 						
 						if(data.length > 0){
 							
 							$.each(data, function(index, coursebean){
 								
 								$resultsTable.append(
 										
 								"<tr align='center' style='border-bottom: 1px, solid, lightgrey;'>" + 
 									"<td width=5%>" + "</td>" +
 									"<td width=5%>" + coursebean.grade + "학점" + "</td>" +
 									"<td width=5%>" + coursebean.compyear + "학년" + "</td>" + 
               	           			"<td width=5%>" + coursebean.compsem + "학기" + "</td>" + 
               	           			"<td width=5%><a href='moreInfo.jsp' id='moreInfo'>" + coursebean.cname + "</td>" + 
               	           			"<td width=5%>" + coursebean.professor + "</td>"  + 
               	           			"<td width=5%>" + coursebean.compdiv + "</td>" +         			                	           			
 								"</tr>"							
 								);
								
 							});
 							
 						}else{
 							
 							$resultsTable.append("<tr><td colpsan='8' style='text-align:center;'>검색 결과가 없습니다.</td></tr>")
 						}											
 					}					 					
 				});								
 			}); 			
 		});

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
			
			<jsp:useBean id="courseDAO" class="courseList.CourseDAO"/>		
			<jsp:useBean id="coursePlanDAO" class="courseList.CoursePlanDAO"/>	
					
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">OO대학교</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <jsp:include page="/inc/member.jsp" />
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                	<jsp:include page="/inc/menu.jsp" />
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">강의리스트</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">courseList_student</li>
                        </ol>
                        <form action="courseList.jsp" method="post">
                        	<select name="search">
                        		<option value="grade">학점</option>
                        		<option value="compyear">이수학년</option>
                        		<option value="compsem">이수학기</option>                       		
                        		<option value="cname">과목명</option>
                        		<option value="professor">담당교수</option> 
                        		<option value="compdiv">이수구분</option>            		                      		                      		                   		
                        	</select>
                        	<input type="text" name="searchText" id="searchText"/>                    
                        </form>
                        <div class="row">
                        	<p class="mb-0">    		
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" id="resultsTable" class="table table-striped">                  	      
                   	           		<thead>
	                   	           		<tr bgcolor="lightgrey" align="center">
	                   	           			<td width=5%></td> 
	                   	           			<th width=4%>학점</th>
	                   	           			<th width=4%>이수학년</th>
	                   	           			<th width=4%>이수학기</th>
	                   	           			<th width=5%>과목명</th>
	                   	           			<th width=5%>담당교수</th>	                   	           			
	                   	           			<th width=5%>이수구분</th>          	           			                   	           			               	           			
	                   	           		</tr>
                   	           		</thead>
                   	           		
                  	           		<%-- 과목 리스트 --%>
                  	           		<tbody id="results">
                  	           <%	
                  	           		List<CourseBean> list = courseDAO.getList(); 
        	           			
                  	           		for (int i = 0; i < list.size(); i++) {
                  	           			
                  	                CourseBean bean = list.get(i);
                  	            
              	           			
                  	           	%>
                  	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
                  	           			<td><a href='#'>강의 계획서</a></td>
                  	           			<td><%= bean.getGrade() %>학점</td>
                  	           			<td><%= bean.getCompyear() %>학년</td>
                  	           			<td><%= bean.getCompsem() %>학기</td>                 	           			
										<td><a href='moreInfo_student.jsp?cname=<%= bean.getCname()%>' id='moreInfo'><%= bean.getCname() %></a></td>
							            <td><%= bean.getProfessor() %></td>
							            <td><%= bean.getCompdiv() %></td>   							            
         	           				</tr>
                  	           	
                  	           	<%
                  	           	
                  	           		}
                  	           		
                  	            %>		
                  	           		</tbody>
     	           										           		                 	           		
                   	           </table>
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

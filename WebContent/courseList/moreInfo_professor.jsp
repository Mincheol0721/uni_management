<%@page import="board_course.BoardBean"%>
<%@page import="courseList.CoursePlanBean"%>
<%@page import="courseList.CoursePlanDAO"%>
<%@page import="courseList.MoreInfoBean"%>
<%@page import="courseList.MoreInfoDAO"%>
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
        <title>OO대학교 학사관리 시스템 - 세부 강의 리스트</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
   		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script> 
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">    
    
	    <script type="text/javascript">
	    
	 	//삭제할 강의 한번 더 확인하는 함수
	 	function delC(cname,week){ 		

 			var result = confirm("해당 과목을 삭제하시겠습니까?");
 			
 			if (result == true) {
				
 				location.href = "delMoreInfo.jsp?cname=" + cname + "&week=" + week;
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
			
			<jsp:useBean id="moreInfoDAO" class="courseList.MoreInfoDAO"/>			
					
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
                        <h1 class="mt-4">세부 강의 페이지</h1>                        
                        <ol class="breadcrumb mb-4">                     	   
                            <li class="breadcrumb-item active">moreInfo_professor</li>                                                                  
                        </ol>                                          
                        <div class="row">
                        	<p class="mb-0">                        	
	                        <div align="right">
	                        
	                        <%-- 교수님이 세부정보를 직접 추가하는 페이지로 이동하는 링크 --%>
	                        <div align="left">
	                        	<h5><a href="addMoreInfo.jsp?cname=<%= request.getParameter("cname") %>">세부정보 추가</a></h5>
                   		    </div>                		
	                        </div>                      	           		
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="table table-striped"> 
                   	           		<thead>
	                   	           		<tr bgcolor="lightgrey" align="center">
	                   	           			<th width=3%>주차</th>
	                   	           			<th width=3%>차시</th>                   	           			
	                   	           			<th width=5%>강의주제</th>
	                   	           			<th width=5%>강의방식</th>	                   	           			
	                   	           			<th width=5%>강의 시간</th>
	                   	           			<th width=5%>과제</th>	
	                   	           			<th width=3%>수정하기</th>
	                   	           			<th width=3%>삭제하기</th>	                   	           			           			                     	           			               	           			
	                   	           		</tr>
                   	           		</thead> 
  		
                  	           		<tbody>
                  	           <%	
                  	         		String loggedInProfessor = (String)session.getAttribute("id");
                  	           		
	                        		MoreInfoDAO dao = new MoreInfoDAO();
	                   	           
	                        		String cname = request.getParameter("cname");         		
	
	                        	    System.out.println("cname 파라미터 값: " + cname);       		     		
                  	           		
                   	           		List<MoreInfoBean> list = dao.getmoreList(cname);
                  	           	
                   	           		for(MoreInfoBean bean : list){ 
         	           	
                   	           			
                   	           	%> 
                  	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">                	           			
                  	           			<td><%= bean.getWeek() %>주차</td>
							            <td><%= bean.getSession() %>차시</td>
							            <td><%= bean.getTopic() %></td>
							            <td><%= bean.getWay() %></td>
							            <td><%= bean.getDay() %>  <%= bean.getStarttime() %>교시 - <%= bean.getEndtime() %>교시</td>

							    	<!--   // 교수 정보가 일치하면 수정 및 삭제 링크 생성 -->
							     <% if(loggedInProfessor != null && loggedInProfessor.equals(bean.getId()))  {  
							     	System.out.println(loggedInProfessor + " : " + bean.getId());							     	
							     %>         
							     		<td>
											<%= bean.getHomework() %>
										    <form action="homework_professor.jsp?cname=<%=cname %>" method="post">
										        <input type="hidden" name="homework" value="<%= bean.getHomework() %>">
										        <input type="hidden" name="week" value="<%= bean.getWeek() %>">
										        <input type="hidden" name="session" value="<%= bean.getSession() %>">
										        <button type="submit" class="homework_p">과제 설정</button>
										    </form>
										</td>
							            <td><a href="modMoreInfo.jsp?cname=<%= bean.getCname() %>&week=<%= bean.getWeek()%>">수정</a></td>	
										<td><a href="javascript:delC('<%= bean.getCname()%>','<%=bean.getWeek()%>')">삭제</a></td>   	           				
                  	          	<% }else{
         	           				System.out.println(loggedInProfessor + " : " + bean.getId());
         	           			%>	
		       	           			<td>-</td> 
							        <td>-</td>	
							        <td>-</td>								        
							    <% } %>
         	           				</tr>                 	           		
                  	           	<% } %>		
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

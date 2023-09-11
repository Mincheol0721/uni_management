<%@page import="java.util.ArrayList"%>
<%@page import="board_course.BoardBean"%>
<%@page import="board_course.BoardDAO"%>
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
        <title>OO대학교 학사관리 시스템 - 개설과목</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
   		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
 
    </head>
    <body class="sb-nav-fixed">    
        	<%
				//한글처리
				request.setCharacterEncoding("UTF-8");			
			%>					
			
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
                    <div class="sb-sidenav-menu">
                        <jsp:include page="/inc/menu.jsp" />
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>                        
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">개설과목</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">course</li>
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
                        	<input type="submit" value="검색"/>
                        	
                        	<%-- 교수님이 과목을 직접 추가하는 페이지로 이동하는 링크 --%>
                        	<a href="addCourse.jsp">과목 추가</a>
                        </form>
                        <div class="row">
                        	<p class="mb-0">
                        		
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" id="resultsTable" class="lec"> 
                   	           		<tr bgcolor="lightgrey" align="center">
                   	           			<td width=5%>과목코드</td>
                   	           			<td width=5%>과목명</td>
                   	           			<td width=5%>이수구분</td>
                   	           			<td width=5%>이수학년</td>
                   	           			<td width=5%>이수학기</td>
                   	           			<td width=5%>학점</td>
                   	           			<td width=5%>담당교수</td>                  	           			
                   	           		</tr>
                   	           		
                  	           		<%-- 개설 과목 목록 조회--%> 
                  	           		<%
                  	           			ArrayList<BoardBean> courseList = new ArrayList<BoardBean>();
                  	           			BoardDAO dao = new BoardDAO();
                  	           			courseList = dao.getList();
               
                  	           			//가져온 과목 목록을 반복해서 출력
                  	           			for(BoardBean course : courseList) {
                  	           		%>                                   	           		                	    			
                   	       			<tr align="center" style="border-bottom: 1px, solid, lightgrey;">	
							            <td><%= course.getCcode() %></td>
							            <td><%= course.getCname() %></td>
							            <td><%= course.getCompdiv() %></td>
							            <td><%= course.getCompyear() %></td>
							            <td><%= course.getCompsem() %></td>
							            <td><%= course.getGrade() %></td>
							            <td><%= course.getProfessor() %></td>												
									</tr>									
									<%
                  	           			}
									%>									
								<tbody id="results"></tbody>	           		                 	           		
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

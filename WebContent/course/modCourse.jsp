<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="board_course.BoardBean"%>
<%@page import="board_course.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<% request.setCharacterEncoding("UTF-8"); %>

<c:set var="id" value="${sessionScope.id}" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 과목추가</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>        
    </head>
    	
    	<%
			//한글처리
			request.setCharacterEncoding("UTF-8");
             
	        BoardDAO dao = new BoardDAO();
		
			String ccode = request.getParameter("ccode");
			
			BoardBean bean = dao.getCourseInfo(Integer.parseInt(ccode));
			
			System.out.print("수정할 과목코드 : " + ccode);
	
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
                	<form action="modCoursePro.jsp" method="POST"> 
                	<input type="hidden" id="ccode" name="ccode" value="<%=ccode%>"/>      	
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">과목수정</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">modCourse</li>
                        </ol>
                        <div class="row">
                        	<p class="mb-0">
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec" id="t"> 
                   	           		<tr bgcolor="lightgrey" align="center">
                   	           			<td width=5%>과목명</td>
                   	           			<td width=5%>이수구분</td>
                   	           			<td width=5%>이수학년</td>
                   	           			<td width=5%>이수학기</td>
                   	           			<td width=5%>학점</td>
                   	           			<td width=5%>담당교수</td>
                   	           			<td width=2%></td>                  	           		                 	           			
                   	           		</tr>
                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">             	  
                   	           			<td width=5%><input type="text" name="cname" value="<%=bean.getCname()%>"/></td> 
                   	           			<td>   
									        <select name="compdiv">
									            <option value="required" <%if(bean.getCompdiv().equals("required")){ %>selected<% }%>>전공필수</option>
									            <option value="optional" <%if(bean.getCompdiv().equals("optional")){ %>selected<% }%>>전공선택</option>
									            <option value="subject" <%if(bean.getCompdiv().equals("subject")){ %>selected<% }%>>교양</option>                   	           					
									        </select>
									    </td>       	           			
									    <td width="5%">
									        <select name="compyear">
									            <option value="1" <%if(bean.getCompyear() == 1) { %>selected<% }%>>1학년</option>
									            <option value="2" <%if(bean.getCompyear() == 2) { %>selected<% }%>>2학년</option>
									            <option value="3" <%if(bean.getCompyear() == 3) { %>selected<% }%>>3학년</option> 
									            <option value="4" <%if(bean.getCompyear() == 4) { %>selected<% }%>>4학년</option>               	           					
									        </select>
									    </td>
									    <td width="5%">
									        <select name="compsem">
									            <option value="1" <%if(bean.getCompsem() == 1) { %>selected<% }%>>1학기</option>
									            <option value="2" <%if(bean.getCompsem() == 2) { %>selected<% }%>>2학기</option>                  	           					
									        </select>
									    </td>
									    <td width="5%">
									        <select name="grade">
									            <option value="1" <%if(bean.getGrade() == 1) { %>selected<% }%>>1학점</option>
									            <option value="2" <%if(bean.getGrade() == 2) { %>selected<% }%>>2학점</option>
									            <option value="3" <%if(bean.getGrade() == 3) { %>selected<% }%>>3학점</option>                   	           					
									        </select>
									    </td>
                   	           			<td width=5% style="text-align:center;"><input type="text" name="professor" value="${id}"/></td>
                   	           			<td width=5%><input type="submit" value="수정" class="btn4"></td>             	           			
                   	           		</tr>
                   	           </table>
                            </p>
                        </div>
                    </div>
                    </form>
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

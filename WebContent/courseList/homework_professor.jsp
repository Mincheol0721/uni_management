<%@page import="homework.HomeworkProfessorDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="courseList.MoreInfoBean"%>
<%@page import="courseList.MoreInfoDAO"%>
<%@page import="homework.HomeWorkBoardDTO"%>
<%@page import="homework.HomeWorkBoardDAO"%>
<%@page import="homework.HomeWorkDTO"%>
<%@page import="homework.HomeWorkDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="lectureBoard.LectureVO"%>
<%@page import="java.util.List"%>
<%@page import="lectureBoard.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<% request.setCharacterEncoding("UTF-8"); %>
<%
	//세션 id값 가져오기
	String id = (String)session.getAttribute("id");

	String cname = request.getParameter("cname");
	
	String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 세부강의</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    
	    <%
   
	    	HomeworkProfessorDAO dao = new HomeworkProfessorDAO();
	    
			int week = Integer.parseInt(request.getParameter("week"));
			int sess = Integer.parseInt(request.getParameter("session"));
			
			System.out.println(week + " & " + sess);
 	
	    	HomeWorkBoardDTO dto = dao.getHWList(cname, week, sess);
	    	
	    	System.out.println("cname: " + cname);
	    	System.out.println("tasktype: " + dto.getTasktype());
	    	System.out.println("tasktitle: " + dto.getTasktitle());
	    	System.out.println("taskmethod: " + dto.getTaskmethod());
	    	System.out.println("period: " + dto.getPeriod());
	    	
	   	%>
	<body class="sb-nav-fixed">    					
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
                    <form action="homeworkPro.jsp?cname=<%=cname %>" method="POST"> 
                	<input type="hidden" id="cname" name="cname" value="<%=cname%>"/>  
                    	<div class="container-fluid px-4">
                        <h1 class="mt-4">과제 설정</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">homework_professor</li>
                        </ol>
							<div class="container-fluid">
								<div class="row">
									<div class="col-md-2">
										과목명
									</div>
									<div class="col-md-10">
										<input type="text" name="cname" width="100%" value="<%=cname%>" readonly="readonly">
									</div>
									<div class="col-md-2">
										과제유형
									</div>
									<div class="col-md-10">
										<select name="tasktype">								
											<option value="" <%if(dto.getTasktype().equals("")){ %>selected<% }%>>---선택---</option>
											<option value="개인과제" <%if(dto.getTasktype().equals("개인과제")){ %>selected<% }%>>개인과제</option>
											<option value="팀프로젝트" <%if(dto.getTasktype().equals("팀프로젝트")){ %>selected<% }%>>팀프로젝트</option>
										</select>
									</div>
									<div class="col-md-2">
										과제명
									</div>
									<div class="col-md-10">
										<input type="text" name="tasktitle" width="100%" value="<%=dto.getTasktitle()%>">
									</div>
									<div class="col-md-2">
										제출방법
									</div>
									<div class="col-md-10">
										<input type="radio" name="taskmethod" value="온라인" <%if(dto.getTaskmethod().equals("온라인")){ %>checked<% }%> > 온라인 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="taskmethod" value="오프라인"<%if(dto.getTaskmethod().equals("오프라인")){ %>checked<% }%>> 오프라인
									</div>
									<div class="col-md-2">
										제출기간
									</div>
									<div class="col-md-10">
									<% String startDate = dto.getPeriod().substring(0, 10);
										System.out.println("startDate: " + startDate);
										String endDate = dto.getPeriod().substring(11);
										System.out.println("endDate: " + endDate);
									%>
										<input type="date" name="period" min="<%=today%>" value="<%=startDate%>" width="100%">
										 ~ 
										<input type="date" name="period" min="<%=today%>" value="<%=endDate %>" width="100%"> 
									</div>									
									<div class="col-md-10">
										<button type="submit" class="save">저장</button>			
									</div>
								</div>
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

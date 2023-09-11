<%@page import="member.EmployeeDAO"%>
<%@page import="member.StudentDAO"%>
<%@page import="member.ProfessorDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="job" value="${sessionScope.job}" />

<%
	String job = (String)session.getAttribute("job");
	String id = (String)session.getAttribute("id");

	MemberDTO dto = new MemberDTO();
	ProfessorDAO pdao = new ProfessorDAO();
	StudentDAO sdao = new StudentDAO();
	EmployeeDAO edao = new EmployeeDAO();
	
	System.out.println("직업: " + job);
	System.out.println("id: " + id);
	
	if(job.equals("교수")){
		dto = pdao.selectMember(id);
	} else if(job.equals("학생")){
		dto = sdao.selectMember(id);
	} else if(job.equals("교직원")){
		dto = edao.selectMember(id);
	}
	
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 회원정보조회</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
        <style type="text/css">
        	ul {
        		list-style: none;
        	}
        	#myPage {
        		margin-left: 90%;
        		word-spacing: 1em;
        	}
        </style>
    </head>
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
                        <h1 class="mt-4">회원정보 조회</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">my-info</li>
                        </ol>
                        <div class="row">
                        	<p class="mb-0">
                        	<ul id="memList">
                        		<li>아이디: <b><%=dto.getId() %></b></li>
                        		<li>이름: <b><%=dto.getName()%></b></li>
                        		<li>주민등록번호: <b><%=dto.getSsn().substring(0, 8) %> ******</b></li>
                        		<li>연락처: <b><%=dto.getTel() %></b></li>
                        		<li>이메일: <b><%=dto.getEmail() %></b></li>
                        		<li>주소: <b><%=dto.getAddr() %></b></li>
                        		<li>학부: <b><%=dto.getFaculty() %></b></li>
                        		<li>전공: <b><%=dto.getDept() %></b></li>
                        	</ul>
                        	<div id="myPage">
                        		<a href="#"><small><input type="button" value="회원정보수정"></small></a>
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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 일정</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="../js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="../js/datatables-simple-demo.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
	           		<%--사이드바--%>
	                <jsp:include page="/inc/menu.jsp" />
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                     <div class="container-fluid px-4">
                        <h1 class="mt-4">공지사항</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Notice</li>
                        </ol>
                        <div class="card mb-4">
                             <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                 <h4 class="m-0 font-weight-bold text-primary">공지</h4>
                             </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                    <table id="datatablesSimple">
	                                    <thead>
		                   	           		<tr bgcolor="lightgrey" align="center">
		                   	           			<td width=5%>분류</td>
		                   	           			<td width=15%>제목</td>
		                   	           			<td width=5%>일정</td>
		                   	           		</tr>
	                                    </thead>
	                                    <tbody>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>수강</td>
		                   	           			<td width=15%>수강신청관련 공지</td>
		                   	           			<td width=5%>2023-05-08</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td width=5%>행사</td>
		                   	           			<td width=15%>스승의날 행사 관련 공지</td>
		                   	           			<td width=5%>2023-05-12</td>
		                   	           		</tr>
		                   	           	</tbody>
	                   	           	</table>
	                   	           	<br>
		                   	           	<div class="datatable-bottom">
										    <div class="datatable-info">현재 게시글 / 전체 게시글</div>
										    <nav class="datatable-pagination">
										    	<ul class="datatable-pagination-list">
										    		<li class="datatable-pagination-list-item datatable-hidden datatable-disabled">
										    			<a data-page="1" class="datatable-pagination-list-item-link">‹</a>
										    		</li>
										    		<li class="datatable-pagination-list-item datatable-active">
										    			<a data-page="1" class="datatable-pagination-list-item-link">1</a>
										    		</li>
										    		<li class="datatable-pagination-list-item">
										    			<a data-page="2" class="datatable-pagination-list-item-link">2</a>
										    		</li>
										    		<li class="datatable-pagination-list-item">
										    			<a data-page="3" class="datatable-pagination-list-item-link">3</a>
										    		</li>
										    		<li class="datatable-pagination-list-item">
										    			<a data-page="4" class="datatable-pagination-list-item-link">4</a>
										    		</li>
										    		<li class="datatable-pagination-list-item">
										    			<a data-page="5" class="datatable-pagination-list-item-link">5</a>
										    		</li>
										    		<li class="datatable-pagination-list-item">
										    			<a data-page="6" class="datatable-pagination-list-item-link">6</a>
										    		</li>
										    		<li class="datatable-pagination-list-item">
										    			<a data-page="2" class="datatable-pagination-list-item-link">›</a>
										    		</li>
										    	</ul>
										    </nav>
										</div>
                                    </div>
                                </div>
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
    </body>
</html>

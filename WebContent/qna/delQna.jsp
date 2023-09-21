<%@page import="member.EmployeeDAO"%>
<%@page import="member.StudentDAO"%>
<%@page import="member.ProfessorDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%!
	String job;
	String id;
	
	MemberDTO dto;
%>

<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%
	job = (String)session.getAttribute("job");
	id = (String)session.getAttribute("id");
	
	int no = Integer.parseInt( request.getParameter("no") );
	
	//System.out.println("delQna.jsp no: " + no);
	
	dto = new MemberDTO();
	
	EmployeeDAO dao = new EmployeeDAO();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<meta name="description" content="" />
		<meta name="author" content="" />
		<title>OO대학교 학사관리 시스템</title>
		<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
		<link href="../css/styles.css" rel="stylesheet" />
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
		<script src="../js/scripts.js"></script>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
		<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style type="text/css">
        	.info_title {
        		font-size: 12px;
        		font-weight: 400;
        		align-items: center;
        	}
        	.info {
        		font-size: 16px;
        		font-weight: 600;
        		align-items: center;
        	}
        	hr {
        		width: 100%;
        		align-items: center;
        		color: grey;
        	}
        	#btn {
        		margin-left: 95%;
        	}
        	@media (max-width: 1200px) {
        	#btn {
        		margin-left: 80%;
        	}
        	}
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <jsp:include page="../inc/logo.jsp" />
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
					<input type="hidden" value="<%=no%>" name="no">
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">질의응답</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">QnA</li>
                        </ol>
                        <div class="col-xl-12 col-lg-7">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h4 class="m-0 font-weight-bold text-primary">비밀번호 확인</h4>
                                </div>
                                <div class="card-body">
                                    <div class="chart-area"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                    	<div class="container-fluid">
										<div class="row">
										<form action="delQnaPro.jsp?no=<%=no %>" method="post">
											<div class="col-md-12">
												<div class="row">
<%
												if(id != null) {
%>
													<div class="col-md-2">
														<span class="info_title">비밀번호 입력</span>
													</div>
													<div class="col-md-10">
														<input type="password" name="pwd" style="width: 30%">
													</div>
													<br><br><hr>
		                                    		<small><input type="submit" id="btn" value="제출"></small>
<%													
												} else {
%>	
													<script type="text/javascript">
														alert('로그인이 필요한 페이지입니다. \r\n로그인 후 다시 이용해주세요.');
														location.href = '<%=request.getContextPath()%>/member/login.jsp';
													</script>
<%	
												}
%>
											</div>
										</div>
										</form>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>

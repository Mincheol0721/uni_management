<%@page import="cPlan.CplanDTO"%>
<%@page import="cPlan.CplanDAO"%>

<%@page import="cHistory.CHistoryDAO"%>
<%@page import="cHistory.CHistoryVO"%>
<%@page import="course.CourseVO"%>
<%@page import="java.util.List"%>
<%@page import="course.CourseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%-- <jsp:useBean id="course" class="course.CourseVO"></jsp:useBean> --%>
<%-- <jsp:getProperty property="" name="course"/> --%>



<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>OO대학교 학사관리 시스템 - 수강신청</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="../css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>



</head>
<body class="sb-nav-fixed">

	<%
		//한글처리	
		request.setCharacterEncoding("UTF-8");
		
		String cnam = request.getParameter("cname");
		// CplanDAO 객체 생성
		CplanDAO cPlDAO = new CplanDAO();
		
		
		
		CplanDTO plan = cPlDAO.selectBoard(cnam);
		
		int count = cPlDAO.getCount(cnam);
	%>

	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<!-- Navbar Brand-->
		<a class="navbar-brand ps-3" href="index.html">OO대학교</a>
		<!-- Sidebar Toggle-->
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
			id="sidebarToggle" href="#!">
			<i class="fas fa-bars"></i>
		</button>
		<!-- Navbar Search-->
		<form
			class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
			<div class="input-group">
				<input class="form-control" type="text" placeholder="Search for..."
					aria-label="Search for..." aria-describedby="btnNavbarSearch" />
				<button class="btn btn-primary" id="btnNavbarSearch" type="button">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</form>
		<!-- Navbar-->
		<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
				role="button" data-bs-toggle="dropdown" aria-expanded="false"><i
					class="fas fa-user fa-fw"></i></a> <jsp:include page="/inc/member.jsp" />
			</li>
		</ul>
	</nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
				<jsp:include page="/inc/cPlanMenu.jsp" />
			</nav>
		</div>
		<div id="layoutSidenav_content">
			<main>
			<div class="container-fluid px-4">
				<h1 class="mt-4">강의계획서</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active">lecture</li>
				</ol>


				<div class="row">

					<p class="mb-0">
					

					
						<%
// 							out.print(cnam);
							if(count > 0) {
						%>
						
						<!-- 테이블 -->
						<table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec">
 							<tr>
 								<th scope="row" bgcolor="lightgrey">과목명</th>
 									<td><%=plan.getCname()%></td>
 								<th scope="row" bgcolor="lightgrey">학과</th>
 									<td><%=plan.getDept()%></td>
 							</tr>
 							
 							<tr>
 								<th scope="row" bgcolor="lightgrey">학점</th>
 									<td><%=plan.getGrade()%></td>
 								<th scope="row" bgcolor="lightgrey">이수구분</th>
 									<td><%=plan.getCompdiv()%></td>
 							</tr>
 							<tr>
 								<th scope="row" bgcolor="lightgrey">시간</th>
 									<td><%=plan.getTime()%></td>
 								<th scope="row" bgcolor="lightgrey">대상학년</th>
 									<td><%=plan.getCompyear()%></td>
 							</tr>
 							<tr>
 								<th scope="row" bgcolor="lightgrey">학기</th>
 									<td><%=plan.getCompsem()%></td>
 								<th scope="row" bgcolor="lightgrey">이메일</th>
 									<td><%=plan.getEmail()%></td>
							</tr>
							<tr>
								<th scope="row" bgcolor="lightgrey">주교재</th>
									<td><%=plan.getBooks()%></td>
							</tr>
						</table>
						
						<table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec">
							<tr>
								<th scope="row" bgcolor="lightgrey">교육목표</th>
								<td ><%=plan.getPurpose()%></td>
							</tr>
						</table>
						<br><br>
						<table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec">
						<tr>
							<th scope="row" bgcolor="lightgrey">강의내용</th>
							<td align="center">
								<iframe src="https://www.youtube.com/embed/Rrf8uQFvICE" width="700px", height=400px>
  									<p>사용 중인 브라우저는 iframe을 지원하지 않습니다.</p>
								</iframe>
							</td>
						</tr>
						<%
							}else{
						%>
							<tr>
                   	           	<td colspan="5" align="center">강의계획서 작성 전</td>
                   	        </tr>
						<%
						} 
						%>
						
						</table>
						</div>
					
					<footer class="py-4 bg-light mt-auto">
						<div class="container-fluid px-4">
							<div
								class="d-flex align-items-center justify-content-between small">
								<div class="text-muted">Copyright &copy; Your Website 2023</div>
								<div>
									<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
										&amp; Conditions</a>
								</div>
							</div>
						</div>
					</footer>
				</div>
			</div>

			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
				crossorigin="anonymous"></script> <script src="js/scripts.js"></script>
			<script
				src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
				crossorigin="anonymous"></script> <script
				src="assets/demo/chart-area-demo.js"></script> <script
				src="assets/demo/chart-bar-demo.js"></script> <script
				src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
				crossorigin="anonymous"></script> <script
				src="js/datatables-simple-demo.js"></script> </script>
</body>
</html>
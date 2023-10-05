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
	String id = (String)session.getAttribute("id");
	
	//cHistoryDAO 객체 생성
	CHistoryDAO cHistoryDAO = new CHistoryDAO();
	// cHistoryVO를 담을 배열 생성
	List<CourseVO> list2 = null;
	// cHistoryDAO의 getBoardList메소드를 통해 테이블목록을 가져와서 List배열에 저장
	list2 = cHistoryDAO.getBoardList(id); // 강의내역과 강의목록을 테이블을 join해서 배열에 담아 저장함

		
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
				<jsp:include page="/inc/menu.jsp" />
			</nav>
		</div>
		<div id="layoutSidenav_content">
			<main>
			<div class="container-fluid px-4">
				<h1 class="mt-4">수강강좌</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active">cHistory</li>
				</ol>


				<div class="row">

					<p class="mb-0">
					

					<table border="1"
						style="border-collapse: collapse; border-color: lightgrey;"
						class="lec">
						<%
// 							out.print(id);
						%>
						<tr bgcolor="lightgrey" align="center">
							<td width=5%>과목명</td>
							<td width=5%>전공</td>
							<td width=5%>학년</td>
							<td width=5%>학기</td>
							<td width=5%>획득학점</td>
							<td width=5%>담당교수</td>
							
						</tr>
						<!-- Db에서 값을 가져올곳 -->
						<%
							for (CourseVO course : list2) {
						%>

						<tr align="center" style="border-bottom: 1px, solid, lightgrey;" class="course">
							<td width="5%" name="Ccode" hidden="hidden"><%=course.getCcode()%></td>
							<td width=5% name="Cname" id="Cname"><a href="cPlan.jsp?cname=<%=course.getCname()%>"><%=course.getCname()%></a></td>
							<!-- 과목명 -->
							<td width=5%><%=course.getCompdiv()%></td>
							<!-- 전필 전선 교필 교선 -->
							<td width=5%><%=course.getCompyear()%></td>
							<!-- 학년 -->
							<td width=5%><%=course.getCompsem()%></td>
							<!-- 학기 -->
							<td width=5%><%=course.getGrade()%></td>
							<!-- 획득학점 -->
							<td width=5%><%=course.getProfessor()%></td>
							<!-- 담당교수 -->
							
						</tr>
						<%
							}
						%>

					</table>

					<br>
					<br>
					<jsp:include page="../inc/chat.jsp"></jsp:include>
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
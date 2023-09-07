<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="member.ProfessorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 교수정보게시판</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script>
        
        
        
        </script>
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
                        <h1 class="mt-4">교수등록</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">professor_mod</li>
                        </ol>
                        <div class="row">


					<table>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="id"></td>
							
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" name="name"></td>
							
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="text" name="tel"></td>
							
						</tr>
						<tr>
							<th>주민등록번호</th>
							<td><input type="text" name="ssn"></td>
							
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="text" name="email"></td>
							
						</tr>
						<tr>
							<th>주소</th>
							<td><input type="text" name="addr"></td>
							
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="text" name="pwd"></td>
							
						</tr>
						<tr>
							<th>소속 학부</th>
							<td><select name="faculty">
									<!-- name="addr" 로 수정 -->
									<option value="Engine">엔진</option>
									<option value="Science">과학</option>
									<option value="Arts">예술</option>
									<option value="Business">경영</option>
									<option value="Medicine">의학</option>
									<option value="Social">사회</option>
									<option value="Education">교육</option>
							</select></td>
						</tr>
						<tr>
							<th>소속 전공</th>
							<td><select name="dept">
									<!-- name="addr" 로 수정 -->
									<option value="Computer">컴퓨터</option>
									<option value="Physics">물리학</option>
									<option value="History">역사학</option>
									<option value="Marketing">마케팅</option>
									<option value="Biology">생물학</option>
									<option value="Economics">경제학</option>
									<option value="Mathema">수학</option>
							</select></td>
						</tr>
					</table>



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

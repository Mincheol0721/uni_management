<%@page import="notice.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	//한글처리
	request.setCharacterEncoding("UTF-8"); 

	//id, 직업 값 얻어오기
	String id = (String)session.getAttribute("id");
	String job = (String)session.getAttribute("job");
	String path = request.getContextPath();
	int date = Integer.parseInt( request.getParameter("date") );
	
// 	System.out.println("notice.jsp id: " + id);
// 	System.out.println("notice.jsp job: " + job);

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
        <script type="text/javascript">
        	$(function() {
        		var $id = '<%=id%>';
        		var $path = '<%=path%>';
        		
        		if($id == 'null') {
        			alert('관리자만 접근가능한 페이지입니다.');
        			location.href = $path + '/index.jsp';
        		}
			});
        </script>
        <style type="text/css">
	        .notice_title {
	       		font-size: 16px;
	       		font-weight: 400;
	       		align-items: center;
	       	}
	       	hr {
	       		width: 100%;
	       		align-items: center;
	       		color: grey;
	       	}
	       	.writeBtn {
		       	float: right;
	       		margin-left: 10px;
	       		border-radius: 10%;
	       	}
	       	input[type=text] {
	       		border: 1px solid lightgrey;
	       		width: 80%;
	       	}
	       	textarea {
	       		border: 1px solid lightgrey;
	       		width: 80%;
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
	           		<%--사이드바--%>
	                <jsp:include page="/inc/menu.jsp" />
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                     <div class="container-fluid px-4">
                        <h1 class="mt-4">학사일정</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Schdule</li>
                        </ol>
                        <div class="card mb-4">
                             <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                 <h4 class="m-0 font-weight-bold text-primary">학사일정</h4>
                             </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                    <form action="nwritePro.jsp" method="post">
	                   	           		<div class="col-md-12">
											<div class="row">
											<input type="hidden" value="<%=id%>" name="id">
												<div class="col-md-2">
													<span class="notice_title">분류</span>
												</div>
												<div class="col-md-10">
													<input type="text" class="notice" name="nclass">
												</div>
												<br><br><hr>
												<div class="col-md-2">
													<span class="notice_title">제목</span>
												</div>
												<div class="col-md-10">
													<input type="text" class="notice" name="title">
												</div>
												<br><br><hr>
												<div class="col-md-2">
													<span class="notice_title">내용</span>
												</div>
												<div class="col-md-10">
													<textarea class="notice" name="content" rows="20"></textarea>
												</div>
												<br><br><hr>
											</div>
										</div>
	                   	           		<input type="submit" value="작성완료"  class="writeBtn"> &nbsp;&nbsp;
	                   	           		<input type="reset" value="다시쓰기" class="writeBtn"> &nbsp;&nbsp;
	                   	           		<input type="button" value="글목록" class="writeBtn" onclick="location.href='../menu/notice.jsp'">
	                   	           	</form>
	                   	           	<br>
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

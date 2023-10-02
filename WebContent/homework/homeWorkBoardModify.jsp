<%@page import="homework.HomeWorkBoardDAO"%>
<%@page import="homework.HomeWorkBoardDTO"%>
<%@page import="homework.HomeWorkDTO"%>
<%@page import="homework.HomeWorkDAO"%>
<%@page import="lectureBoard.LectureVO"%>
<%@page import="java.util.List"%>
<%@page import="lectureBoard.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>

<% 
//한글처리
request.setCharacterEncoding("UTF-8"); 

%>
<%
	//세션 id값 가져오기
	String id = (String)session.getAttribute("id");
	
	String cname = request.getParameter("cname");
	
	String tasktitle = request.getParameter("tasktitle");
	
	//get방식으로 전송된 글번호값 가져오기
	String num = request.getParameter("num");
	//강의평가게시판의 <a>태그를 클릭했을때의 그 클릭한곳의 글번호를 올바르게 가져옴
	
	// 데이터베이스에서 조회해서 뿌려줄 역할을 할 DAO객체 생성
	HomeWorkBoardDAO homeBoardDAO = new HomeWorkBoardDAO();
	// HomeWorkBoardDTO의 gethomeWorkModifyNum메소드를 통해 테이블목록을 글번호에 해당하는 테이블을 가져옴
		HomeWorkBoardDTO homeVO = homeBoardDAO.gethomeWorkModifyNum(num);
	
		HomeWorkBoardDTO name = homeBoardDAO.getStudentName(id);
		
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 과제</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
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
					<jsp:include page="/inc/cPlanMenu.jsp" />
                </nav>
            </div>
            <div id="layoutSidenav_content" style="background-color: white">
                <main>
                  
              			
                        <div class="container" align="center">
                        	<br><br>
                        	
                        	
                        	<form action="fileUploadAction.jsp" method="post" enctype="multipart/form-data">
								<input type="text" name="cname" value="<%=cname%>" hidden=""> <!-- 과목명 -->
								<div class="input-group flex-nowrap">
								<span class="input-group-text" id="addon-wrapping">학생이름</span>
								<input type="text" class="form-control" value="<%=name.getName()%>" name="studentName" readonly="readonly">
								</div><br>
								<div class="input-group flex-nowrap">
								<span class="input-group-text" id="addon-wrapping">과제명</span>
								<input type="text" class="form-control" value="<%=tasktitle%>" name="taskTitle" readonly="readonly"><br>
								</div><br>
								<div class="input-group flex-nowrap">
								<span class="input-group-text" id="addon-wrapping">제목</span>
								<input type="text" class="form-control" name="title"><br>
								</div><br>
								<div class="form-floating">
								<textarea class="form-control" style="height: 250px" name="content"></textarea><br> <!-- 본문 -->
								</div>
								<div class="input-group mb-3">
									
								<input type="file" name="file" class="form-control">
								</div> 
								<input type="submit" class="btn btn-primary" value="전송하기">
								<input type="button" class="btn btn-primary" id="cancel" value="취소">
							</form>
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
        
        <script type="text/javascript">
        	$("#cancel").on('click',function(){
        		history.back();
        	})
        
        </script>
        
    </body>
</html>

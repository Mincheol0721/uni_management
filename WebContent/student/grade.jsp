<%@page import="grade.GradeVO"%>
<%@page import="java.util.List"%>
<%@page import="grade.GradeDAO"%>
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
        <title>OO대학교 학사관리 시스템 - 수강신청</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="../js/scripts.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
    
    <%
    	//GradeDAO 객체 생성 
    	GradeDAO gradeDAO = new GradeDAO();
    	// grade vo 를 담을 배열생성
    	List<GradeVO> list = null;
    	//세션객체에 저장된 id값 들고오기
    	String id = (String)session.getAttribute("id");
    	
    	//
    	list = gradeDAO.getBoardList(id);
    %>
    
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <jsp:include page="/inc/logo.jsp" />
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
                        <h1 class="mt-4">성적</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">grade</li>
                        </ol>
                        <div class="row">
                        	<p class="mb-0">
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec"> 
                   	           		<tr bgcolor="lightgrey" align="center">
                   	           			<td width=5%>과목명</td>
                   	           			<td width=5%>전공</td>
                   	           			<td width=5%>학년</td>
                   	           			<td width=5%>점수</td> <!-- 교수쪽과 동일하게 점수로 명칭 바뀌었습니다 -->
                   	           			<td width=5%>등급</td>
                   	           		</tr>
                   	           		<%
                   	           		for(GradeVO grade : list) {
                   	           		%>
                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
                   	           			<td width=5%><%=grade.getCname()%></td>
                   	           			<td width=5%><%=grade.getCompdiv()%></td>
                   	           			<td width=5%><%=grade.getCompyear()%></td>
                   	           			<td width=5%><%=grade.getGrade()%></td>
                   	           			<td width=5%><%=grade.getRate()%></td>
                   	           		</tr>
                   	           	<%
                   	           	}
                   	           	%>
                   	           </table>
                            </p>
                        </div>
                    </div>
                    <jsp:include page="../inc/chat.jsp"></jsp:include>
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

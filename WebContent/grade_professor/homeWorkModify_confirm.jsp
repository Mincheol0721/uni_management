<%@page import="homework.HomeWorkBoardDAO"%>
<%@page import="homework.HomeWorkBoardDTO"%>
<%@page import="homework.HomeWorkDTO"%>
<%@page import="homework.HomeWorkDAO"%>
<%@page import="lectureBoard.LectureVO"%>
<%@page import="java.util.List"%>
<%@page import="lectureBoard.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>

<% request.setCharacterEncoding("UTF-8"); %>
<%
	//세션 id값 가져오기
	String id = (String)session.getAttribute("id");
	
	String cname = request.getParameter("cname");

	//get방식으로 전송된 글번호값 가져오기
	String num = request.getParameter("num");
	
	
	
	// 데이터베이스에서 조회해서 뿌려줄 역할을 할 DAO객체 생성
	HomeWorkDAO homeDAO = new HomeWorkDAO();
	// HomeWorkDAO의 gethomeworkModifyNum메소드를 통해 테이블목록을 글번호에 해당하는 테이블을 가져옴
		HomeWorkDTO homeVO = homeDAO.gethomeworkModifyNum(num);	
	
		//사용자의 이름을 가져오는 구문
				HomeWorkBoardDAO homeBoardDAO = new HomeWorkBoardDAO();
				
		    	HomeWorkBoardDTO name = homeBoardDAO.getStudentName(id);
		    	
		    	String userName = name.getName();
	
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 강의평가</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <jsp:include page="../inc/logo.jsp" />
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                  	 <jsp:include page="/inc/cPlanMenu.jsp" />
                </nav>
            </div>
            <div id="layoutSidenav_content" style="background-color: white">
                <main>
                    <div class="position-relative">
              			
                        <div class="container">
                        	<div class="row justify-content-center">
                        	
                        	<form class="form-inline w-75" action="homeWorkModifyPro.jsp?numb=<%=num%>" method="post" enctype="multipart/form-data">
	                       
							
							<input type="text" id="userName" value="<%=userName%>" hidden="">
							<input type="text" name="cname" value="<%=cname%>" hidden=""> <!-- 과목명 -->
							<input type="text" name="num" value="<%=num%>" hidden="">
							<div class="input-group flex-nowrap mt-3 mb-3">
							  <span class="input-group-text" id="addon-wrapping">학생이름</span>
							  <input type="text" class="form-control" aria-describedby="addon-wrapping" name="studentName" id="studentName" value="<%=homeVO.getStudentName()%>" disabled="disabled">
							</div>
							<div class="input-group flex-nowrap mt-3">
								  <span class="input-group-text">과제명</span>
								  <input type="text" class="form-control" name="taskTitle" id="taskTitle" disabled="disabled" value="<%=homeVO.getTaskTitle()%>">							
							</div>
							<div class="input-group flex-nowrap mt-3">
								  <span class="input-group-text">글 제목</span>
								  <input type="text" class="form-control" name="title" id="title" disabled="disabled" value="<%=homeVO.getTitle()%>" required="required" maxlength="20">							
							</div>
							 
							<div class="form-floating">
								  <textarea class="form-control" id="content" style="height: 300px" name="content" disabled="disabled" required="required" maxlength="800"><%=homeVO.getContent()%></textarea>
								  <label for="floatingTextarea2"></label>
							</div>
							<div class="input-group mb-3">
							<!-- 파일첨부 -->
							<span style="display: none" id="fileDisplay">
								<input type="file" name="file" class="form-control" required="required">
							</span>
							</div>
							<div class="col text-center" id="reflectedList" style="display: none">
								<input type="submit" class="btn btn-primary btn-sm" value="수정반영하기" id="reflected">
								<input type="button" class="btn btn-primary btn-sm" value="취소" id="cancel">
							</div>
							</form>
							
						</div>
						</div>
						<div class="col text-center" id="modifyList" >							
								<input type="button" class="btn btn-primary btn-sm" value="리스트로돌아가기" id="backlist">
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
        
        <script type="text/javascript">
        	//리스트버튼을 눌렀을때
        	$("#backlist").on('click',function(){
        		location.href = "homework_confirm.jsp?studentName=<%=userName%>&cname=<%=cname%>";
        	});
        </script>
        
    </body>
</html>

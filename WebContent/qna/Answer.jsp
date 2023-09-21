<%@page import="qna.QnaDTO"%>
<%@page import="qna.QnaDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	//한글처리
	request.setCharacterEncoding("UTF-8"); 

	int no = Integer.parseInt( request.getParameter("no") );
	
	System.out.println("no: " + no);
	
	QnaDAO dao = new QnaDAO(); 
	
	dao.updateReadCount(no);
	
	QnaDTO dto = new QnaDTO();
	dto = dao.getBoard(no);
	
	//id, 직업 값 얻어오기
	String id = (String)session.getAttribute("id");
	String job = (String)session.getAttribute("job");
	String path = request.getContextPath();
	String title = dao.getTitle(no);
	String checkedId = dao.idCheck(no);
	
// 	System.out.println("qna.jsp id: " + id);
// 	System.out.println("qna.jsp job: " + job);

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
        		var $job = '<%=job%>';
        		var $checkedId = '<%=checkedId%>';
				var $id = '<%=id%>';
				var $path = '<%=path%>';
				var $no = <%=no%>;
				
        		if($id != $checkedId) {
        			$('#modQna').remove();
        			$('#delQna').remove();
        			if($job == '교수' || $job == '교직원') {
        				$('#answer').html('<input type="button" class="writeBtn" value="답변달기" onclick="answer();">');
        			}
        		}
        		
			});
        	
        	function answer() {
// 				alert('answer함수 호출');
				location.href = $path + '/qna/Answer.jsp?no=<%=no%>';
			}
        	
        </script>
        <style type="text/css">
	        .qna_title {
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
	       		border: none;
	       		width: 80%;
	       	}
	       	textarea {
	       		border: none;
	       		width: 80%;
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
                     <div class="container-fluid px-4">
                        <h1 class="mt-4">질의응답</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Q&A</li>
                        </ol>
                        <div class="card mb-4">
                             <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                 <h4 class="m-0 font-weight-bold text-primary">질의응답</h4>
                             </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                    <form action="AnswerPro.jsp?no<%=no %>" method="post">
                                    	<input type="hidden" value="<%=no%>" name="no">
                                    	<div class="col-md-12">
											<div class="row">
											<input type="hidden" value="<%=id%>" name="id">
												<div class="col-md-2">
													<span class="qna_title">제목</span>
												</div>
												<div class="col-md-10">
													<input type="text" class="qna" value="<%=dto.getTitle() %>" readonly>
												</div>
												<br><br><hr>
												<div class="col-md-2">
													<span class="qna_title">내용</span>
												</div>
												<div class="col-md-10">
													<textarea class="qna" rows="20" readonly><%=dto.getContent()%></textarea>
												</div>
												<br><br><hr>
												<div class="col-md-2">
													<span class="qna_title">작성일</span>
												</div>
												<div class="col-md-10">
													<input type="text" class="qna" value="<%=dto.getWriteDate()%>" readonly>
												</div>
												<br><br><hr>
												<div class="col-md-2">
													<span class="qna_title">제목</span>
												</div>
												<div class="col-md-10">
													<input type="text" class="qna" name="title" value="<%=title%> → 에 대한 답변글">
												</div>
												<br><br><hr>
												<div class="col-md-2">
													<span class="qna_title">내용</span>
												</div>
												<div class="col-md-10">
													<textarea class="qna" name="content" rows="20"></textarea>
												</div>
												<br><br><br><hr>
											</div>
										</div>
	                   	           		<input type="submit" value="답글작성"  class="writeBtn" id="AnswerPro"> &nbsp;&nbsp;
	                   	           		<input type="button" value="답글삭제"  class="writeBtn" id="delQna" onclick="confirm('해당 게시글을 삭제하시겠습니까?'); location.href='delQna.jsp?no=<%=no%>'"> &nbsp;&nbsp;
	                   	           		<input type="button" value="글목록" class="writeBtn" onclick="location.href='../menu/qna.jsp'">
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

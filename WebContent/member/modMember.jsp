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
	
	dto = new MemberDTO();
	
	if(id != null) {
		ProfessorDAO pdao = new ProfessorDAO();
		StudentDAO sdao = new StudentDAO();
		EmployeeDAO edao = new EmployeeDAO();
		
		System.out.println("직업: " + job);
		System.out.println("id: " + id);
		
		
		if(job.equals("교수")){
			dto = pdao.selectMember(id);
		} else if(job.equals("학생")){
			dto = sdao.selectMember(id);
		} else if(job.equals("교직원")){
			dto = edao.selectMember(id);
		}
	}
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
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
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
        		margin-left: 90%;
        	}
        	input {
        		border: 1px solid grey;
        	}
        	
        	@media (max-width: 1200px) {
        	#btn {
        		margin-left: 80%;
        	}
        	}
        </style>
        <script type="text/javascript">
        	$(function() {
        		
        		/* 비밀번호 확인 */
				$("#pwdConfirm").focusout(function() {
				
					var $pwd = $("#pwd").val();
					var $pwdConfirm = $("#pwdConfirm").val();
					var $msg = $("#pwdConfirmMsg");
					
					if($pwd != $pwdConfirm) {
						$msg.attr('style', 'color:red; font-size: small;');
						$msg.text("비밀번호가 일치하지 않습니다.");
						return false;
					} else {
						$msg.attr('style', 'color:grey; font-size: small;');
						$msg.text("비밀번호가 일치합니다.");
						return true;
					}
				});//비밀번호 확인
				
				/* 비밀번호 유효성 체크 */
				$("#pwd").focusout(function() {
					
					var $pwd = $("#pwd").val();
					var $msg = $("#pwdMsg");
					
					if( $pwd.length < 8 || $pwd.length > 16 ) {
						$msg.attr("style", "color:red; font-size:small;");
						$msg.text("비밀번호는 8자~16자 사이로 입력해주세요");
						return false;
					} else {
						$msg.text("");
						return true;
					}
				}); //비밀번호 유효성
        		
				//교직원일 경우 학부 및 학과 태그 제거
	        	if('<%=job%>' == '교직원') {
	        		$(".faculty").remove();
	        		$(".dept").remove();
	        	};
	        	
			});
        </script>
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
                        <h1 class="mt-4">회원정보 수정</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">my-info</li>
                        </ol>
                        <div class="col-xl-12 col-lg-7">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h4 class="m-0 font-weight-bold text-primary">정보 수정</h4>
                                </div>
                                <div class="card-body">
                                    <div class="chart-area"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                    <form action="${path}/member/modMemberPro.jsp">
                                    	<div class="container-fluid">
										<div class="row">
<%
												if(id != null) {
%>
											<div class="col-md-12">
												<div class="row">
													<div class="col-md-2">
														<span class="info_title">이름</span>
													</div>
													<div class="col-md-10">
														<input type="text" value="<%=dto.getName() %>" class="info" name="name">
													</div>
													<br><br><hr>
													<div class="col-md-2">
														<span class="info_title">구분</span>
													</div>
													<div class="col-md-10">
														<input type="text" value="<%=job %>" class="info" disabled="disabled">
													</div>
													<br><br><hr>
													<div class="col-md-2">
														<span class="info_title">아이디</span>
													</div>
													<div class="col-md-10">
														<input type="text" value="<%=dto.getId() %>" class="info" name="id" disabled>
														<input type="hidden" value="<%=dto.getId() %>" name="id">
													</div>
													<br><br><hr>
													<div class="col-md-2">
														<span class="info_title">비밀번호 변경</span>
													</div>
													<div class="col-md-10">
														<input type="password" class="info" name="pwd" id="pwd">
														<span id="pwdMsg"></span>
														<input type="hidden" value="<%=dto.getPwd()%>" name="pwd">
													</div>
													<br><br><hr>
													<div class="col-md-2">
														<span class="info_title">비밀번호 확인</span>
													</div>
													<div class="col-md-10">
														<input type="password" class="info" name="pwdConfirm" id="pwdConfirm">
														<span id="pwdConfirmMsg"></span>
													</div>
													<br><br><hr>
													<div class="col-md-2">
														<span class="info_title">주민등록번호</span>
													</div>
													<div class="col-md-10">
														<input type="text" value="<%=dto.getSsn().substring(0, 8) %>******" name="ssn" disabled>
														<input type="hidden" value="<%=dto.getSsn() %>" name="ssn">
													</div>
													<br><br><hr>
													<div class="col-md-2">
														<span class="info_title">연락처</span>
													</div>
													<div class="col-md-10">
														<input type="text" value="<%=dto.getTel() %>" class="info" name="tel">
													</div>
													<br><br><hr>
													<div class="col-md-2">
														<span class="info_title">이메일</span>
													</div>
													<div class="col-md-10">
														<input type="text" value="<%=dto.getEmail() %>" class="info" name="email">
													</div>
													<br><br><hr>
													<div class="col-md-2">
														<span class="info_title">주소</span>
													</div>
													<div class="col-md-10">
														<input type="text" value="<%=dto.getAddr() %>" class="info" name="addr">
													</div>
													<br><br><hr>
													<div class="col-md-2 faculty">
														<span class="info_title">학부</span>
													</div>
													<div class="col-md-10 faculty">
														<input type="text" value="<%=dto.getFaculty() %>" class="info" name="faculty" disabled>
														<input type="hidden" value="<%=dto.getFaculty() %>" name="faculty">
													</div>
													<br class="faculty"><br class="faculty"><hr class="faculty">
													<div class="col-md-2 dept">
														<span class="info_title">전공</span>
													</div>
													<div class="col-md-10 dept">
														<input type="text" value="<%=dto.getDept() %>" class="info" name="dept" disabled>
														<input type="hidden" value="<%=dto.getDept() %>" name="dept">
													</div>
													<br class="dept"><br class="dept"><hr class="dept">
		                                    		<small><input type="submit" id="btn" value="수정하기"></small>
												</div>
											</div>
<%
												} else {
%>	
													<script type="text/javascript">
														alert('로그인이 필요한 페이지입니다. \r\n로그인 후 다시 이용해주세요.');
														location.href = 'login.jsp';
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

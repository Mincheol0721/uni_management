
<%@page import="member.EmployeeDAO"%>
<%@page import="member.StudentDAO"%>
<%@page import="member.ProfessorDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
	request.setCharacterEncoding("UTF-8"); 
	
	MemberDTO dto = new MemberDTO();
	ProfessorDAO pdao = new ProfessorDAO();
	StudentDAO sdao = new StudentDAO();
	EmployeeDAO edao = new EmployeeDAO();
	
%>

<!DOCTYPE html>
<html>
	<head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 - 로그인</title>
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
        <style type="text/css">
        	.input {
        		position: relative;
        	}
        	.eyes {
        		color: #2b2b2b;
        		opacity: 0.8;
        		position: absolute;
        		right: 7px;
        		top: 50%;
        		transform: translateY(-50%);
        		border: none;
        		background-color: rgba(0, 0, 0, 0);
        	}
        </style>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">로그인하기</h3></div>
                                    <div class="card-body">
                                        <form action="loginPro.jsp" method="post">
                                        	<div class="form-check mb-3" style="align-content: center;">
                                            	<input type="radio" id="professor" value="교수" name="job" checked="checked"> 교수
                                            	&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
                                            	<input type="radio" id="student" value="학생" name="job"> 학생 
                                            	&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
                                            	<input type="radio" id="employee" value="교직원" name="job"> 교직원
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="id" type="text" name="id" placeholder="202310001" />
                                                <label for="inputEmail">학번/교번</label>
                                            </div>
                                            <div class="form-floating mb-3 input">
                                                <input class="form-control active" id="pwd" type="password" name="pwd" placeholder="Password" />
                                                <button type="button" class="showPwd eyes"><i class="fa fa-eye fa-lg" ></i></button>
                                                <button type="button" class="hidePwd eyes"><i class="fa fa-eye-slash fa-lg" ></i></button>
                                                <label for="inputPassword">비밀번호 </label>
                                                
                                            </div>
                                            <div class="form-check mb-3">
                                                <input class="form-check-input" id="inputRememberPassword" type="checkbox" value="" />
                                                
                                                <label class="form-check-label" for="inputRememberPassword">비밀번호 기억하기</label>
                                            </div>
                                            <div class="d-flex align-items-right mb-0">
                                                <input type="submit" class="btn btn-primary" value="로그인" >
                                            </div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a href="register.jsp">학생 / 교수 등록하러 가기</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <div id="layoutAuthentication_footer">
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
        <script type="text/javascript">
        	$('.hidePwd').hide();
        	$('.showPwd').hide();
        	
        	if($('#pwd').on('keyup', function() {
        		$('.showPwd').show();
	        	console.log($('#pwd').val().length);
        	}));
        	if($('#pwd').val().length == 0) {
        		$('.showPwd').hide();
        	}
        	
        	$('.eyes').on('click', function() {
				if($('#pwd').hasClass('active')){
					$('#pwd').removeClass('active');
					$('#pwd').attr('type', 'text');
					$('.showPwd').hide();
					$('.hidePwd').show();
				} else {
					$('#pwd').addClass('active');
					$('#pwd').attr('type', 'password');
					$('.hidePwd').hide();
					$('.showPwd').show();
				}
			});
        	
        	
        	/* 
        	// Create a password for the user
        	var password = '';
        	var $job = $('input[name="job"]:checked');
        	var $id = $('#id');
        	
        	
        	if($job.on('change', function() {
        		alert('job: ' + $job.val() + '\r\nid: ' + $id.val())
        	}));
        	// Encrypt the password using a secure encryption algorithm, such as AES
        	var encryptedPassword = CryptoJS.AES.encrypt(password, "");

        	// Create a cookie to store the encrypted password
        	document.cookie = "password=" + encryptedPassword + ";";

        	// Set the cookie's expiration date to the desired length of time
        	var date = new Date();
        	date.setTime(date.getTime() + (1 * 60 * 1000)); // 1 hour
        	document.cookie = "password=" + encryptedPassword + "; expires=" + date.toUTCString() + ";";
        	
        	const rememberPwd = $('#inputRememberPassword');
        	rememberPwd.on('change', function() {
        		if(rememberPwd.is(':checked')) {
        			//로그인 아이디 쿠키 가져오기
        			alert('기억!');
        		} else {
        			//로그인 아이디 쿠키 제거
        			alert('망각!');
        		}
        	});
        	 */
        	
        </script>
    </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
	<head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학생/교수 등록</title>
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">학생 / 교수 등록하기</h3></div>
                                    <div class="card-body">
                                        <form>
                                        	<div class="form-floating mb-3">
                                        		<input type="radio" id="professor" value="교수" name="job" checked="checked"> 교수
                                            	&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
                                            	<input type="radio" id="student" value="학생" name="job"> 학생 
                                            	&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
                                            	<input type="radio" id="employee" value="교직원" name="job"> 교직원
                                        	</div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="id" type="text" />
                                                <label for="id">학번 / 교번</label>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input class="form-control" id="pwd" type="password" />
                                                        <label for="pwd">비밀번호<span style="color: grey;"><small>&nbsp;| 비밀번호는 8자 이상 입력해주세요</small></span></label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input class="form-control" id="pwdConfirm" type="password" />
                                                        <label for="pwdConfirm">비밀번호 확인</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="name" type="text" />
                                                <label for="name">이름</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="tel" type="text" />
                                                <label for="mobile">전화번호<span style="color: grey;"><small>&nbsp;| 하이픈(-)을 빼고 입력해주세요</small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="ssn" type="text" />
                                                <label for="ssn">주민등록번호<span style="color: grey;"><small>&nbsp;| 하이픈(-)을 빼고 13자리로 입력해주세요</small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="email" type="email" />
                                                <label for="email">이메일<span style="color: grey;"><small>&nbsp;| test@example.com</small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="addr" type="text" />
                                                <label for="addr">주소</label>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input class="form-control" id="faculty" type="text" />
                                                        <label for="faculty">학부</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input class="form-control" id="dept" type="text" />
                                                        <label for="dept">전공</label>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="mt-4 mb-0">
                                                <div class="d-grid"><a class="btn btn-primary btn-block" href="login.jsp">등록하기</a></div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a href="login.jsp">계정이 있으신가요? 로그인하러 가기</a></div>
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
    </body>
</html>
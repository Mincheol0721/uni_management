<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
	import="faculty.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
	request.setCharacterEncoding("UTF-8"); 
%>

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
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script type="text/javascript">
        	$(function() {
        		/* 
        			학부의 경우 select를 id속성값으로 할 경우 값을 못받아오거나 null로 받아오게 됨
        			그래서 새로 name속성을 부여하고 name속성으로 선택해왔더니 값을 제대로 전달받음
        			학과는 뒤에 더 추가될 select option태그가 없기 때문에 id값으로 받아와도 제대로 값이 전달됨
        			JSONObject를 반복문 밖에 생성했을 경우 Object를 하나만 생성하기 때문에, 값을 받아오더라도
        			계속해서 덮어씌우기 때문에 값을 마지막 값 하나만 받아오게 되므로, 반복문 안에 설정해줘야 함
        			
        			중요.  각각 다른 Servlet을 생성하고 다른 bean파일을 생성하여 따로 요청을 해야지만
        				   ajax 비동기방식으로 요청했을 때 각자가 가진 속성들을 제대로 불러올 수 있음
        				   만약 하나의 bean파일에 다른 속성들이 포함되었다고 해서 그 bean파일만 사용했을 경우
        				   다른 bean파일에는 존재하고 여기에는 존재하지 않는 속성은 뜨지 않으며, 
        				   해당 bean파일에서 불러온 DB가 가진 모든 해당속성을 가져와 중복의 여지가 있음
        				   한마디로 대참사가 벌어질 수 있음
        		*/
        		var $fsel = $("select[name=faculty]");
        		var $dselect = $("#dept");
        		
        			
        		$fsel.empty();
        		
				$.ajax({
					url : '<%=request.getContextPath()%>/register/faculty.do',
					type : 'POST',
					dataType : 'json',
					success : function(data){
						console.log("data: " + JSON.stringify(data));
						$.each(data, function(i, dto) {
							$fsel.append("<option value='" + dto.fname + "' name='foption'>" + dto.fname + "</option>"); 
						});
					}
				}); //학부 ajax
				
					
				$(document).on("change", $("#faculty option:selected"), function() {
					$dselect.empty();
					
					$.ajax({
						url : '<%=request.getContextPath()%>/register/dept.do',
						type : 'POST',
						data : {foption : $(this).val(), fname : $fsel.val()},
						dataType : 'json',
						success : function(data){
							$.each(data, function(index, dto) {
								$dselect.append("<option value='" + dto.dname + "' name='doption'>" + dto.dname + "</option>"); 
							});
						}
					});
					
				}); //onchange 이벤트핸들러
				
				$("#id").on("keyup", function() {
					var $msg = $("#chkId");
					var id = $('#id').val();
					var job = $('input[type="radio"][name="job"]:checked').val();
					
					if(job == '교수'){
						$.ajax({
							url : '<%=request.getContextPath()%>/register/checkPid.do',
							type : 'POST',
							data : {id: id, job: job},
							dataType : 'text',
							success : function(data) {
								
								$.each(JSON.parse(data), function(i, d) {
									if(d.cnt == '1') {
										$msg.attr('style', 'color:red;');
										$msg.text(" | 존재하는 아이디입니다.");
									} else {
										$msg.attr('style', 'color:grey;');
										$msg.text(" | 사용 가능한 아이디입니다.");
									}
								});
								
							}
							
						});
					} else if(job == '학생') {
						$.ajax({
							url : '<%=request.getContextPath()%>/register/checkSid.do',
							type : 'POST',
							data : {id: id, job: job},
							dataType : 'text',
							success : function(data) {
								
								$.each(JSON.parse(data), function(i, d) {
									if(d.cnt == '1') {
										$msg.attr('style', 'color:red;');
										$msg.text(" | 존재하는 아이디입니다.");
									} else {
										$msg.attr('style', 'color:grey;');
										$msg.text(" | 사용 가능한 아이디입니다.");
									}
								});
							}
							
						});
					} else if(job == '교직원') {
						$.ajax({
							url : '<%=request.getContextPath()%>/register/checkEid.do',
							type : 'POST',
							data : {id: id, job: job},
							dataType : 'text',
							success : function(data) {
								
								$.each(JSON.parse(data), function(i, d) {
									if(d.cnt == '1') {
										$msg.attr('style', 'color:red;');
										$msg.text(" | 존재하는 아이디입니다.");
									} else {
										$msg.attr('style', 'color:grey;');
										$msg.text(" | 사용 가능한 아이디입니다.");
									}
								});
								
							}
							
						});
					}
				});
        			
				/* 비밀번호 확인 */
				$("#pwdConfirm").focusout(function() {
				
					var $pwd = $("#pwd").val();
					var $pwdConfirm = $("#pwdConfirm").val();
					var $msg = $("#pwdConfrimMsg");
					
					if($pwd != $pwdConfirm) {
						$msg.attr('style', 'color:red;');
						$msg.text(" | 비밀번호가 일치하지 않습니다.");
						return false;
					} else {
						$msg.attr('style', 'color:grey;');
						$msg.text(" | 비밀번호가 일치합니다.");
						return true;
					}
				});//비밀번호 확인
				
				/* 비밀번호 유효성 체크 */
				$("#pwd").focusout(function() {
					
					var $pwd = $("#pwd").val();
					var $msg = $("#pwdMsg");
					
					if( $pwd.length < 8 || $pwd.length > 16 ) {
						$("#pwdSpan").attr("style", "color:red");
						$msg.text(" | 비밀번호는 8자~16자 사이로 입력해주세요");
						return false;
					} else {
						$msg.text("");
						return true;
					}
				}); //비밀번호 유효성
				
				/* 교직원의 경우 필요없는 학부 및 학과 선택 태그 제거 */
				$("input[type='radio'][name='job']").on('click', function() {
					var checked = $("input[type='radio'][name='job']:checked").val();
					
					if(checked == '교직원'){
						$("#fac_dep").hide();
					} else {
						$("#fac_dep").show();
					} 
				}); //숨김처리
				
			});
        </script>
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
                                        <form action="registerPro.jsp" method="post">
                                        	<div class="form-floating mb-3">
                                        		<input type="radio" id="professor" value="교수" name="job" checked="checked"> 교수
                                            	&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
                                            	<input type="radio" id="student" value="학생" name="job"> 학생 
                                            	&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
                                            	<input type="radio" id="employee" value="교직원" name="job"> 교직원
                                        	</div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="id" type="text" name="id" />
                                                <label for="id">학번 / 교번<span><small id="chkId"></small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="pwd" type="password" name="pwd" required />
                                               <label for="pwd">비밀번호<span style="color: grey;" id="pwdSpan"><small id="pwdMsg">&nbsp;| 비밀번호는 8자~16자 사이로 입력해주세요</small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="pwdConfirm" type="password"  required />
                                                <label for="pwdConfirm">비밀번호 확인<span><small id="pwdConfrimMsg"></small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="name" type="text" name="name" />
                                                <label for="name">이름</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="tel" type="text" name="tel" />
                                                <label for="mobile">전화번호<span style="color: grey;"><small>&nbsp;| ex) 010-1234-5678 </small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="ssn" type="text" name="ssn" />
                                                <label for="ssn">주민등록번호<span style="color: grey;"><small>&nbsp;| ex) 901203-1234567 </small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="email" type="email" name="email" />
                                                <label for="email">이메일<span style="color: grey;"><small>&nbsp;| test@example.com</small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="addr" type="text" name="addr" />
                                                <label for="addr">주소</label>
                                            </div>
                                            <div class="row mb-3" id="fac_dep">
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <select class="form-control" id="faculty" name="faculty">
                                                        </select>
                                                        <label for="faculty">학부</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <select class="form-control" id="dept" name="dept">
                                                        </select>
                                                        <label for="dept">전공</label>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="mt-4 mb-0">
                                                <div class="d-grid"><button type="submit">등록하기</button></div>
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
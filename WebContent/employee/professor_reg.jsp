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
        <script src="../js/scripts.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script>
        
        
        
        </script>
    </head>
    <body class="sb-nav-fixed">
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
                        <h1 class="mt-4">교수 정보 등록</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">professor_reg</li>
                        </ol>
                        <div class="row">
				<form action="professor_reg_proc.jsp" method="post" onsubmit="return valid();">

					<table>
						
						<tr>
							<th>아이디</th>
							<td ><input type="text" name="id" id="id" class="form-control"></td>
							
						</tr>
						
						<tr>
							<th>이름</th>
							<td><input type="text" name="name" id="name" class="form-control"></td>
							
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="text" name="tel" id="tel" placeholder="010-0000-0000" class="form-control"></td>
							
						</tr>
						<tr>
							<th>주민등록번호</th>
							<td><input type="text" name="ssn" id="ssn" placeholder="000000-0000000" class="form-control"></td>
							
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="text" name="email" id="email" placeholder="test@example.com" class="form-control"></td>
							
						</tr>
						<tr>
							<th>주소</th>
								<td>
								<input type="text" id="sample6_postcode" name="addr1" placeholder="우편번호" class="form-control">
								<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-outline-dark"><br>
								<input type="text" id="sample6_address" name="addr2" placeholder="주소" class="form-control"><br>
								<input type="text" id="sample6_detailAddress" name="addr3" placeholder="상세주소" class="form-control">
								<input type="text" id="sample6_extraAddress" name="addr4" placeholder="참고항목" class="form-control">
								</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="text" name="pwd" id="pwd" placeholder="8자~16자 사이로 입력해주세요" class="form-control"></td>
							
						</tr>
						<%
						
						ProfessorDAO dao = new ProfessorDAO();
						
						List listf = dao.listFaculty();
						
						List listd = dao.listDept();
						
						%>
						<tr>
							<th>소속 학부</th>
							<td><select name="faculty" id="faculty" class="form-control">
							
							</select></td>
						</tr>
						<tr>
							<th>소속 학과</th>
							<td><select name="dept" id="dept" class="form-control">
							
									

							</select></td>
						</tr>
					</table>
							<input type="submit" id="professor_reg" name="professor_reg" value="등록" class="btn btn-outline-dark">
                   	  	    <input type="reset" id="professor_del" name="professor_del" value="다시작성" class="btn btn-outline-dark">
				</form>


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
        
        	function valid(){
        		
        		var id = document.getElementById("id"); 
        		
        		if(id.value ==""){
        			alert("아이디를 입력해주세요");
        			id.focus();
        			return false;
        		}
        		
				var name = document.getElementById("name"); 
        		
        		if(name.value ==""){
        			alert("이름을 입력해주세요");
        			name.focus();
        			return false;
        		}
        			
				var tel = document.getElementById("tel"); 
        		
        		if(tel.value ==""){
        			alert("전화번호를 입력해주세요");
        			tel.focus();
        			return false;
        		}
        		
        		var telCheck = /^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})+$/ // 정규 표현식 수정

        		if (!telCheck.test(tel.value)) {
        		  alert("전화번호의 형식에 맞게 입력해주세요 ex) 010-0000-0000");
        		  tel.focus();
        		  return false;
        		}
        		
        		
				var ssn = document.getElementById("ssn"); 
        		
        		if(ssn.value ==""){
        			alert("주민등록번호를 입력해주세요");
        			ssn.focus();
        			return false;
        		}
        		
        		var ssnCheck = /^[0-9]{6}-[1-4][0-9]{6}$/; // 정규 표현식 수정

        		if (!ssnCheck.test(ssn.value)) {
        			alert("주민등록번호의 형식에 맞게 입력해주세요 ex) 000000-0000000");
        		  ssn.focus();
        		  return false;
        		}
        		
				var email = document.getElementById("email"); 
        		
        		if(email.value ==""){
        			alert("이메일을 입력해주세요");
        			email.focus();
        			return false;
        		}
        		
        		var emailCheck = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

        		if (!emailCheck.test(email.value)) {
        			alert("이메일의 형식에 맞게 입력해주세요 ex) test@example.com");
        			email.focus();
        		  return false;
        		}
        		
				var pwd = document.getElementById("pwd"); 
        		
        		if(pwd.value ==""){
        			alert("비밀번호를 입력해주세요");
        			pwd.focus();
        			return false;
        		}
        		
        		var pwdCheck = /^.{8,16}$/;
        		
        		if(!pwdCheck.test(pwd.value)){
        			alert("비밀번호는 8자~16자 사이로 입력해주세요");
        			pwd.focus();
        			return false;
        		}
        		
        		return true;
        		
        		
        		
        		
        	}//valid닫는부분
        	
        	
        	var $fsel = $("select[name=faculty]");//학부
    		var $dselect = $("#dept");//학과
    		
    			
    		
			$.ajax({
				url : '<%=request.getContextPath()%>/register/faculty.do',
				type : 'POST',
				dataType : 'json',
				success : function(data){
					
					if(data != null) {
		        		$fsel.empty();
					}//if 닫기
					
					$.each(data, function(i, dto) {
						$fsel.append("<option value='" + dto.fname + "'>" + dto.fname + "</option>"); 
					});//each닫기
				}//success닫기
			}); //학부 ajax
			
				
			$("#faculty").on("change", function() {
				
				$.ajax({
					url : '<%=request.getContextPath()%>/register/dept.do',
					type : 'POST',
					data : {foption : $(this).val(), fname : $fsel.val()},
					dataType : 'json',
					success : function(data){
						
						if(data != null) {
							$dselect.empty();
						}//if닫기
						
						$.each(data, function(index, dto) {
							$dselect.append("<option value='" + dto.dname + "'>" + dto.dname + "</option>"); 
						
							console.log("dname: " + dto.dname);
						});//each닫기
						
					}//success닫기
				});//ajax닫기
				
			}); //onchange 이벤트핸들러
        </script>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		    function sample6_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수
		
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }
		
		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("sample6_extraAddress").value = extraAddr;
		                
		                } else {
		                    document.getElementById("sample6_extraAddress").value = '';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('sample6_postcode').value = data.zonecode;
		                document.getElementById("sample6_address").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("sample6_detailAddress").focus();
		            }
		        }).open();
		    }
		</script>
    </body>
</html>

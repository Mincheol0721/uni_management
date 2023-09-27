<%@page import="member.StudentDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="member.ProfessorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>

<% 
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 학생정보게시판</title>
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
                        <h1 class="mt-4">학생 정보 수정</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">student_mod</li>
                        </ol>
                        <div class="row">

					<%
					request.setCharacterEncoding("utf-8");

				
					String id = request.getParameter("id");
					String name = request.getParameter("name");
					String tel = request.getParameter("tel");
					String ssn = request.getParameter("ssn");
					String email = request.getParameter("email");
					String addr = request.getParameter("addr");
					String pwd = request.getParameter("pwd");
					String professor = request.getParameter("professor");
					String faculty = request.getParameter("faculty");
					String dept = request.getParameter("dept");
					
					MemberDTO dto = null;
					StudentDAO sdao = new StudentDAO();
					
					String addr1 = addr.substring(0, 5);
					
					String addr2 = addr.substring(6);
					
					
					ProfessorDAO dao = new ProfessorDAO();
					
					List listf = dao.listFaculty();
					
					List listd = dao.listDept();
					
					
					%>
				
					<form action="student_mod_proc.jsp" method="post">

					<table>
						<tr>
							<th>아이디</th>
							<td ><input type="text" name="id" value="<%=id%>" readonly></td>
							
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" name="name"  value="<%= name%>"></td>
							
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="text" name="tel" value="<%= tel%>"></td>
							
						</tr>
						<tr>
							<th>주민등록번호</th>
							<td><input type="text" name="ssn" value="<%= ssn%>" readonly></td>
							
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="text" name="email" value="<%= email%>"></td>
							
						</tr>
						<tr>
						
							<th>주소</th>
								<td>
								<input type="text" id="sample6_postcode" name="addr1" placeholder="우편번호" value="<%=addr1%>">
								<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
								<input type="text" id="sample6_address" name="addr2" placeholder="주소" value="<%=addr2%>"><br>
								<input type="text" id="sample6_detailAddress" name="addr3" placeholder="상세주소">
								<input type="text" id="sample6_extraAddress" name="addr4" placeholder="참고항목">
								</td>
							
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="text" name="pwd" value="<%= pwd%>"></td>
							
						</tr>
						<tr>
							<th>교수</th>
							<td>
								<select  id="professor" name="professor">
									<option><%= professor%></option>
								</select>
							</td>
							
							
						</tr>
						<tr>
							<th>소속 학부</th>
							<td><select  id="faculty" name="faculty">
							<%
							
							for(int i=0; i<listf.size(); i++ ){
								dto = (MemberDTO)listf.get(i);
								
								
						    %>
						    
								<option id="option" value="<%= dto.getFaculty()%>"<%if(dto.getFaculty().equals(faculty)){%>selected<%}%>>
								<%= dto.getFaculty()%>
								</option>
							<%	
								
							}//for문
							
							%>
									
								</select></td>
						</tr>
						<tr>
							<th>소속 학과</th>
							<td><select  id="dept" name="dept">
							<%-- 
							
							
							학부가 바뀌면 전공도 자동으로 들어가게하기
							외래키 fname열에 해당하는 dname을 가져와서 뿌려주자
							 --%>
							<%
							for(int i=0; i<listd.size(); i++ ){
								dto = (MemberDTO)listd.get(i);
								
						    %>
								<option id="option" value="<%= dto.getDept()%>"<%if(dto.getDept().equals(dept)){%>selected<%}%>>
								<%= dto.getDept()%>
								</option>
							<%	
							}
							
							
							
							
							%>
							</select></td>
						</tr>
					</table>
							<input type="submit" id="student_reg" name="student_reg" value="등록">
                   	  	    <input type="reset" id="student_del" name="student_del" value="다시작성">
				</form>



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
       <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		var $name = $("#professor");
		var strP = '<%=professor%>';
		$name.one("click", function(e) {

			$.ajax({
				url : '<%=request.getContextPath()%>/register/professor.do',
				type : 'POST',
				dataType : 'json',
				success : function(data){
					
					if(data != null) {
			    		$name.empty();
					}
					
					$.each(data, function(i, dto) {
						
						$name.append("<option value='" + dto.name + "'>" + dto.name + "</option>"); 
					});
				}
			}); //교수 ajax
		});
		
			
		
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

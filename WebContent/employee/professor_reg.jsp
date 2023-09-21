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
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script>
        
        
        
        </script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <jsp:include page="../inc/logo.jsp" />
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
							<td ><input type="text" name="id" id="id"></td>
							
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" name="name" id="name"></td>
							
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="text" name="tel" id="tel"></td>
							
						</tr>
						<tr>
							<th>주민등록번호</th>
							<td><input type="text" name="ssn" id="ssn"></td>
							
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="text" name="email" id="email"></td>
							
						</tr>
						<tr>
							<th>주소</th>
							<td><input type="text" name="addr" id="addr"></td>
							
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="text" name="pwd" id="pwd"></td>
							
						</tr>
						<%
						
						ProfessorDAO dao = new ProfessorDAO();
						
						List listf = dao.listFaculty();
						
						List listd = dao.listDept();
						
						%>
						<tr>
							<th>소속 학부</th>
							<td><select name="faculty">
								<%for(int i=0; i<listf.size(); i++ ){
									MemberDTO dto = (MemberDTO)listf.get(i);
									
									
								    %>
								    
										<option id="option" value="<%= dto.getFaculty()%>">
										<%=dto.getFaculty()%>
										</option>
								<% 	
								}
								%>
							</select></td>
						</tr>
						<tr>
							<th>소속 전공</th>
							<td><select name="dept">
									<%
							for(int i=0; i<listd.size(); i++ ){
								MemberDTO dto = (MemberDTO)listd.get(i);
								
						    %>
								<option id="option" value="<%= dto.getDept()%>">
								<%= dto.getDept()%>
								</option>
							<%	
							}
							%>
									

							</select></td>
						</tr>
					</table>
							<input type="submit" id="professor_reg" name="professor_reg" value="등록"">
                   	  	    <input type="reset" id="professor_del" name="professor_del" value="다시작성">
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
        <script type="text/javascript">
        
        	function valid(){
        		
        		var id = document.getElementById("id"); 
        		
        		if(id.value ==""){
        			alert("아이디를 입력해주세요");
        			
        			return false;
        		}
        		
				var name = document.getElementById("name"); 
        		
        		if(name.value ==""){
        			alert("이름을 입력해주세요");
        			
        			return false;
        		}
        			
				var tel = document.getElementById("tel"); 
        		
        		if(tel.value ==""){
        			alert("전화번호를 입력해주세요");
        			
        			return false;
        		}
        		
        		
				var ssn = document.getElementById("ssn"); 
        		
        		if(ssn.value ==""){
        			alert("주민등록번호를 입력해주세요");
        			
        			return false;
        		}
        		
				var email = document.getElementById("email"); 
        		
        		if(email.value ==""){
        			alert("이메일을 입력해주세요");
        			
        			return false;
        		}
        		
				var pwd = document.getElementById("pwd"); 
        		
        		if(pwd.value ==""){
        			alert("비밀번호를 입력해주세요");
        			
        			return false;
        		}
        		
        		return true;
        		
        		
        	}
        </script>
    </body>
</html>

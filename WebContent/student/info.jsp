<%@page import="homework.HomeWorkBoardDTO"%>
<%@page import="homework.HomeWorkBoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="grade.GradeVO"%>
<%@page import="java.util.List"%>
<%@page import="grade.GradeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%--  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  --%>
<!-- 이메일 기능 수정 필요 -->
<!-- 게시판 기능 일부 구현 -->
<% request.setCharacterEncoding("UTF-8"); %>
<%
			
	// CourseDAO 객체 생성
	GradeDAO gradeDAO = new GradeDAO();
	// courseVO를 담을 배열 생성
	List<GradeVO> list = null;
	//session객체에서 id값을 들고옴
	String id = (String)session.getAttribute("id");
	// CourseDAO의 getBoardList메소드를 통해 테이블목록을 가져와서 list배열에 저장	
	 list =  gradeDAO.getBoardList(id);
	
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
        <title>OO대학교 학사관리 시스템 - 학사정보</title>
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
					<jsp:include page="/inc/menu.jsp" />
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">학사정보</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">info</li>
                        </ol>
                        <div class="row">
                        	<p class="mb-0">
                        	<input type="text" value="<%=userName%>" id="userName" hidden="">
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec"> 
                   	           		<tr bgcolor="lightgrey" align="center">
                   	           			<td width=5%>교수명</td>
                   	           			<td width=5%>과목명</td>
                   	           			<td width=5%>전공</td>
                   	           			<td width=5%>학년</td>
                   	           			<td width=5%>점수</td> <!-- 교수가 매기는 점수에 따라 등급이 바뀌게끔 설정되어서 학점->점수로 변경했습니다 -->
                   	           			<td width=5%>등급</td>
                   	           			<td width=5%>강의평가</td>
                   	           			<td width=5%>이메일</td>
                   	           		</tr>
                   	           		<%
                   	           			GradeDAO gradecheck = new GradeDAO();
                   	           				
                   	           			for(GradeVO grade : list) {
                   	           				String professorName = grade.getProfessor();
                   	           				String lectureName = grade.getCname();
                   	           		
                   	           			boolean check = gradecheck.lectureCheck(userName, lectureName, professorName);
                   	           		%>
<%--                    	           		<input type="text" value="<%=check%>">  boolean값 올바르게 받아오는지 확인 완료--%>
                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
                   	           			<td width=5% name="professorName"><%=grade.getProfessor()%></td> <!-- 교수명 -->
                   	           			<td width=5% name="lectureName"><%=grade.getCname()%></td> <!-- 과목명 -->
                   	           			<td width=5% name="lectureDivide"><%=grade.getCompdiv()%></td> <!-- 전공 -->
                   	           			<td width=5%><%=grade.getCompyear()%></td> 
                   	           			<td width=5%><%=grade.getGrade()%></td>
                   	           			<td width=5%><%=grade.getRate()%></td>
                   	           			<%
                   	           				if(check == false){
                   	           			%>
                   	           			<td width=5%><input type="button" class="btn btn-primary me-md-3" id="lectureResister" name="lectureResister" value="강의평가"></input></td>
                   	           			<%
                   	           			}else{
                   	           			%>
                   	           			<td width=5% style="color: red">평가완료</td>
                   	           			<%
                   	           			}
                   	           			%>
                   	           			<td width=5%><input type="button" class="btn btn-primary me-md-3" id="emailBtn" name="emailBtn" value="이메일보내기"></input></td>
                   	           		</tr>
                   	           		
                   	           		<% 
                   	           		}
                   	           		%>
                   	           </table>
                            </p>
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
        	$(document).on('click','#emailBtn',function(){
      		
			var professorName = $(this).closest("tr").find("td[name='professorName']").text();
			var userName = $("#userName").val();
			 //alert(userName);	
			// 교수 이름이 올바르게 넘어옴      		
        	
        	jQuery.ajaxSettings.traditional = true;
			$.ajax({
				
				url : "EmailSendSub.jsp", //요청할 서버페이지 경로 
				type : "post", //전송요청방식 GET 또는 POST중에 하나
				data : {"professorName":professorName},
				success : function(data){//EmailSendSub.jsp서버페이지 요청에 성공하면 data매개변수로 요청한 교수이름에 해당하는 이메일을  받는다
 					window.open('EmailSendMain.jsp?data='+data + '&userName='+ userName ,'_blank','width=500,height=400'); // ajax통신 성공 함
					//alert(data);
 					//result = data;
					
 				},
				error : function(data){
		           alert("망");
		        }
			});
		});	
        	//강의 평가 버튼을 눌렀을때 동작할 이벤트
        	$(document).on('click','#lectureResister',function(){
        		var userName = $("#userName").val();
        		var professorName = $(this).closest("tr").find("td[name='professorName']").text();
        		var lectureName = $(this).closest("tr").find("td[name='lectureName']").text();
//         		console.log("교수이름 = "+professorName);
//         		console.log("과목이름 = "+lectureName);
// 				alert(userName); 
          		//클릭한 교수이름 과목이름 학생이름 모두 들고옴
          		//여기까지는 됨 
        		window.open('../lectureBoard/lectureResister.jsp?professorName=' + professorName +'&lectureName=' + lectureName + '&userName=' + userName,'_blank','width=500,height=720');
          		
          		
    		});   	
    
        
        </script>
        	
    </body>
</html>

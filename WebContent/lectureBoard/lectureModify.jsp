<%@page import="homework.HomeWorkBoardDTO"%>
<%@page import="homework.HomeWorkBoardDAO"%>
<%@page import="lectureBoard.LectureVO"%>
<%@page import="java.util.List"%>
<%@page import="lectureBoard.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>

<% request.setCharacterEncoding("UTF-8"); %>
<%
	//세션 id값 가져오기
	String id = (String)session.getAttribute("id");

	//get방식으로 전송된 글번호값 가져오기
	String num = request.getParameter("num");
	//강의평가게시판의 <a>태그를 클릭했을때의 그 클릭한곳의 글번호를 올바르게 가져옴
	// DAO를 이용해서 강의평가 게시판 테이블에서 글번호에 맞는 
	
	// 강의명,			교수명,	학생이름,	수강년도,		수강학기,			
	// lecturename|professor|name| lectureYear| semesterDivide|    
	// 강의구분,			제목,		평가,		그리고 내용을 조회 해와야 됨/ 
	// lectureDivide |title |rate		|   mainText
	
	// 데이터베이스에서 조회해서 뿌려줄 역할을 할 DAO객체 생성
	LectureDAO lectureDAO = new LectureDAO();
	// LectureDAO의 getLectureModify메소드를 통해 테이블목록을 글번호에 해당하는 테이블을 가져옴
		LectureVO lecVO = lectureDAO.getLectureModify(num);
	
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
                  	 <jsp:include page="/inc/menu.jsp" />
                </nav>
            </div>
            <div id="layoutSidenav_content" style="background-color: white">
                <main>
                    <div class="position-relative">
              			
                        <div class="container">
                        	<div class="row justify-content-center">
                        	
                        	<form class="form-inline w-75" action="lectureModifyPro.jsp" method="post">
	                        <div class="input-group flex-nowrap mt-2 mb-2">
							  <span class="input-group-text" id="addon-wrapping">강의명</span>
							  <input type="text" id="LectureName" class="form-control" aria-describedby="addon-wrapping" name="lectureName" disabled="disabled" value="<%=lecVO.getLectureName()%>">
							</div>
							<div style="display: none">
                        	<input name="num" value="<%=num%>">
                        	</div>
							<div class="input-group flex-nowrap mt-3 mb-3">
							  <span class="input-group-text" id="addon-wrapping">교수명</span>
							  <input type="text" class="form-control" aria-describedby="addon-wrapping" name="professorName" disabled="disabled" value="<%=lecVO.getProfessorName()%>">
							</div>
						
							<div class="input-group flex-nowrap mt-3 mb-3">
							  <span class="input-group-text" id="addon-wrapping">학생이름</span>
							  <input type="text" class="form-control" aria-describedby="addon-wrapping" name="name" id="name" disabled="disabled" value="<%=lecVO.getName()%>">
							</div>
							<!-- 여기서부터 안보여줄거야 -->
							<span style="display: none" id="options">
							<div class="input-group mb-3">
							  <label class="input-group-text" for="inputGroupSelect01">수강년도</label>
							  <select class="form-select" id="inputGroupSelect01" name="lectureYear">
								   
								    <option value="2011" selected="selected">2011</option>
								    <option value="2012">2012</option>
								    <option value="2013">2013</option>
								    <option value="2014">2014</option>
								    <option value="2015">2015</option>
								    <option value="2016">2016</option>
								    <option value="2017">2017</option>
								    <option value="2018">2018</option>
								    <option value="2019">2019</option>
								    <option value="2020">2020</option>
								    <option value="2021">2021</option>
								    <option value="2022">2022</option>
								    <option value="2023">2023</option>
							   </select>
							</div>
							<div class="input-group mb-3">
								  <label class="input-group-text" for="inputGroupSelect01">수강학기</label>
								<select class="form-select" id="semesterDivide" name="semesterDivide" >
								    <option value="1학기" selected>1학기</option>
								    <option value="2학기">2학기</option>
							   </select>
							</div>
							<div class="input-group mb-3">
								  <label class="input-group-text" for="inputGroupSelect01">평가</label>
								<select class="form-select" id="rate"  name="rate">
								    <option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
							   </select>
							</div>
							<div class="input-group mb-3">
								  <label class="input-group-text" for="inputGroupSelect01">강의구분</label>
								<select class="form-select" id="lectureDivide" name="lectureDivide">
								    <option selected>전공필수</option>
								    <option value="전공선택">전공선택</option>
								    <option value="교양">교양</option>
							   </select>
							  </div>
							  </span>
							  <!-- 여기까지 안보여 줄거야 --> 
							 <div class="input-group flex-nowrap mt-3">
								  <span class="input-group-text">제목</span>
								  <input type="text" class="form-control" name="title" id="title" disabled="disabled" value="<%=lecVO.getTitle()%>">							</div>
							<div class="form-floating">
								  <textarea class="form-control" id="mainText" style="height: 100px" name="mainText" disabled="disabled"><%=lecVO.getMainText()%></textarea>
								  <label for="floatingTextarea2"></label>
							</div>
							<div class="col text-center" id="reflectedList" style="display: none">
								<input type="text" value="<%=userName%>" id="userName" hidden="">
								<input type="submit" class="btn btn-primary btn-sm" value="수정반영하기" id="reflected">
								<input type="button" class="btn btn-primary btn-sm" value="취소" id="cancel">
							</div>
							</form>
						</div>
						</div>
							<div class="col text-center" id="modifyList" style="display: block">
								<button class="btn btn-primary btn-sm" id="modify">수정하기</button>
								<button class="btn btn-primary btn-sm" id="backlist">리스트로돌아가기</button>
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
        //var a = $("#name").val()
        //alert(a);
        
        	//수정하기 버튼을 눌렀을때 수정신청할수 있게 화면이 바뀌게끔 이벤트 등록
        	$("#modify").on('click',function(){
        	if ($("#name").val() == $("#userName").val()) {
        		$("#modifyList").css("display","none");
				$("#reflectedList").css("display","block");
				$("#options").css("display","block");
				$("#title").attr("disabled",false);
				$("#mainText").attr("disabled",false);
        	}else {
				alert("본인이 작성한 글이 아닙니다.");
			}
        	});
        	
        	$("#cancel").on('click',function(){
        		$("#modifyList").css("display","block");
        		$("#reflectedList").css("display","none");
				$("#options").css("display","none");
				$("#title").attr("disabled",true);
				$("#mainText").attr("disabled",true);
        	})
        	
        	$("#backlist").on('click',function(){
        		location.href = "lectureNotice.jsp";
        	})
        </script>
    </body>
</html>

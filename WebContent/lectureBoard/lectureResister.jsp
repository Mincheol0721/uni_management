
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//요청한값 얻기
	String professorName =request.getParameter("professorName");
	String lectureName = request.getParameter("lectureName");
	String lectureDivide =request.getParameter("lectureDivide");
	String userName = request.getParameter("userName");
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
       <div class="container">
			<h2 class="text-center" id="modal" style="margin-top: 20px">평가 등록</h2>
		</div>
	
        <div id="layoutSidenav">
            
            <div id="layoutSidenav_content" style="background-color: white">
                <main>
                    <div class="position-relative">
              			
                        <div class="container">
                        	<div class="row justify-content-center">
                        	
                        	<form class="form-inline w-75" action="lecturePro.jsp" method="post">
	                        <div class="input-group flex-nowrap mt-2 mb-2">
							  <span class="input-group-text" id="addon-wrapping">강의명</span>
							  <input type="text" id="LectureName" class="form-control" aria-describedby="addon-wrapping" name="lectureName" readonly="readonly" value="<%=lectureName%>">
							</div>
							
							<div class="input-group flex-nowrap mt-3 mb-3">
							  <span class="input-group-text" id="addon-wrapping">교수명</span>
							  <input type="text" class="form-control" aria-describedby="addon-wrapping" name="professorName" readonly="readonly" value="<%=professorName%>">
							</div>
						
							<div class="input-group flex-nowrap mt-3 mb-3">
							  <span class="input-group-text" id="addon-wrapping">학생이름</span>
							  <input type="text" class="form-control" aria-describedby="addon-wrapping" name="name" id="name" readonly="readonly" value="<%=userName%>">
							</div>
							
							<span id="options">
							<div class="input-group mb-3">
							  <label class="input-group-text" for="inputGroupSelect01">수강 연도</label>
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
							 
							 <div class="input-group flex-nowrap mt-3">
								  <span class="input-group-text">제목</span>
								  <input type="text" class="form-control" name="title" id="title" required="required" value="" maxlength="10">							
							</div>
							<div class="form-floating">
								  <textarea class="form-control" id="mainText" style="height: 100px" name="mainText" required="required" maxlength="100"></textarea>
								  <label for="floatingTextarea2"></label>
							</div>
							<div class="col text-center" id="reflectedList">
								
								<input type="button" class="btn btn-primary btn-sm" value="취소" id="cancel" onclick="window.close()">
								<input type="submit" class="btn btn-primary btn-sm" value="등록하기" >
								
							</div>
							</form>
						</div>
						</div>
							
                    </div>
                    <jsp:include page="../inc/chat.jsp"></jsp:include>
                </main>
                
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
    	//제한글자 판독

        $('#title').keyup(function(){
            if ($(this).val().length > $(this).attr('maxlength')) {
                
                $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
            }
        });
        
        $('#mainText').keyup(function(){
            if ($(this).val().length > $(this).attr('maxlength')) {
                
                $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
            }
        });
        </script>
    </body>
</html>

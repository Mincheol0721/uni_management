
<%@page import="cHistory.CHistoryDAO"%>
<%@page import="cHistory.CHistoryVO"%>
<%@page import="course.CourseVO"%>
<%@page import="java.util.List"%>
<%@page import="course.CourseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<% 
//한글처리
request.setCharacterEncoding("UTF-8"); 

//path 얻기
String path = request.getContextPath();

// out.print(path);

%>

<%-- <jsp:useBean id="course" class="course.CourseVO"></jsp:useBean> --%>
<%-- <jsp:getProperty property="" name="course"/> --%>



<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 수강신청</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
		<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
		
		
		
    </head>
    <body class="sb-nav-fixed">
    <!-- 일정기간이 지나면 수강신청을 할수없도록 차단 -->
    <script>
    // 만료 날짜
    const expirationDate = new Date("2023-10-10");

    // 현재 날짜
    const now = new Date();

    // 만료 날짜가 지난 경우 접근을 막습니다.
    if (now > expirationDate) {
    	alert("수강신청 기간이 아닙니다.");
      location.href = '<%=path%>/index.jsp';
    }
  </script>
    <%			
    			//개설된 강의 목록
    			// CourseDAO 객체 생성
				CourseDAO courseDAO = new CourseDAO();
				
    			
    			
    			//세션아이디 값 가져오기
    			String id = (String)session.getAttribute("id");
				
    			//전체글 개수
    	    	int count = courseDAO.getBoardCount(id);
    	    	 //out.println(count);
    	    	 
    	    	 //하나의 화면 마다 보여줄 글개수 = 5
    	    	 int pageSize = 5;
    	    	 
    	    	 //---------------------------
    	    	 //현재 보여질(선택한) 페이지번호 가져오기.
    	    	 String pageNum = request.getParameter("pageNum");
    	    	 //현재보여질(선택한) 페이지번호가 없으면 1페이지 처리
    	    	 if(pageNum == null) {
    	    		 pageNum = "1";
    	    	 }
    	    	 /* 현재 보여질(선택한) 페이지 번호*/
    	    	 //현재보여질(선택한) 페이지번호 "1"을 -> 기본점수 1로 변경
    	    	 int currentPage = Integer.parseInt(pageNum);
    	    	 //------------------------------------------------
    	    	 
    	    	 /* 각페이지 마다 맨위에 첫번째로 보여질 시작 글번호 구하기*/
    	    	 //(현재 보여질 페이지번호 -1) * 한페이지당 보여줄 글개수 5
    	    	 int startRow = (currentPage-1)*pageSize;
    	    	 
    	    	 //게시판 글객체(LectureVO)를 저장하기 위한 용도
    	    	 List<CourseVO> list = null;
    	    	 
    	    	//만약 게시판에 글이 있다면..
    	    	 if(count > 0) {
    	    		// CourseDAO의 getBoardList메소드를 통해 테이블목록을 가져와서 list배열에 저장	
        			 list =  courseDAO.getBoardList(id,startRow,pageSize); 
    	    	 }
    			
 // ---------------------------------------------------------------------------------------    			
    			
				//수강신청한 강의 목록
    			//cHistoryDAO 객체 생성
    			CHistoryDAO cHistoryDAO = new CHistoryDAO();
    			// cHistoryVO를 담을 배열 생성
    			List<CourseVO> list2 = null;
    			// cHistoryDAO의 getBoardList메소드를 통해 테이블목록을 가져와서 List배열에 저장
    			list2 = cHistoryDAO.getBoardList(id); // 강의내역과 강의목록을 테이블을 join해서 배열에 담아 저장함
				
				
	%>
		
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
                        <h1 class="mt-4">수강신청</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">lecture</li>
                        </ol>
                        
                        
                        <div class="row">
                        	
                        	<p class="mb-0">
                        	
                        	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
  								<input class="btn btn-primary me-md-2" type="button" id="selectBtn" value="수강신청" name="btn">
  							</div>
  									
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec"> 
<%--                    	           		<%out.print(path); %> --%>
                   	           		<tr bgcolor="lightgrey" align="center">
                   	           			<td width=5%>과목코드</td>
                   	           			<td width=5%>과목명</td>
                   	           			<td width=5%>전공</td>
                   	           			<td width=5%>학년</td>
                   	           			<td width=5%>학기</td>
                   	           			<td width=5%>획득학점</td>
                   	           			<td width=5%>담당교수</td>
                   	           			<td width=5%>강의 시작 교시</td>
                   	           			<td width=5%>강의 끝 교시</td>
                   	           			<td width=5%>수강신청</td>
                   	           		</tr>
                   	           		<!-- Db에서 값을 가져올곳 -->
						<%
									
								if(count > 0) {	
								for(CourseVO course : list){
						%>           
						        	           		
                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;" class="course">
                   	           			<td width="5%" name="Ccode"><%=course.getCcode()%></td>
                   	        			<td width=5% name="Cname" id="Cname"><%=course.getCname()%></td> <!-- 과목명 -->
                   	           			<td width=5%><%=course.getCompdiv()%></td> <!-- 전필 전선 교필 교선 -->
                   	           			<td width=5%><%=course.getCompyear()%></td> <!-- 학년 -->
                   	           			<td width=5%><%=course.getCompsem()%></td> <!-- 학기 -->
                   	           			<td width=5%><%=course.getGrade()%></td> <!-- 획득학점 -->
                   	           			<td width=5%><%=course.getProfessor()%></td> <!-- 담당교수 -->
                   	           			<td width=5%><%=course.getStartTime()%></td> <!-- 강의 시작 교시 -->
                   	           			<td width=5%><%=course.getEndTime()%></td>
                   	           		<td width="5%" id="menu2"><input type="checkbox" name="user_CheckBox1" class="user_CheckBox1" value="1"></td>
									</tr>
                   	       <%
                   	        }
								}
                   	        %> 
                   	        
							</table>
							<ul class="pagination">
							<%
							
                        	if(count>0) {
                        		//전체 페이지수 구하기 글 20개 한페이지 보여줄 글수 10개 => 2페이지
                        		//				글 25개 한페이지 보여줄 글수 10개 => 3페이지
                        		//				조건(삼항)연산자 조건?참!거짓
                        		//전체 페이지수 = 전체글 / 한페이지에 보여줄 글수 + (전체글수를 한페이지에 보여줄 글수로 나눈 나머지값)
                        		int pageCount = count/pageSize + (count%pageSize == 0 ? 0:1);
                        		//한 화면(한블럭)에 보여줄 페이지수 설정
                        		int pageBlock = 1;
                        		
                        		/* 시작페이지 번호 구하기*/
                        		//1~10 =>1 11 ~ 20 => 11 21~30 => 21
                        		//((현재보여질(선택한)페이지 번호 / 한화면(한블럭)에 보여줄 페이지수))
                        		//(현재 보여질(선택한) 페이지 번호를 한화면에 보여줄 페이지수로 나눈 나머지값)
                        		//한화면(한블럭)에 보여줄 페이지수 +1
                        		int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock==0?1:0))*pageBlock+1;
                        		
                        		//끝페이지 번호 구하기 1~10 => 10 11~20 21~30 => 30
                        		int endPage = startPage+pageBlock-1; // 시작페이지번호 + 현재블럭에 보여줄 페이지수 -1
                        		//끝페이지번호가 전체페이지수보다 클때...
                        		if(endPage > pageCount) {
                        			//끝페이지번호를 전체페이지수로 저장
                        			endPage = pageCount;
                        		}
                        		//[이전] 시작페이지 번호가 한화면에 보여줄 페이지수 보다 클때...
                        		if(startPage > pageBlock) {
                        			%><li class="page-item active"><a href="lecture.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a></li>&nbsp;&nbsp;&nbsp;<%
                        		}
                        		//[1][2][3][4]...[10]
                        		for(int i=startPage; i<=endPage; i++) {
                        			%><li class="page-item active"><a href="lecture.jsp?pageNum=<%=i%>" id="a" >[<%=i%>]</a></li>&nbsp;&nbsp;&nbsp;<%
                        		}
                        		//[다음] 끝페이지 번호가 전체페이지수 보다 작을때..
                        		if(endPage < pageCount) {
                        			%><li class="page-item active"><a href="lecture.jsp?pageNum=<%=startPage+pageBlock%>" id="b">[다음]</a></li>&nbsp;&nbsp;&nbsp;<%
                        		}
                        	}
                        %>
						</ul>	
						
							
							<table style="border-collapse: collapse; border-color: lightgrey;"> 
                   	           	
                   	           		<h4 class="mt-4">수강내역</h4>
                   	           		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
  										<input class="btn btn-primary me-md-3" type="button" id="selectBtn2" value="수강취소" name="btn2">
  									</div>	
                   	           		<tr bgcolor="lightgrey" align="center">
                   	           			<td width=5%>과목코드</td>
                   	           			<td width=5%>과목명</td>
                   	           			<td width=5%>전공</td>
                   	           			<td width=5%>학년</td>
                   	           			<td width=5%>학기</td>
                   	           			<td width=5%>획득학점</td>
                   	           			<td width=5%>담당교수</td>
                   	           			<td width=5%>수강취소</td>
                   	           		</tr>
                   	           	<%
                   	           		//강의와 수강내역을 서로 join해서 보여주자
                   	           			for(CourseVO cHistory : list2) {
                   	           	%>	
                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;" class="cHistory">
                   	           			<td width="5%" name="Ccode2"><%=cHistory.getCcode()%></td>
                   	           			<td width=5% id="getCname"><%=cHistory.getCname()%></td> <!-- 과목명 -->
                   	           			<td width=5%><%=cHistory.getCompdiv()%></td> <!-- 전필 전선 교필 교선 -->
                   	           			<td width=5%><%=cHistory.getCompyear()%></td> <!-- 학년 -->
                   	           			<td width=5%><%=cHistory.getCompsem()%></td> <!-- 학기 -->
                   	           			<td width=5%><%=cHistory.getGrade()%></td> <!-- 획득학점 -->
                   	           			<td width=5%><%=cHistory.getProfessor()%></td> <!-- 담당교수 -->
                   	           			<td width="5%" id="menu2"><input type="checkbox" name="user_CheckBox2" class="user_CheckBox2" value="1"></td>
									
									</tr>
									  
                   	           <%
                   	           	}
                   	         
                   	         	%>
                   	         	<table style="border-collapse: collapse; border-color: lightgrey; border-top: none;" id="addChistory"></table>       			 
                   	           </table>		
							
                            </p>
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
    	
    	$("#selectBtn").click(function(){
			//<button>태그가 클릭이 되면 (클릭 이벤트가 발생하면)  
			//lectureAdd.jsp 서버페이지로 가서 강의내역테이블에 insert 작업을 함
			var checkedCheckboxes = $("input[name='user_CheckBox1']:checked");
			var Ccodes = []; // 체크한 과목코드의 값들을 배열로 저장할 변수
			
			
			
			checkedCheckboxes.each(function() {
			  var checkbox = $(this);
			  var tr = checkbox.closest("tr");
			  var td = tr.find("td[name='Ccode']");
			  Ccode = td.text();
			  Ccodes.push(Ccode); //과목코드의 값을 Ccodes 배열에 집어 넣기
			  // Ccode 값 처리
			});
			// 체크가 되어있는 값의 과목코드를 배열로 가져오는데 성공
			// {'10001','10002','10003'}
			console.log(Ccodes);
			
			jQuery.ajaxSettings.traditional = true;
			$.ajax({
				
				url : "lectureAdd.jsp", //요청할 서버페이지 경로 
				type : "post", //전송요청방식 GET 또는 POST중에 하나
				data : {"Ccodes":Ccodes},
				success : function(data){//lectureAdd.jsp서버페이지 요청에 성공하면 data매개변수로 요청한 메뉴목록을 받는다
					alert("수강신청 되셨습니다.");
					location.reload();
				},
				error : function(data){
		           alert("과목을 선택해 주세요");
		        }
			});					
		});	
    	
    	$("#selectBtn2").click(function(){
			//<button>태그가 클릭이 되면 (클릭 이벤트가 발생하면)  
			//lectureDelete.jsp 서버페이지로 가서 강의내역테이블에 delete 작업을 함
			var checkedCheckboxes2 = $("input[name='user_CheckBox2']:checked");
			var Ccodes2 = []; // 체크한 과목코드의 값들을 배열로 저장할 변수
			
			
			
			checkedCheckboxes2.each(function() {
			  var checkbox2 = $(this);
			  var tr2 = checkbox2.closest("tr");
			  var td2 = tr2.find("td[name='Ccode2']");
			  Ccode2 = td2.text();
			  Ccodes2.push(Ccode2); //과목코드의 값을 Ccodes 배열에 집어 넣기
			  // Ccode 값 처리
			});
			// 체크가 되어있는 값의 과목코드를 배열로 가져오는데 성공
			// {'10001','10002','10003'}
			//console.log(Ccodes);
			
			jQuery.ajaxSettings.traditional = true;
			$.ajax({
				
				url : "lectureDelete.jsp", //요청할 서버페이지 경로 
				type : "post", //전송요청방식 GET 또는 POST중에 하나
				data : {"Ccodes2":Ccodes2},
				success : function(data){//lectureAdd.jsp서버페이지 요청에 성공하면 data매개변수로 요청한 메뉴목록을 받는다
					alert("수강취소 되셨습니다.");
					location.reload();
				},
				error : function(data){
		           alert("과목을 선택해 주세요");
		        }
			});					
		});
    		
    	</script>
       	
      
    </body>
</html>
			
			
			
			

                  
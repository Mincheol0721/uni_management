<%@page import="java.text.SimpleDateFormat"%>
<%@page import="lectureBoard.LectureVO"%>
<%@page import="java.util.List"%>
<%@page import="lectureBoard.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>

<% request.setCharacterEncoding("UTF-8"); %>
<%
	//세션 id값 가져오기
	String id = (String)session.getAttribute("id");

	String searchText = request.getParameter("searchText");
	
	String searchField = request.getParameter("searchField");
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
    <%
    	//DB작업할 DAO생성
    	LectureDAO lectureDAO = new LectureDAO();
    	
    	int count = 0;
    
    	if(searchText != null & searchText != "") {
    		count = lectureDAO.getSearchCount(searchField, searchText);
    	}else {
    		//전체글 개수
        	count = lectureDAO.getBoardCount();
        	 
    	}
    	//out.println(count);
    	
    	 
    	 //하나의 화면 마다 보여줄 글개수 = 5
    	 int pageSize = 5;
    	 
    	 //---------------------------
    	 //현재 보여질(선택한) 페이지번호 가져오기.
    	 String pageNum = request.getParameter("pageNum");
    	 
    	 String pageNum2 = request.getParameter("pageNum2");
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
    	 List<LectureVO> list = null;
    	 
    	 //만약 게시판에 글이 있다면..
    	 if(count > 0) {
    		 if(searchText != null & searchText != ""){
    		 
    		 //글목록 가져오기
    		 //getBoardList(각페이지 마다 맨위에 첫번째로 보여질 시작 글번호, 한페이지당 보여줄 글개수)
    		 list = lectureDAO.searchBoard(searchField, searchText,startRow,pageSize);
    		}else{
    		 list = lectureDAO.getBoardList(startRow,pageSize);
    		}
    	 }
    	 //날짜 포맷
    	 SimpleDateFormat sdf = new SimpleDateFormat("yyy.MM.dd");
    %>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">OO대학교</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <jsp:include page="/inc/member.jsp" />
                </li>
            </ul>
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
                        <h1 class="mt-4">강의평가게시판</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">info</li>
                        </ol>
                        
	                       <%-- 검색창 --%>
	                       
	                       <table class="pull-right">
							<tr>
								<td>
									<select class="form-control" name="searchField">
									<option value="title">글제목</option>
									<option value="name">학생명</option>
									<option value="professorName">교수명</option>
									<option value="lectureName">강의명</option>
									</select></td>
								<td>
									<input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100" id="searchText"></td>
									<td><button type="button" class="btn btn-primary" id="searchBtn">검색</button></td>
									<td><a type="button" class="btn btn-primary" href="lectureNotice.jsp">목록으로</a></td>
							</tr>
						</table>
						
							<%-- 검색창 끝 --%>
					
                        <div class="row">
                        	
                        	<p class="mb-0">
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec"> 
                   	           		<tr bgcolor="lightgrey" align="center" id="menu_re">
                   	           			<td width=5% hidden="">글번호</td>
                   	           			<td width=5%>학생명</td>
                   	           			<td width=5%>글제목</td>
                   	           			<td width=5%>강의명</td>
                   	           			<td width=5%>교수명</td>
                   	           			<td width=5%>평가</td>
                   	           			<td width=5%>작성날짜</td>
                   	           		</tr>
                   	           		<span id="searchAddZone">
                   	           		</span>
                   	           		
                   	          <% 
                   	          	//만약 게시판글개수가 존재하고(게시판에 글이 있다면)
                   	          	if(count > 0) {
                   	          		for(int i=0; i <list.size(); i++) {
                   	          			LectureVO lec = list.get(i);
                   	          	%>
                   	          		
                   	          		<tr align="center" style="border-bottom: 1px, solid, lightgrey;" id="searchZone">
                   	           			<td width=5% hidden=""><%=lec.getNum()%></td>
                   	           			<td width=5%><%=lec.getName()%></td>
                   	           			<td width=5%><a href="lectureModify.jsp?num=<%=lec.getNum()%>" style="text-decoration: none"><%=lec.getTitle()%></a></td>
                   	           			<td width=5%><%=lec.getLectureName()%></td>
                   	           			<td width=5%><%=lec.getProfessorName()%></td>
                   	           			<td width=5%><%=lec.getRate()%></td>
                   	           			<td width=5%><%=sdf.format(lec.getDate())%></td>
                   	           		</tr>
                   	           		
                   	          	<%	
                   	          		}//for 끝 
                   	          	}else { //게시판이 글개수가 존재하지 않으면
                   	          %> 		
                   	           	<tr>
                   	           		<td colspan="7" align="center">게시판 글 없음</td>
                   	           	</tr>
                   	           	<%
                   	          	} // if ~ else의 끝
                   	         	%>
                   	           </table>
                            </p>
                        </div>                                   
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
                        			if(searchText != null & searchText != ""){
                        			%><a href="lectureNotice.jsp?pageNum=<%=startPage-pageBlock%>&searchText=<%=searchText%>&searchField=<%=searchField%>">[이전]</a><%
                        			}else {
                        			%><a href="lectureNotice.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a><%	
                        			}		
                        		}
                        		//[1][2][3][4]...[10]
                        		for(int i=startPage; i<=endPage; i++) {
                        			if(searchText != null & searchText != ""){
                        			%><a href="lectureNotice.jsp?pageNum=<%=i%>&searchText=<%=searchText%>&searchField=<%=searchField%>" id="a">[<%=i%>]</a><%
                        			}else {
                        			%><a href="lectureNotice.jsp?pageNum=<%=i%>" id="a">[<%=i%>]</a><%	
                        			}	
                        		}
                        		//[다음] 끝페이지 번호가 전체페이지수 보다 작을때..
                        		if(endPage < pageCount) {
                        			if(searchText != null & searchText != ""){
                        			%><a href="lectureNotice.jsp?pageNum=<%=startPage+pageBlock%>&searchText=<%=searchText%>&searchField=<%=searchField%>" id="b">[다음]</a><%	
                        			}else{
                        			%><a href="lectureNotice.jsp?pageNum=<%=startPage+pageBlock%>" id="b">[다음]</a><%	
                        			}
                        			
                        		}
                        	}
                        %>
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
        	$("#searchBtn").on('click',function(){
        		
        		var searchField = $("select").find("option:selected").val();
        		var searchText = $("#searchText").val();
        		if (searchText == "") {
					alert("검색어를 입력하지 않으셨습니다.");
					location.href();
				}
        		
        		
        		jQuery.ajaxSettings.traditional = true;
    			$.ajax({
    				
    				url : "searchLectureBBS.jsp", //요청할 서버페이지 경로 
    				type : "post", //전송요청방식 GET 또는 POST중에 하나
    				data : {"searchField":searchField,"searchText":searchText},
    				success : function(data){//lectureAdd.jsp서버페이지 요청에 성공하면 data매개변수로 요청한 메뉴목록을 받는다
    				
    					$("tr").filter('#searchZone').remove();
    					$("tr").filter('#menu_re').remove();
    					$("#a").remove();
    					$("#b").remove();
   					$("#searchAddZone").html(data);
    				},
    				error : function(data){
    		           alert("망");
    		        }
    			});					
        	});	
        </script>
        
    </body>
</html>

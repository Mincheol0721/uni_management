<%@page import="java.util.ArrayList"%>
<%@page import="courseList.MoreInfoBean"%>
<%@page import="courseList.MoreInfoDAO"%>
<%@page import="homework.HomeWorkBoardDTO"%>
<%@page import="homework.HomeWorkBoardDAO"%>
<%@page import="homework.HomeWorkDTO"%>
<%@page import="homework.HomeWorkDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="lectureBoard.LectureVO"%>
<%@page import="java.util.List"%>
<%@page import="lectureBoard.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<% request.setCharacterEncoding("UTF-8"); %>
<%
	//세션 id값 가져오기
	String id = (String)session.getAttribute("id");

	String cname = request.getParameter("cname");
	
	
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 세부강의</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <%
    	//DB작업할 DAO생성
    	MoreInfoDAO moreInfoDAO = new MoreInfoDAO();
    	
    	List<MoreInfoBean> list = null;
    
    	list = moreInfoDAO.getmoreList(cname);
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
					<jsp:include page="/inc/cPlanMenu.jsp" />
				</nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">세부 강의</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">homework</li>
                        </ol>
                       
	                       
					
                        <div class="row">
                        	
                        	<p class="mb-0">
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec"> 
                   	           		<tr bgcolor="lightgrey" align="center" id="menu_re">
                   	           			
                   	           			<td width=5% hidden="">과목명</td>
                   	           			<td width=5%>주차</td>
                   	           			<td width=5%>차시</td>
                   	           			<td width=5%>강의 주제</td>
                   	           			<td width=5%>강의 방식</td>
                   	           			<td width=5%>시작 교시</td>
                   	           			<td width=5%>끝날 교시</td>
                   	           		</tr>
                   	           		
                   	         <%
									
									for(MoreInfoBean moreinfo : list){
						%>           
						        	           		
                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;" class="course">
                   	           			<td width=5%><%=moreinfo.getWeek()%></td>
                   	           			<td width=5%><%=moreinfo.getSession()%></td>
                   	           			<td width=5%><%=moreinfo.getTopic()%></td>
                   	           			<td width=5%><%=moreinfo.getWay()%></td>
                   	           			<td width=5%><%=moreinfo.getStarttime()%></td>
                   	           			<td width=5%><%=moreinfo.getEndtime()%></td>
                   	           		
									</tr>
                   	       <%
                   	        }
							
                   	        %> 
                   	          
                   	          		
                   	           	
                   	           
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

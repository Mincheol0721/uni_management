<%@page import="courseList.CoursePlanBean"%>
<%@page import="courseList.CoursePlanDAO"%>
<%@page import="courseList.MoreInfoBean"%>
<%@page import="courseList.MoreInfoDAO"%>
<%@page import="courseList.CourseBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<c:set  var="contextPath"  value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 세부 강의 리스트</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
   		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script> 
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">      
    </head>    
    <body class="sb-nav-fixed">    
        	<%
				//한글처리
				request.setCharacterEncoding("UTF-8");
    			
        		MoreInfoBean bean = new MoreInfoBean();
        		
        		String cname = request.getParameter("cname");
        	
			%>	
			
			<jsp:useBean id="moreInfoDAO" class="courseList.MoreInfoDAO"/>		
								
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
                	<form action="addMoreInfoPro.jsp">              	
                	<input type="hidden" name="cname" value="<%=cname%>">             	     
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">세부 강의 추가</h1>
                        <ol class="breadcrumb mb-4">                     	   
                            <li class="breadcrumb-item active">addMoreInfo</li>                        
                        </ol>
                        <div class="row">
                        	<p class="mb-0">    		
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="table table-striped"> 
                   	           		<thead>
	                   	           		<tr bgcolor="lightgrey" align="center">
	                   	           			<th width=3%>주차</td>
	                   	           			<th width=3%>차시</td>                   	           			
	                   	           			<th width=6%>강의주제</td>
	                   	           			<th width=5%>강의방식</td>
	                   	           			<th width=5%>강의시간</td>
	                   	           			<th width=5%>과제</td>	
	                   	           			<th width=5%></td>	                   	           			           			                     	           			               	           			
	                   	           		</tr>
                   	           		</thead>  		
                  	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">          	           									         	           				
								        <td width="3%"><input type="text" name="week"/></td>
								        <td width="3%"><input type="text" name="ses"/></td>
								        <td width="6%"><input type="text" name="topic"/></td>
								        <td width="5%">
									        <div class="form-check">
											    <input class="form-check-input" type="radio" name="way" id="online" value="온라인" checked>
											    <label class="form-check-label" for="online">온라인</label>
											</div>
											<div class="form-check">
											    <input class="form-check-input" type="radio" name="way" id="offline" value="오프라인">
											    <label class="form-check-label" for="offline">오프라인</label>
											</div>
											<div class="form-check">
											    <input class="form-check-input" type="radio" name="way" id="hybrid" value="혼합">
											    <label class="form-check-label" for="hybrid">혼합</label>
											</div>
								        </td>							        
								        <td width="10%">
								        <select name="day">
										    <option value="월요일">월요일</option>
										    <option value="화요일">화요일</option>
										    <option value="수요일">수요일</option>
										    <option value="목요일">목요일</option>
										    <option value="금요일">금요일</option>
										</select>
											
										<select name="starttime">
										    <option value="1">1</option>
										    <option value="2">2</option>
										    <option value="3">3</option>
										    <option value="4">4</option>
										    <option value="5">5</option>
										    <option value="6">6</option>
										    <option value="7">7</option>							   
										</select>
										<label>교시 -	</label>							
										<select name="endtime">
										   	<option value="2">2</option>
										    <option value="3">3</option>
										    <option value="4">4</option>
										    <option value="5">5</option>
										    <option value="6">6</option>
										    <option value="7">7</option>
										    <option value="8">8</option>
										</select>
										<label>교시</label>
								        </td>
								        <td width="5%"><input type="text" name="homework"/></td>
								        <td width="5%"><input type="submit" value="추가" class="btn1"></td>
								    </tr>  	           										           										           		                 	           		
                   	           </table>
                            </p>
                        </div>
                    </div>
                    </form>
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
        
        <!-- 선택한 시작 교시에 따라 끝나는 교시가 바뀌게 하는 switch문 -->
        <script type="text/javascript">
	        
	        var startTime;
	        var endTime;
	        var str;
	        
        	$("select[name='starttime']").change(function(){
        		
        		startTime = $("select[name=starttime]").val();        		
        		endTime = $("select[name=endtime]");
        		
        		switch (startTime) {
        		
					case '2':
	 					$("select[name=endtime]").empty();
						str = '<option value="3" <%if(bean.getEndtime() == 3){ %>selected<% }%>>3</option>' +
					    	  '<option value="4" <%if(bean.getEndtime() == 4){ %>selected<% }%>>4</option>' +
					    	  '<option value="5" <%if(bean.getEndtime() == 5){ %>selected<% }%>>5</option>' +
					    	  '<option value="6" <%if(bean.getEndtime() == 6){ %>selected<% }%>>6</option>' +
					    	  '<option value="7" <%if(bean.getEndtime() == 7){ %>selected<% }%>>7</option>' +
					    	  '<option value="8" <%if(bean.getEndtime() == 8){ %>selected<% }%>>8</option>';
	 				    endTime.html(str);
						
					    break;
	    
					case '3':
	 					$("select[name=endtime]").empty();
						str = '<option value="4" <%if(bean.getEndtime() == 4){ %>selected<% }%>>4</option>' +
				    		  '<option value="5" <%if(bean.getEndtime() == 5){ %>selected<% }%>>5</option>' +
				    		  '<option value="6" <%if(bean.getEndtime() == 6){ %>selected<% }%>>6</option>' +
				    		  '<option value="7" <%if(bean.getEndtime() == 7){ %>selected<% }%>>7</option>' +
				    		  '<option value="8" <%if(bean.getEndtime() == 8){ %>selected<% }%>>8</option>';
	 				    endTime.html(str);
	 				    
	 				    break;
				
					case '4':
						$("select[name=endtime]").empty();
						str = '<option value="5" <%if(bean.getEndtime() == 5){ %>selected<% }%>>5</option>' +
				    		  '<option value="6" <%if(bean.getEndtime() == 6){ %>selected<% }%>>6</option>' +
				    		  '<option value="7" <%if(bean.getEndtime() == 7){ %>selected<% }%>>7</option>' +
				    		  '<option value="8" <%if(bean.getEndtime() == 8){ %>selected<% }%>>8</option>';
	 				    endTime.html(str);   
					    
	 				    break;
			
					case '5':
						$("select[name=endtime]").empty();
						str = '<option value="6" <%if(bean.getEndtime() == 6){ %>selected<% }%>>6</option>' +
				    		  '<option value="7" <%if(bean.getEndtime() == 7){ %>selected<% }%>>7</option>' +
				    		  '<option value="8" <%if(bean.getEndtime() == 8){ %>selected<% }%>>8</option>';
	 				    endTime.html(str);   
					    
	 				    break;
	 				    
					case '6':
						$("select[name=endtime]").empty();
						str = '<option value="7" <%if(bean.getEndtime() == 7){ %>selected<% }%>>7</option>' +
				    		  '<option value="8" <%if(bean.getEndtime() == 8){ %>selected<% }%>>8</option>';
	 				    endTime.html(str);   
					    
	 				    break;
	 				    
					case '7':
						$("select[name=endtime]").empty();
						str = '<option value="8" <%if(bean.getEndtime() == 8){ %>selected<% }%>>8</option>';
	 				    endTime.html(str);   
					    
	 				    break;

					default:
						break;
				}
        		
        	});     
        </script>     
        
    </body>
</html>

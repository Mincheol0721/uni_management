<%@page import="schedule.ScheduleDAO"%>
<%@page import="java.util.List"%>
<%@page import="schedule.ScheduleDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%

request.setCharacterEncoding("UTF-8");

Calendar cal = Calendar.getInstance();

 

String strYear = request.getParameter("year"); 

String strMonth = request.getParameter("month");

String job = (String)session.getAttribute("job");
 

int year = cal.get(Calendar.YEAR);

int month = cal.get(Calendar.MONTH);

int date = cal.get(Calendar.DATE);

 

if(strYear != null)

{

  year = Integer.parseInt(strYear);

  month = Integer.parseInt(strMonth);

 

}else{

 

}

//년도/월 셋팅

cal.set(year, month, 1);

 

int startDay = cal.getMinimum(java.util.Calendar.DATE);

int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);

int start = cal.get(java.util.Calendar.DAY_OF_WEEK);

int newLine = 0;

 

//오늘 날짜 저장.

Calendar todayCal = Calendar.getInstance();

SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");

int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));

//DAO객체 생성
ScheduleDAO dao = new ScheduleDAO();
ScheduleDTO dto = new ScheduleDTO();
List<ScheduleDTO> list = dao.getScheduleList();

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 일정</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript">
        	$(function() {
				var $job = '<%=job%>';
				
				if($job != '교직원') {
					$('#calTd').removeAttr('onclick');
				}
			});
        </script>
    </head>
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
	           		<%--사이드바--%>
	                <jsp:include page="/inc/menu.jsp" />
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                     <div class="container-fluid px-4">
                        <h1 class="mt-4">학사일정</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Schedule</li>
                        </ol>
                        <div class="row">
						<!-- Pie Chart -->
                        <div class="col-xl-6">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h4 class="m-0 font-weight-bold text-primary">학사 캘린더</h4>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                	<form name="calendarFrm" id="calendarFrm" action="" method="post">
										<DIV id="content" style="width:99%;">
										<table width="100%" border="0" cellspacing="1" cellpadding="1">
											<tr>
										       <td align ="right">
										             <input type="button" onclick="javascript:location.href='<c:url value='/index.jsp' />'" value="오늘"/>
										       </td>
											</tr>
										</table>

										<!--날짜 네비게이션  -->
										<table width="100%" border="0" cellspacing="1" cellpadding="1" id="KOO" bgcolor="#F3F9D7" style="border:1px solid #CED99C">
											<tr>
												<td height="60">
										
										       <table width="100%" border="0" cellspacing="0" cellpadding="0">
											       <tr>
										             <td height="10">
										             </td>
										       </tr>
										
										       <tr>
										             <td align="center" >
										                    <a href="<c:url value='/schedule.jsp' />?year=<%=year-1%>&amp;month=<%=month%>" target="_self">
										                           <b>&lt;&lt;</b><!-- 이전해 -->
										                    </a>
										                    <%if(month > 0 ){ %>
										                    <a href="<c:url value='/schedule.jsp' />?year=<%=year%>&amp;month=<%=month-1%>" target="_self">
										                           <b>&lt;</b><!-- 이전달 -->
										                    </a>
										                    <%} else {%>
										                           <b>&lt;</b>
										                    <%} %>
										                    &nbsp;&nbsp;
										                    <%=year%>년
										                    <%=month+1%>월
										                    &nbsp;&nbsp;
										                    <%if(month < 11 ){ %> 
										                    <a href="<c:url value='/schedule.jsp' />?year=<%=year%>&amp;month=<%=month+1%>" target="_self">
										                           <!-- 다음달 --><b>&gt;</b>
										                    </a>
										                    <%}else{%>
										                           <b>&gt;</b>
										                    <%} %>
										                    <a href="<c:url value='/schedule.jsp' />?year=<%=year+1%>&amp;month=<%=month%>" target="_self">
										                           <!-- 다음해 --><b>&gt;&gt;</b>
										                    </a>
										             </td>
										       </tr>
										       </table>
										</td>
										</tr>
										</table>
										<br>
										<table border="0" cellspacing="1" cellpadding="1" bgcolor="#FFFFFF">
										<THEAD>
										<TR bgcolor="#CECECE">
									       <TD width="2%">
										       <DIV align="center"><font color="red">일</font></DIV>
									       </TD>
									       <TD width="2%">
										       <DIV align="center">월</DIV>
									       </TD>
									       <TD width="2%">
										       <DIV align="center">화</DIV>
									       </TD>
									       <TD width="2%">
										       <DIV align="center">수</DIV>
									       </TD>
									       <TD width="2%">
										       <DIV align="center">목</DIV>
									       </TD>
									       <TD width="2%">
										       <DIV align="center">금</DIV>
									       </TD>
									       <TD width="2%">
										       <DIV align="center"><font color="#529dbc">토</font></DIV>
									       </TD>
										</TR>
										</THEAD>
										<TBODY>
										<TR>
<%
										//처음 빈공란 표시
										for(int index = 1; index < start ; index++ )
										{
										  out.println("<TD >&nbsp;</TD>");
										  newLine++;
										}
										for(int index = 1; index <= endDay; index++)
										{
										       String color = "";
										       if(newLine == 0){          color = "RED";
										       }else if(newLine == 6){    color = "#529dbc";
										       }else{                     color = "BLACK"; };
										       String sUseDate = Integer.toString(year); 
										       sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);
										       sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);
										       int iUseDate = Integer.parseInt(sUseDate);
										       String backColor = "#EFEFEF";
										       if(iUseDate == intToday ) {
										             backColor = "#c9c9c9";
										       }
										       out.println("<TD valign='top' align='left' height='92px' bgcolor='"+backColor+"' id='calTd' onclick=\"location.href='" 
	       												+ request.getContextPath() + "/schedule/newSchedule.jsp?date=" + index + "'\" nowrap>");
%>
										
										       <font color='<%=color%>'>
										             <%=index %>
										       </font>
<%
										       out.println("<BR>");
										       out.println("<font size=2>" + iUseDate + "</font>");
										       out.println("<BR>");
										       out.println("<font size=2><b>일정 입력</b></font>");
										       out.println("<BR>");
										       //기능 제거 
										       out.println("</TD>");
										       newLine++;
										       if(newLine == 7)
										       {
										         out.println("</TR>");
										         if(index <= endDay)
										         {
										           out.println("<TR>");
										         }
										         newLine=0;
										       }
										}
										//마지막 공란 LOOP
										while(newLine > 0 && newLine < 7)
										{
										  out.println("<TD>&nbsp;</TD>");
										  newLine++;
										}
%>
										</TR>
										</TBODY>
										</TABLE>
										</DIV>
										</form>
                                </div>
                            </div>
                    </div>
                    <div class="col-xl-6">
                        <div class="card shadow mb-4">
                            <!-- Card Header - Dropdown -->
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h4 class="m-0 font-weight-bold text-primary">일정 관리</h4>
                            </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                    <table id="datatablesSimple">
	                                    <thead>
		                   	           		<tr bgcolor="lightgrey" align="center">
		                   	           			<td width=10%>분류</td>
		                   	           			<td width=15%>날짜</td>
		                   	           			<td width=20%>일정</td>
		                   	           		</tr>
	                                    </thead>
	                                    <tbody id="scheduleList">
	                                    <%
	                                    for(int i=0; i<list.size(); i++) {
	                                    	dto = list.get(i);
	                                    %>
	                                    	<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td><%=dto.getSclass() %></td>
		                   	           			<td><%=dto.getSdate() %></td>
		                   	           			<td><%=dto.getTitle() %></td>
		                   	           		</tr>
	                                    <%	
	                                    }
	                                    %>
		                   	           	</tbody>
	                   	           	</table>
	                   	           	<br>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
						</div>
					 </div>
	              </div>
                </main>
            </div>
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
            
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>

<%@page import="schedule.ScheduleDTO"%>
<%@page import="schedule.ScheduleDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath }" />

<%

String job = (String)session.getAttribute("job");

Calendar cal = Calendar.getInstance();

 

String strYear = request.getParameter("year"); 

String strMonth = request.getParameter("month");

 

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

<c:set var="id" value="${sessionScope.id}" />
<c:set var="path" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="../js/scripts.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style TYPE="text/css">
            body {
            scrollbar-face-color: #F6F6F6;
            scrollbar-highlight-color: #bbbbbb;
            scrollbar-3dlight-color: #FFFFFF;
            scrollbar-shadow-color: #bbbbbb;
            scrollbar-darkshadow-color: #FFFFFF;
            scrollbar-track-color: #FFFFFF;
            scrollbar-arrow-color: #bbbbbb;
            margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";
            }
            td {font-family: "돋움"; font-size: 9pt; color:#595959;}
            th {font-family: "돋움"; font-size: 9pt; color:#000000;}
            select {font-family: "돋움"; font-size: 9pt; color:#595959;}
            .divDotText {
            overflow:hidden;
            text-overflow:ellipsis;
            }
            a {
        	text-decoration: none;
        	color: black;
	        }
	        a:hover {
	        	text-decoration: underline;
	        	color: black;
	        }
       </style>
       <script type="text/javascript">
        	$(function() {
				var $noticeTable = $("#noticeTable");
				var $path = '<%=request.getContextPath()%>';
				var $job = '<%=job%>';
				
				if($job == '학생' || $job == 'null') {
					$('.calTd').attr('onclick', 'location.href="'+$path+'/menu/schedule.jsp"');
				}
        		
        		$.ajax({
        			url : $path + '/board/index.do',
					type : 'POST',
					dataType : 'json',
			        contentType: "application/json; charset=utf-8;",
					success : function(data){
						$.each(data, function(index, dto) { 
							if(dto != null){
								$noticeTable.append("<tr align='center'><td> " + dto.nclass + " </td> <td><a href='" + $path 
														+ "/notice/viewNotice.jsp?no=" + dto.no + "'>" + dto.title + "</a></td> <td>" + dto.writeDate 
															+ "</td> <td>" + dto.readCount + "</td> </tr>");
							} else {
								$noticeTable.append("<tr align='center'><td colspan='4'> 등록된 글이 없습니다. </td></tr>");
							}
						}); 
					}
        		}); //ajax
        		
			});
        </script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <jsp:include page="/inc/logo.jsp" />
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
	           		<%--사이드바--%>
	                <jsp:include page="/inc/menu.jsp" />
                </nav>
            </div>
            <%--메인 페이지부분 --%>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">학사일정</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Schedule</li>
                        </ol>
                        <div class="row">

                        <!-- Area Chart -->
                        <div class="col-xl-8 col-lg-7">
                            <div class="card shadow mb-4">
                                <!-- 일정리스트  -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h4 class="m-0 font-weight-bold text-primary">일정 리스트</h4>
                                </div>
                                <!-- 일정리스트 내용 -->
                                <div class="card-body">
                                    <div class="chart-area"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                   	         		<table border="1"  style="border-collapse: collapse; border-color: lightgrey;" class="lec"> 
	                   	           		<tr bgcolor="lightgrey" align="center">
	                   	           			<td width=5%>분류</td>
	                   	           			<td width=10%>날짜</td>
	                   	           			<td width=15%>일정</td>
	                   	           		</tr>
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
	                   	           	</table>
                   	         		<span align="right"><small><a href="${path}/menu/schedule.jsp" style="text-decoration: none; color:black;">더보기...</a></small></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 달력부분 -->
                        <div class="col-xl-4 col-lg-5">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h4 class="m-0 font-weight-bold text-primary">일정</h4>
                                </div>
                                <!-- 달력부분 내용 -->
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
										                    <a href="<c:url value='/index.jsp' />?year=<%=year-1%>&amp;month=<%=month%>" target="_self">
										                           <b>&lt;&lt;</b><!-- 이전해 -->
										                    </a>
										                    <%if(month > 0 ){ %>
										                    <a href="<c:url value='/index.jsp' />?year=<%=year%>&amp;month=<%=month-1%>" target="_self">
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
										                    <a href="<c:url value='/index.jsp' />?year=<%=year%>&amp;month=<%=month+1%>" target="_self">
										                           <!-- 다음달 --><b>&gt;</b>
										                    </a>
										                    <%}else{%>
										                           <b>&gt;</b>
										                    <%} %>
										                    <a href="<c:url value='/index.jsp' />?year=<%=year+1%>&amp;month=<%=month%>" target="_self">
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
									       <TD width=5%>
										       <DIV align="center"><font color="red">일</font></DIV>
									       </TD>
									       <TD width=5%>
										       <DIV align="center">월</DIV>
									       </TD>
									       <TD width=5%>
										       <DIV align="center">화</DIV>
									       </TD>
									       <TD width=5%>
										       <DIV align="center">수</DIV>
									       </TD>
									       <TD width=5%>
										       <DIV align="center">목</DIV>
									       </TD>
									       <TD width=5%>
										       <DIV align="center">금</DIV>
									       </TD>
									       <TD width=5%>
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
										       out.println("<TD valign='top' align='left' height='92px' bgcolor='"+backColor+"' class='calTd' onclick=\"location.href='" 
	       												+ request.getContextPath() + "/menu/schedule.jsp'\">");
%>
										
										       <font color='<%=color%>'>
										             <%=index %>
										       </font>
<%
										       out.println("<BR>");
										       out.println(iUseDate);
										       out.println("<BR>");
										       //시작 연월일, 종료 연월일을 for문에서 입력받아 list에 저장
										       int i=0;
										       int sYear = 0,
										       	   sMonth = 0,
										       	   sDate = 0,
										       	   eYear = 0,
										       	   eMonth = 0,
										       	   eDate = 0;
										       List<String> scheduleDate = dao.getSdate();
										       
										       for(String s : scheduleDate) {
										       	s = scheduleDate.get(i);
										       	sYear = Integer.parseInt( s.substring(0, 4) );
										       	sMonth = Integer.parseInt( s.substring(5, 7) );
										       	sDate = Integer.parseInt( s.substring(8, 10));
										       	eYear = Integer.parseInt( s.substring(13, 17) );
										       	eMonth = Integer.parseInt( s.substring(18, 20) );
										       	eDate = Integer.parseInt( s.substring(21, 23) );
										       	
										       	dto = dao.getTitle(s);
										       	if( (year == sYear && (month+1) == sMonth && index == sDate) || (year == eYear && (month+1) == eMonth && index == eDate) ) {
										       		/* if(dao.getTitle(s).length() >= 5) {
									       				title = title.substring(0, 5);
									       				title += "...";
										       		} */
											       	out.println("<font size=0.8><b><span style='color: #0d6efd;'>" + dto.getTitle() + "</span></b></font><br>");
										       	} 
										       	
										       	
										       	i++;
										       }
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
                    </div>
                        <div class="row">
                        	<p class="mb-0">
                        	
                            </p>
                        </div>
                    </div>
                    
                    
                    
                     <%--bx슬라이더 쓰는 부분--%>
                   <h1>시설전경</h1>
                   <div class="bxslider">
					  <div><img src="assets/img/uni.jpg" width="100%"/></div>
					  <div><img src="assets/img/lib.jpg" width="100%" /></div>
					  <div><img src="assets/img/school.jpg" width="100%" /></div>
					</div>
					
					
                    <%--공지사항 --%>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">공지사항</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Notice</li>
                        </ol>
                        <div class="row">
                        	<p class="mb-0">
                   	           <table border="1"  style="border-collapse: collapse; border-color: lightgrey;" class="lec"> 
                   	           		<thead>
	                   	           		<tr bgcolor="lightgrey" align="center">
	                   	           			<td width=5%>분류</td>
	                   	           			<td width=15%>제목</td>
	                   	           			<td width=5%>작성일</td>
	                   	           			<td width=5%>조회수</td>
	                   	           		</tr>
                                   	</thead>
                                   	<tbody id="noticeTable"></tbody>
                   	           </table>
									<font align="right"><small><a href="${path}/menu/notice.jsp" style="text-decoration: none; color:black;">더보기...</a></small></font>
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
       
       
        <%-- bx슬라이더 부분 --%>	
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	    <script type="text/javascript">
	    $(function(){
	    	var slider = $('.bxslider').bxSlider({
	    		  mode: 'fade'
	    		});
	
	    		$('#slider-next').click(function(){
	    		  slider.goToNextSlide();
	    		  return false;
	    		});
	
	    		$('#slider-count').click(function(){
	    		  var count = slider.getSlideCount();
	    		  alert('Slide count: ' + count);
	    		  return false;
	    		});
	      });
	    
	    </script>
    </body>
</html>

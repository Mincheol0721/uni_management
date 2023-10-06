<%@page import="java.util.Date"%>
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
String id = (String)session.getAttribute("id");

int year = cal.get(Calendar.YEAR);

int month = cal.get(Calendar.MONTH);

int date = cal.get(Calendar.DATE);

// System.out.println("year: " + year);
// System.out.println("month: " + month);
// System.out.println("date: " + date);
 

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

SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");

int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));

//DAO객체 생성
ScheduleDAO dao = new ScheduleDAO();
ScheduleDTO dto = new ScheduleDTO();

//전체 글 개수
int count = dao.getBoardCount(year, (month+1));
//System.out.println("count: " + count);
//하나의 화면에 띄워줄 글 개수 10
int pageSize = 10;

//현재 보여질 페이지번호 가져오기
String pageNum = request.getParameter("pageNum");

//현재 보여질 페이지 번호가 없으면 1페이지 처리
if(pageNum == null) {
	pageNum = "1";
}
//System.out.println("pageNum: " + pageNum);

//현재 보여질 페이지 번호 "1"을 기본정수 1로 변환
int currentPage = Integer.parseInt(pageNum);
//System.out.println("currentPage: " + currentPage);

//각 페이지마다 맨 위에 보여질 시작 글번호 구하기
//(현재 보여질 페이지 번호 - 1) * 한페이지당 보여줄 글 개수
int startRow = (currentPage - 1) * pageSize;
//System.out.println("startRow: " + startRow);

// System.out.println("schedule.jsp id: " + dao.getTitle(dao.getSdate().get(3)).getId() );

// System.out.println("startYear: " + dao.getSdate().get(3).substring(0, 4));
// System.out.println("startMonth: " + dao.getSdate().get(3).substring(5, 7));
// System.out.println("startDate: " + dao.getSdate().get(3).substring(8, 10));
// System.out.println("endYear: " + dao.getSdate().get(3).substring(13, 17));
// System.out.println("endMonth: " + dao.getSdate().get(3).substring(18, 20));
// System.out.println("endDate: " + dao.getSdate().get(3).substring(21, 23));

//시작 연월일, 종료 연월일을 for문에서 입력받아 list에 저장
int j=0,
	sYear = 0,
	sMonth = 0,
	sDate = 0,
	eYear = 0,
	eMonth = 0,
	eDate = 0;
String chkId = null;
List<String> scheduleDate = dao.getSdate();

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
		<script src="../js/scripts.js"></script>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript">
        	$(function() {
        		var $job = '<%=job%>';
				var $td = $('.calTd');
				var $link = $('.calink');
				var $id = '<%=id%>';
				var $chkId = '<%=chkId%>';
				
				
				if($id == 'null' || $job == '학생') {
					$td.removeAttr('onclick');
					$('.calink').removeAttr('href');
					$('.calspan').css("cursor", "default");
				}  
				
			});
        </script>
        <style type="text/css">
        	a {
        	text-decoration: none;
        	}
        </style>
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
										             <input type="button" onclick="javascript:location.href='<c:url value='schedule.jsp' />'" value="오늘"/>
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
										                    <a href="<c:url value='/menu/schedule.jsp' />?year=<%=year-1%>&amp;month=<%=month+1%>" target="_self">
										                           <b>&lt;&lt;</b><!-- 이전해 -->
										                    </a>
										                    <%if(month > 0 ){ %>
										                    <a href="<c:url value='/menu/schedule.jsp' />?year=<%=year%>&amp;month=<%=month-1%>" target="_self">
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
										                    <a href="<c:url value='/menu/schedule.jsp' />?year=<%=year%>&amp;month=<%=month+1%>" target="_self">
										                           <!-- 다음달 --><b>&gt;</b>
										                    </a>
										                    <%}else{%>
										                           <b>&gt;</b>
										                    <%} %>
										                    <a href="<c:url value='/menu/schedule.jsp' />?year=<%=year+1%>&amp;month=<%=month%>" target="_self">
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
										       out.println("<TD valign='top' align='left' height='92px' bgcolor='"+backColor+"' class='calTd' onclick=\"location.href='" 
	       												+ request.getContextPath() + "/schedule/newSchedule.jsp?year=" + year + "&month=" + (month+1) 
	       												+ "&date=" + index + "'\" >");
%>
										
										       <font color='<%=color%>'>
										             <%=index %>
										       </font>
<%
										       out.println("<BR>");
										       out.println("<font size=2>" + iUseDate + "</font>");
										       out.println("<BR>");
											   //시작 연월일, 종료 연월일을 for문에서 입력받아 list에 저장
							    		       
											   j=0;
											   
							    		       for(String s : scheduleDate) {
							    		       	s = scheduleDate.get(j);
							    		       	sYear = Integer.parseInt( s.substring(0, 4) );
							    		       	sMonth = Integer.parseInt( s.substring(5, 7) );
							    		       	sDate = Integer.parseInt( s.substring(8, 10));
							    		       	if(s.length() > 11){
								    		       	eYear = Integer.parseInt( s.substring(13, 17) );
								    		       	eMonth = Integer.parseInt( s.substring(18, 20) );
								    		       	eDate = Integer.parseInt( s.substring(21, 23) );
							    		       	}
							    		       	dto = dao.getTitle(s);
							    		       	chkId = dao.idCheck(dto.getNo());
// 							    		       	System.out.println("title: " + dto.getTitle());
// 							    		       	System.out.println("chkId: " + dto.getId());
							    		       	if( (year == sYear && (month+1) == sMonth && index == sDate) || (year == eYear && (month+1) == eMonth && index == eDate) ) {
							    		       		
%>							    		       		
													<span style="color: #0d6efd; font-size: 0.8px;" class="calspan"><b>
														<a href="../schedule/modSchedule.jsp?year=<%=year%>&month=<%=(month + 1)%>&date=<%=date%>&no=<%=dto.getNo()%>" class="calink"> 
															<%=dto.getTitle()%></b>
														</a>
													</span><br> 
<%
								    		    } 
								    		       	
								    		       	j++;
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
		                   	           		<tr bgcolor="lightgrey" align="center" width="100%">
		                   	           			<td width=10%>분류</td>
		                   	           			<td width=15%>날짜</td>
		                   	           			<td width=20%>일정</td>
		                   	           			<td width=10%>D-DAY</td>
		                   	           		</tr>
	                                    </thead>
	                                    <tbody id="scheduleList">
	                                    <%
	                                    List<ScheduleDTO> list = dao.getScheduleList(startRow, pageSize, year, (month+1));
	                                    
	                                    Date dbDate = null;
	                                    Date today = sdf2.parse(sdf2.format(todayCal.getTime()));
	                                    int dday = 0;
	                                    
	                                    for(int i=0; i<list.size(); i++) {
	                                    	dto = list.get(i);
	                                    %>
	                                    	<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
		                   	           			<td><%=dto.getSclass() %></td>
		                   	           			<td><%=dto.getSdate() %></td>
		                   	           			<td><%=dto.getTitle() %></td>
                   	           			<%
		                   	           		if(dto.getSdate().length() > 11) {
		                   	           			dbDate = sdf2.parse( dto.getSdate().substring(13) );
		                   	           		} else {
		                   	           			dbDate = sdf2.parse( dto.getSdate().substring(0, 10) );
		                   	           		}
                   	           			
                   	           				dday = (int) ( (dbDate.getTime() - today.getTime()) / (1000 * 60 * 60 * 24) );
                   	           				
                   	           			%>
                   	           					<td>D-<%=dday %></td>
		                   	           		</tr>
	                                    <%	
	                                    }
	                                    %>
		                   	           	</tbody>
	                   	           	</table>
	                   	           	<br>
	                   	           	<div class="datatable-bottom">

										    <div class="datatable-info">
										    	전체 게시글: <%=count%>개
										    </div>
										    <nav>
												<ul class="pagination">
<%
										    	//전체 페이지 수 구하기
												//전체 페이지 수 = 전체 글 / 한페이지에 보여줄 글 수 + (전체 글 수를 한페이지에 보여줄 글수로 나눈 나머지 값)
												int pageCount = count / pageSize + (count%pageSize == 0 ? 0:1);
												//한 화면에 보여줄 페이지 수 설정
												int pageBlock = 5;
												
												//시작페이지 번호 구하기
												//( 현재 보여질 페이지 번호 / 한 블럭에 보여줄 페이지 수 ) - ( 현재 보여질 페이지 번호 % 한 화면에 보여줄 페이지수 == 0 ? 1:0 )
												// * 한 블럭에 보여줄 페이지 수 + 1
												int startPage = ( (currentPage / pageBlock) - (currentPage % pageBlock == 0 ? 1 : 0) ) * pageBlock + 1;
												
												//끝페이지 번호 구하기
												int endPage = startPage + pageBlock - 1;
												//끝 페이지 번호가 전체 페이지수보다 클 때
												if(endPage > pageCount) {
													endPage = pageCount;
												}
												/* 
												System.out.println("startPage: " + startPage);
												System.out.println("pageBlock: " + pageBlock);
												System.out.println("pageCount: " + pageCount);
												System.out.println("endPage: " + endPage);
												 */
												//[이전] 시작 페이지 번호가 한 화면에 보여줄 페이지수보다 클 때
												if(startPage > pageBlock) {
%>
													<li class="page-item">
										    			<a href="schedule.jsp?pageNum=<%=startPage - pageBlock%>&year=<%=year%>&month=<%=month%>" class="page-link">‹</a>
										    		</li>
<%
												}
												
												for(int i = startPage; i <= endPage; i++) {
													if(i == currentPage) {
%>											
										    			<li class="page-item active"><a href="schedule.jsp?pageNum=<%=currentPage%>&year=<%=year%>&month=<%=month%>" class="page-link"><%=currentPage %></a></li>
<%
													} else {
%>	
										    			<li class="page-item"><a href="schedule.jsp?pageNum=<%=i%>&year=<%=year%>&month=<%=month%>" class="page-link"><%=i %></a></li>
<%	
													}
												
												}
												//[다음] 끝페이지 번호가 전체 페이지수 보다 작을 때
												if(endPage < pageCount) {
%>													
													<li class="page-item">
										    			<a href="schedule.jsp?pageNum=<%=startPage + pageBlock%>&year=<%=year%>&month=<%=month%>" class="page-link">›</a>
										    		</li>
<%													
												}
												
%>
										    	</ul>
											</nav>
										</div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
						</div>
					 </div>
	              </div>
	              <jsp:include page="../inc/chat.jsp"></jsp:include>
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

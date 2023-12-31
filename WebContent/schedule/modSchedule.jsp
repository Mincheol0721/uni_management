<%@page import="schedule.ScheduleDAO"%>
<%@page import="schedule.ScheduleDTO"%>
<%@page import="java.util.Date"%>
<%@page import="notice.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	//한글처리
	request.setCharacterEncoding("UTF-8"); 
	
	//id, 직업 값 얻어오기
	String id = (String)session.getAttribute("id");
	String job = (String)session.getAttribute("job");
	String path = request.getContextPath();
	
	int year = Integer.parseInt( request.getParameter("year") );
	int month = Integer.parseInt( request.getParameter("month") );
	int date = Integer.parseInt( request.getParameter("date") );
	int no = Integer.parseInt( request.getParameter("no") );
//  	System.out.println("year: " + year);
//  	System.out.println("month: " + month);
//  	System.out.println("date: " + date);
 	
 	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
 	Date today = new Date();
 	String minDate = sdf.format(today);
 	
 	String clickDate = year + "-";
 	if(month < 10) {
 		clickDate += "0";
 	}
 	clickDate += month + "-";
 	if(date < 10) {
 		clickDate += "0";
 	}
 	clickDate += date + "";
 	System.out.println("clickDate: " + clickDate);
 	
	ScheduleDTO dto = new ScheduleDTO();
	ScheduleDAO dao = new ScheduleDAO();
	dto = dao.getSchedule(no);
// 	System.out.println("notice.jsp id: " + id);
// 	System.out.println("notice.jsp job: " + job);
	
	String startDate = dto.getSdate().substring(0, 10);
	System.out.println("modS startDate: " + startDate);
	String endDate = dto.getSdate();
	endDate = endDate.substring(13);
// 	System.out.println("modS endDate: " + endDate.substring(13));
	String content = dto.getContent();
	if(content == null) {
		content = "";
	}
	
	String chkId = dao.idCheck(no);

%>

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
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="../js/scripts.js"></script>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript">
        	$(function() {
        		var $id = '<%=id%>';
        		var $chkId = '<%=chkId%>';
        		var $job = '<%=job%>';
        		var $path = '<%=path%>';
				var $csel = $('select[id=clsSelc]');
				var $sdate = $('input[name=startDate]');
				var $edate = $('input[name=endDate]');
				var $minDate = '<%=minDate%>';
				
				
				
				if($id == 'null') {
					alert('관리자만 접근가능한 페이지입니다.');
					history.go(-1);
        		} else {
					if($id != $chkId) {
						alert('접근 권한이 없습니다.');
						history.go(-1);
					}
        		}
				
        		$.ajax({
        			url : '<%=request.getContextPath()%>/sched/selclass',
        			type : 'POST',
        			dataType : 'json',
        			success : function(data) {
        				if(data != null) $csel.empty();
						
        				$.each(data, function(i, dto) {
							$csel.append('<option value="' + dto.sclass + '" name="sclass"> ' + dto.sclass + ' </option>')
						});
        				
					}
        		});//대분류 셀렉트 옵션태그
        		
        		$edate.attr("min", '<%=clickDate%>');
        		
        		
			});
        </script>
        <style type="text/css">
	        .notice_title {
	       		font-size: 16px;
	       		font-weight: 400;
	       		align-items: center;
	       	}
	       	hr {
	       		width: 100%;
	       		align-items: center;
	       		color: grey;
	       	}
	       	.writeBtn {
		       	float: right;
	       		margin-left: 10px;
	       		border-radius: 10%;
	       	}
	       	input[type=text] {
	       		border: 1px solid lightgrey;
	       		width: 80%;
	       	}
	       	textarea {
	       		border: 1px solid lightgrey;
	       		width: 80%;
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
                        <div class="card mb-4">
                             <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                 <h4 class="m-0 font-weight-bold text-primary">학사일정</h4>
                             </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                    <form action="modSchedulePro.jsp?no=<%=no %>" method="post">
	                   	           		<div class="col-md-12">
											<div class="row">
											<input type="hidden" value="<%=id%>" name="id">
												<div class="col-md-2">
													<span class="notice_title">분류</span>
												</div>
												<div class="col-md-10">
													<select id="clsSelc" name="sclass" value="<%=dto.getSclass()%>"></select>
												</div>
												<br><br><hr>
												<div class="col-md-2">
													<span class="notice_title">제목</span>
												</div>
												<div class="col-md-10">
													<input type="text" class="notice" name="title" value="<%=dto.getTitle()%>">
												</div>
												<br><br><hr>
												<div class="col-md-2">
													<span class="notice_title">시작일</span>
												</div>
												<div class="col-md-4">
													<input type="date" class="notice" name="startDate" value="<%=startDate%>">
												</div>
												<div class="col-md-2">
													<span class="notice_title">종료일</span>
												</div>
												<div class="col-md-4">
													<input type="date" class="notice" name="endDate" value="<%=endDate %>">
												</div>
												<br><br><hr>
											</div>
										</div>
	                   	           		<input type="submit" value="수정완료"  class="writeBtn"> &nbsp;&nbsp;
	                   	           		<input type="button" value="삭제하기" class="writeBtn" 
	                   	           			   onclick="location.href='<%=request.getContextPath()%>/schedule/delSchedule.jsp?no=<%=no%>'"> &nbsp;&nbsp;
	                   	           		<input type="button" value="글목록" class="writeBtn" onclick="location.href='../menu/schedule.jsp'">
	                   	           	</form>
	                   	           	<br>
                                    </div>
                                </div>
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
    </body>
</html>

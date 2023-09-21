<%@page import="notice.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="path" value="${pageContext.request.contextPath}" />

<%
	//한글처리
	request.setCharacterEncoding("UTF-8"); 

	//id, 직업 값 얻어오기
	String id = (String)session.getAttribute("id");
	String job = (String)session.getAttribute("job");
	
// 	System.out.println("notice.jsp id: " + id);
// 	System.out.println("notice.jsp job: " + job);
	 
	NoticeDAO dao = new NoticeDAO();
	NoticeDTO dto = new NoticeDTO();
	List<NoticeDTO> list = null;
	
	//전체 글 개수
	int count = dao.getBoardCount();
// 	System.out.println("count: " + count);
	//하나의 화면에 띄워줄 글 개수 10
	int pageSize = 10;
	
	//현재 보여질 페이지번호 가져오기
	String pageNum = request.getParameter("pageNum");
	
	//현재 보여질 페이지 번호가 없으면 1페이지 처리
	if(pageNum == null) {
		pageNum = "1";
	}
// 	System.out.println("pageNum: " + pageNum);
	
	//현재 보여질 페이지 번호 "1"을 기본정수 1로 변환
	int currentPage = Integer.parseInt(pageNum);
// 	System.out.println("currentPage: " + currentPage);
	
	//각 페이지마다 맨 위에 보여질 시작 글번호 구하기
	//(현재 보여질 페이지 번호 - 1) * 한페이지당 보여줄 글 개수
	int startRow = (currentPage - 1) * pageSize;
// 	System.out.println("startRow: " + startRow);
	
	
	//날짜 포맷
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 공지</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="../js/scripts.js"></script>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript">
        	$(function() {
				var $noticeTable = $("#noticeTable");
        		var $startRow = <%=startRow%>;
        		var $pageSize = <%=pageSize%>;
        		var $path = '<%=request.getContextPath()%>';
        		var $pageNum = '<%=pageNum%>';
        		
//         		console.log("startRow: " + $startRow);
//         		console.log("pageSize: " + $pageSize);
// 				console.log("path: " + $path);
// 				console.log("pageNum: " + $pageNum);
				
				$.ajax({
           			url : '<%=request.getContextPath()%>/board',
   					type : 'POST',
   					data : {startRow:$startRow, pageSize:$pageSize},
   					dataType : 'json',
   					success : function(data){
						$noticeTable.empty();
						
   						$.each(data, function(index, dto) { 
   							if(dto != null){
   			     				
   								$noticeTable.append("<tr align='center'><td> " + (index + 1 + $startRow) + " </td> <td> " + dto.nclass + " </td> <td><a href='" + $path 
   														+ "/notice/viewNotice.jsp?no=" + dto.no + "'>" + dto.title + "</a></td> <td>" + dto.writeDate 
   															+ "</td> <td>" + dto.readCount + "</td> </tr>");
   							} else {
   								$noticeTable.append("<tr align='center'><td colspan='5'> 등록된 글이 없습니다. </td></tr>");
   							}
   						}); 
   					}
           		}); //공지사항 띄워주는 ajax
				
				
        		//검색 시 검색한 필드 및 텍스트값에 해당하는 게시글만 띄우기 위한 ajax
        		var $keyField = $('select[name=keyField]').val();
     			var $searchText = $('#searchText').val();
        		
     			$('select[name=keyField]').on("change", function() {
					$keyField = $('select[name=keyField]').val();
// 	  				console.log("keyField: " + $keyField);
				});
     			
     			$('#searchText').on("keyup", function() {
     				$searchText = $('#searchText').val();
     				
//       				console.log("keyfield: " + $keyField);
//       				console.log("searchText: " + $searchText);
//       				console.log("startRow: " + $startRow);
//       				console.log("pageSize: " + $pageSize);
      				
     				$.ajax({
	           			url : '<%=request.getContextPath()%>/board/search.do',
	   					type : 'POST',
	   					data : {keyField : $keyField, searchText : $searchText, startRow:$startRow, pageSize:$pageSize},
	   					dataType : 'json',
	   					success : function(data){
							$noticeTable.empty();
							
	   						$.each(data, function(index, dto) { 
	   							if(dto != null){
	   			     				
	   								$noticeTable.append("<tr align='center'><td> " + (index + 1 + $startRow) + " </td> <td> " + dto.nclass + " </td> <td><a href='" + $path 
	   														+ "/notice/viewNotice.jsp?no=" + dto.no + "'>" + dto.title + "</a></td> <td>" + dto.writeDate 
	   															+ "</td> <td>" + dto.readCount + "</td> </tr>");
	   							} else {
	   								$noticeTable.append("<tr align='center'><td colspan='5'> 등록된 글이 없습니다. </td></tr>");
	   							}
	   						}); 
	   					}
	           		}); //공지사항 띄워주는 ajax
	      			
	           		$('.pagination').on('click',function() {
						$searchText = $('#searchText').val();
// 						console.log('paging searchText: ' + $searchText);
						console.log('pagenum: ' + $pageNum);
						$.ajax({
							url : '<%=request.getContextPath()%>/board/paging.do',
		   					type : 'POST',
		   					data : {keyField : $keyField, searchText : $searchText, startRow:$startRow, pageSize:$pageSize, pageNum:$pageNum},
		   					dataType : 'json',
		   					success : function(data){
								$noticeTable.empty();
								$(this).preventDefault();
								
		   						$.each(data, function(index, dto) { 
		   							if(dto != null){
		   								$noticeTable.append("<tr align='center'><td> " + (index + 1 + $startRow) + " </td> <td> " + dto.nclass + " </td> <td><a href='" + $path 
		   														+ "/notice/viewNotice.jsp?no=" + dto.no + "'>" + dto.title + "</a></td> <td>" + dto.writeDate 
		   															+ "</td> <td>" + dto.readCount + "</td> </tr>");
		   							} else {
		   								$noticeTable.append("<tr align='center'><td colspan='5'> 등록된 글이 없습니다. </td></tr>");
		   							}
		   						}); 
		   					}
						});
						
					});
	           		
     			});
     			/* 
     			$('.active').on('change', function() {
     				if($(this).val() == $('.pagination>li>a').val()) {
						$(this).style.cssText = 'background-color: #0d6efd; color: white;'
     				}
					
				});
     			 */
     			
     			/* 
    			$(".pagination").on("click", function() {
					
    				alert("클릭함수 작동");
    				
    				
				});
				 */
    			
        		//교직원 및 교수만 공지작성 가능하게 input태그 숨김처리
        		var $id = '<%=id%>';
        		var $job = '<%=job%>';
        		var $input = $('#writeBtn');
        		
        		if($job == '학생' || $job == null) {
        			$input.hide();
        		} 
        		
			});
        </script>
        <style type="text/css">
        a {
        	text-decoration: none;
        	color: black;
        }
        a:hover {
        	text-decoration: underline;
        	color: black;
        }
        #searchArea {
        	margin-bottom: 10px;
        }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <jsp:include page="../inc/logo.jsp" />
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
                        <h1 class="mt-4">공지사항</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Notice</li>
                        </ol>
                        <div class="card mb-4">
							<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        		<h4 class="m-0 font-weight-bold text-primary">공지</h4>
								<a id="writeBtn" href="${path}/notice/notice_write.jsp"><input type="button" value="공지작성"></a>	
							</div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                    
                                    <div id="searchArea" align="right">
                                    	<select name="keyField">
                                    		<option name="nclass" value="nclass">분류</option>
                                    		<option name="title" value="title">제목</option>
                                    		<option name="content" value="content">내용</option>
                                    	</select>
                                    	<span>
		                                    <input type="text" name="searchText" style="width: 300px;" id="searchText">
		                                </span>
                                    </div>
                                    
                                    <table id="datatablesSimple">
	                                    <thead>
		                   	           		<tr bgcolor="lightgrey" align="center">
		                   	           			<td width="0.9%">글번호</td>
		                   	           			<td width=5%>분류</td>
		                   	           			<td width=15%>제목</td>
		                   	           			<td width=5%>작성일</td>
		                   	           			<td width=5%>조회수</td>
		                   	           		</tr>
	                                    </thead>
	                                    <tbody id="noticeTable"></tbody>
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
										    			<a href="notice.jsp?pageNum=<%=startPage - pageBlock%>" class="page-link">‹</a>
										    		</li>
<%
												}
												
												for(int i = startPage; i <= endPage; i++) {
													if(i == currentPage) {
%>											
										    			<li class="page-item active"><a href="notice.jsp?pageNum=<%=currentPage%>" class="page-link"><%=currentPage %></a></li>
<%
													} else {
%>	
										    			<li class="page-item"><a href="notice.jsp?pageNum=<%=i%>" class="page-link"><%=i %></a></li>
<%	
													}
												
												}
												//[다음] 끝페이지 번호가 전체 페이지수 보다 작을 때
												if(endPage < pageCount) {
%>													
													<li class="page-item">
										    			<a href="notice.jsp?pageNum=<%=startPage + pageBlock%>" class="page-link">›</a>
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


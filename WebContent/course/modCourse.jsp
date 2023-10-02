<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="board_course.BoardBean"%>
<%@page import="board_course.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<% request.setCharacterEncoding("UTF-8"); %>

<c:set var="id" value="${sessionScope.id}" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 과목추가</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="../js/scripts.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>        
    </head>
    	
    	<%
			//한글처리
			request.setCharacterEncoding("UTF-8");
             
	        BoardDAO dao = new BoardDAO();
		
			String ccode = request.getParameter("ccode");
			
			BoardBean bean = dao.getCourseInfo(Integer.parseInt(ccode));
			
			System.out.print("수정할 과목코드 : " + ccode);
	
   		%> 

   
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <jsp:include page="/inc/logo.jsp" />
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <jsp:include page="/inc/menu.jsp" />
                </nav>
            </div>
            
            <div id="layoutSidenav_content">          

                <main>
                	<form action="modCoursePro.jsp" method="POST"> 
                	<input type="hidden" id="ccode" name="ccode" value="<%=ccode%>"/>      	
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">과목수정</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">modCourse</li>
                        </ol>
                        <div class="row">
                        	<p class="mb-0">
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec" id="t"> 
                   	           		<tr bgcolor="lightgrey" align="center">
                   	           			<th width=5%>과목명</th>
                   	           			<th width=5%>이수구분</th>
                   	           			<th width=5%>이수학년</th>
                   	           			<th width=5%>이수학기</th>
                   	           			<th width=5%>학점</th>
                   	           			<th width=5%>강의시간</th>                  	           			
                   	           			<th width=5%>담당교수</th>
                   	           			<th width=2%></th>                  	           		                 	           			
                   	           		</tr>
                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">             	  
                   	           			<td width=5%><input type="text" name="cname" value="<%=bean.getCname()%>"/></td> 
                   	           			<td>   
									        <select name="compdiv">
									            <option value="전공필수" <%if(bean.getCompdiv().equals("전공필수")){ %>selected<% }%>>전공필수</option>
									            <option value="전공선택" <%if(bean.getCompdiv().equals("전공선택")){ %>selected<% }%>>전공선택</option>
									            <option value="교양" <%if(bean.getCompdiv().equals("교양")){ %>selected<% }%>>교양</option>                   	           					
									        </select>
									    </td>       	           			
									    <td width="5%">
									        <select name="compyear">
									            <option value="1" <%if(bean.getCompyear() == 1) { %>selected<% }%>>1학년</option>
									            <option value="2" <%if(bean.getCompyear() == 2) { %>selected<% }%>>2학년</option>
									            <option value="3" <%if(bean.getCompyear() == 3) { %>selected<% }%>>3학년</option> 
									            <option value="4" <%if(bean.getCompyear() == 4) { %>selected<% }%>>4학년</option>               	           					
									        </select>
									    </td>
									    <td width="5%">
									        <select name="compsem">
									            <option value="1" <%if(bean.getCompsem() == 1) { %>selected<% }%>>1학기</option>
									            <option value="2" <%if(bean.getCompsem() == 2) { %>selected<% }%>>2학기</option>                  	           					
									        </select>
									    </td>
									    <td width="5%">
									        <select name="grade">
									            <option value="1" <%if(bean.getGrade() == 1) { %>selected<% }%>>1학점</option>
									            <option value="2" <%if(bean.getGrade() == 2) { %>selected<% }%>>2학점</option>
									            <option value="3" <%if(bean.getGrade() == 3) { %>selected<% }%>>3학점</option>                   	           					
									        </select>
									    </td>
									    <td width="10%">
									        <select name="day">
											    <option value="월요일" <%if(bean.getDay().equals("월요일")){ %>selected<% }%>>월요일</option>
											    <option value="화요일" <%if(bean.getDay().equals("화요일")){ %>selected<% }%>>화요일</option>
											    <option value="수요일" <%if(bean.getDay().equals("수요일")){ %>selected<% }%>>수요일</option>
											    <option value="목요일" <%if(bean.getDay().equals("목요일")){ %>selected<% }%>>목요일</option>
											    <option value="금요일" <%if(bean.getDay().equals("금요일")){ %>selected<% }%>>금요일</option>
											</select>	
											<select name="starttime">
											    <option value="1" <%if(bean.getStarttime() == 1){ %>selected<% }%>>1</option>
											    <option value="2" <%if(bean.getStarttime() == 2){ %>selected<% }%>>2</option>
											    <option value="3" <%if(bean.getStarttime() == 3){ %>selected<% }%>>3</option>
											    <option value="4" <%if(bean.getStarttime() == 4){ %>selected<% }%>>4</option>
											    <option value="5" <%if(bean.getStarttime() == 5){ %>selected<% }%>>5</option>
											    <option value="6" <%if(bean.getStarttime() == 6){ %>selected<% }%>>6</option>
											    <option value="7" <%if(bean.getStarttime() == 7){ %>selected<% }%>>7</option>							   
											</select>
											<label>교시 -</label>							
											<select name="endtime">
											   	<option value="2" <%if(bean.getEndtime() == 2){ %>selected<% }%>>2</option>
											    <option value="3" <%if(bean.getEndtime() == 3){ %>selected<% }%>>3</option>
											    <option value="4" <%if(bean.getEndtime() == 4){ %>selected<% }%>>4</option>
											    <option value="5" <%if(bean.getEndtime() == 5){ %>selected<% }%>>5</option>
											    <option value="6" <%if(bean.getEndtime() == 6){ %>selected<% }%>>6</option>
											    <option value="7" <%if(bean.getEndtime() == 7){ %>selected<% }%>>7</option>
											    <option value="8" <%if(bean.getEndtime() == 8){ %>selected<% }%>>8</option>
											</select>
											<label>교시</label>		
								        </td> 
									    <input type="hidden" name="id" value="${id}"/>									    
                   	           			<td width=5% style="text-align:center;"><input type="text" name="professor" value="<%=bean.getProfessor()%>" id="prof"/></td>
                   	           			<td width=5%><input type="submit" value="수정" class="btn4"></td>             	           			
                   	           		</tr>
                   	           </table>
                            </p>
                        </div>
                    </div>
                    </form>
                </main>
                <script> 
                	document.getElementById('prof').readOnly = true;  //과목 수정시 본인 이름은 바꿀 수 없게끔 readOnly처리                	           			
                </script> 
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
        		
					case '1':
	 					$("select[name=endtime]").empty();
	 					str = '<option value="2" <%if(bean.getEndtime() == 2){ %>selected<% }%>>2</option>' +
							  '<option value="3" <%if(bean.getEndtime() == 3){ %>selected<% }%>>3</option>' +
					    	  '<option value="4" <%if(bean.getEndtime() == 4){ %>selected<% }%>>4</option>' +
					    	  '<option value="5" <%if(bean.getEndtime() == 5){ %>selected<% }%>>5</option>' +
					    	  '<option value="6" <%if(bean.getEndtime() == 6){ %>selected<% }%>>6</option>' +
					    	  '<option value="7" <%if(bean.getEndtime() == 7){ %>selected<% }%>>7</option>' +
					    	  '<option value="8" <%if(bean.getEndtime() == 8){ %>selected<% }%>>8</option>';
	 				    endTime.html(str);
						
					    break;
					    					    
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

<%@page import="member.MemberDTO"%>
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">           
    </head>
    <body class="sb-nav-fixed">
    
    
    	<%
			//한글처리
			request.setCharacterEncoding("UTF-8");
	try{
 			//String[] ccode = request.getParameterValues("ccode");
			//System.out.print("과목코드 : " + code.length);	자동으로 부여되는 숫자이므로 제외함		
		if((request.getParameterValues("cname") != null) ||
		   (request.getParameterValues("compdiv") != null) ||
		   (request.getParameterValues("compyear") != null) ||	
		   (request.getParameterValues("compsem") != null) ||		
		   (request.getParameterValues("grade") != null) ||	
		   (request.getParameterValues("day") != null) ||
		   (request.getParameterValues("starttime") != null) ||
		   (request.getParameterValues("endtime") != null) ||		   
		   (request.getParameterValues("professor") != null) ||
		   (request.getParameterValues("id") != null)){
			
			String[] cname = request.getParameterValues("cname");
			System.out.print("과목명 : " + cname.length);	
			
			String[] compdiv = request.getParameterValues("compdiv");
			System.out.print("이수구분 : " + compdiv.length);
			
			String[] compyear = request.getParameterValues("compyear");
			System.out.print("이수학년 : " + compyear.length);
			
			String[] compsem = request.getParameterValues("compsem");
			System.out.print("이수구분 : " + compsem.length);
			
			String[] grade = request.getParameterValues("grade");
			System.out.print("학점 : " + grade.length);
			
			String[] day = request.getParameterValues("day");
			System.out.print("요일 : " + day.length);
			
			String[] starttime = request.getParameterValues("starttime");
			System.out.print("시작 교시 : " + day.length);
			
			String[] endtime = request.getParameterValues("endtime");
			System.out.print("끝 교시 : " + day.length);
			
			String[] professor = request.getParameterValues("professor");
 			System.out.print("담당교수명 : " + professor.length);
 			
 			String[] id = request.getParameterValues("id");
 			System.out.print("담당교수 아이디 : " + id.length);
 			
			//과목 정보를 저장할 리스트 생성
			List<BoardBean> arrayList = new ArrayList<BoardBean>();			
			BoardDAO dao = new BoardDAO();
			
				if(professor.length > 1){				    
		 			
					System.out.print("여기까지는 온다");				
					
					for (int i = 0; i < professor.length; i++) {
	
	 					BoardBean boardBean = new BoardBean();
	 					
		 				boardBean.setCname(cname[i]);
		 				boardBean.setCompdiv(compdiv[i]);
		 				boardBean.setCompyear(Integer.valueOf(compyear[i]));
		 				boardBean.setCompsem(Integer.valueOf(compsem[i]));
		 				boardBean.setGrade(Integer.valueOf(grade[i]));
		 				boardBean.setDay(day[i]);
		 				boardBean.setStarttime(Integer.valueOf(starttime[i]));
		 				boardBean.setEndtime(Integer.valueOf(endtime[i]));
		 				boardBean.setProfessor(professor[i]);
		 				boardBean.setId(id[i]);
		 				
		 		        arrayList.add(boardBean);
		
		 		        
		 		   	 }//for문 end
					System.out.print("사이즈 : " + arrayList.size());
		 			//다중 과목 추가 메소드 호출
				    dao.insertMultipleSB(arrayList);				    	
		 		   	 
				}else if(professor.length == 1){
			
 					BoardBean boardBean = new BoardBean();
 					
	 				boardBean.setCname(cname[0]);
	 				boardBean.setCompdiv(compdiv[0]);
	 				boardBean.setCompyear(Integer.valueOf(compyear[0]));
	 				boardBean.setCompsem(Integer.valueOf(compsem[0]));
	 				boardBean.setGrade(Integer.valueOf(grade[0]));
	 				boardBean.setDay(day[0]);
	 				boardBean.setStarttime(Integer.valueOf(starttime[0]));
	 				boardBean.setEndtime(Integer.valueOf(endtime[0]));
	 				boardBean.setProfessor(professor[0]);
	 				boardBean.setId(id[0]);
	 				
	 		       dao.insertSB(boardBean);
					
				}
		}					
	 		
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		String professorName = request.getParameter("professor");
	
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
                	<form action="addCourse.jsp" method="POST">
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">과목추가</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">addCourse</li>
                        </ol>
                        <div class="row">
                        	<p class="mb-0">
                        	<div align="right">
                        		<input type="button" value="+" id="btn1">
                        		<input type="submit" value="모두 등록" id="btn3">                       		
                        	</div>
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="table table-striped" id="t"> 
                   	           		<tr bgcolor="lightgrey" align="center">
                   	           			<th width=5%>과목명</th>
                   	           			<th width=5%>이수구분</th>
                   	           			<th width=5%>이수학년</th>
                   	           			<th width=5%>이수학기</th>
                   	           			<th width=5%>학점</th>
                   	           			<th width=5%>강의시간</th>
                   	           			<th width=5%>담당교수</th>
                   	           			<th width=2%>삭제</th> 
                   	           			<th width=2%>등록</th>                  	           		                 	           			
                   	           		</tr>
                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
                   	  
                   	           			<td width=5%><input type="text" name="cname"/></td> 
                   	           			<td width=5%>
                   	           				<select name="compdiv">
                   	           					<option value="전공필수">전공필수</option>
                   	           					<option value="전공선택">전공선택</option>
                   	           					<option value="교양">교양</option>                   	           					
                   	           				</select>
                   	           			</td>       	           			
                   	           			<td width=5%>
                   	           				<select name="compyear">
                   	           					<option value="1">1학년</option>
                   	           					<option value="2">2학년</option>
                   	           					<option value="3">3학년</option> 
                   	           					<option value="4">4학년</option>               	           					
                   	           				</select>
                   	           			</td>
                   	           			<td width=5%>
                   	           				<select name="compsem">
                   	           					<option value="1">1학기</option>
                   	           					<option value="2">2학기</option>                  	           					
                   	           				</select>
                   	           			</td>
                   	           			<td width=5%>
                   	           				<select name="grade">
                   	           					<option value="1">1학점</option>
                   	           					<option value="2">2학점</option>
                   	           					<option value="3">3학점</option>                   	           					
                   	           				</select>
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
											<label>교시 -</label>								
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
                   	           			<td width=5% style="text-align:center;"><input type="text" name="professor" value="${professorName}" id="prof"/></td>
                   	           			<input type="hidden" name="id" value="${id}">
                   	           			<td width=5%><input type="button" value="-" class="btn2"></td>
                   	           			<td width=5%><input type="button" value="등록" class="btn4"></td>                  	           			          	           			
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
        <div id="result1"></div>
        
        <script>
        
	     	// 시작 교시 셀렉트 박스 변경 이벤트 핸들러
	        $(document).on("change", "select[name=starttime]", function () {
	            var trElement = $(this).closest("tr");
	            var selectedStarttime = parseInt($(this).val()); // 선택된 시작 교시를 정수로 변환
	
	            // 종료 교시 옵션을 초기화
	            trElement.find("select[name=endtime]").empty();
	
	            // 종료 교시 옵션 업데이트: 선택된 시작 교시부터 8까지 옵션을 추가
	            for (var i = selectedStarttime + 1; i <= 8; i++) {
	                trElement.find("select[name=endtime]").append('<option value="' + i + '">' + i + '</option>');
	            }
	        });
				
        		// '+' 버튼을 누를때마다 한 행씩 추가
				$('#btn1').click(function(){
					var html = 
	           		'<tr align="center" style="border-bottom: 1px, solid, lightgrey;">'+
	           			'<td width="5%"><input type="text" name="cname"></td>'+
	           			'<td width="5%">'+
	           				'<select name="compdiv">'+
	           					'<option value="전공필수">전공필수</option>'+
	           					'<option value="전공선택">전공선택</option>'+
	           					'<option value="교양">교양</option>'+                  	           					
	           				'</select>'+
	           			'</td>'+     	           			
	           			'<td width="5%">'+
	           				'<select name="compyear">'+
	           					'<option value="1">1학년</option>'+
	           					'<option value="2">2학년</option>'+
	           					'<option value="3">3학년</option>'+
	           					'<option value="4">4학년</option>'+              	           					
	           				'</select>'+
	           			'</td>'+
	           			'<td width="5%">'+
	           				'<select name="compsem">'+
	           					'<option value="1">1학기</option>'+
	           					'<option value="2">2학기</option>'+                  	           					
	           				'</select>'+
	           			'</td>'+
	           			'<td width="5%">'+
	           				'<select name="grade">'+
	           					'<option value="1">1학점</option>'+
	           					'<option value="2">2학점</option>'+
	           					'<option value="3">3학점</option>'+                   	           					
	           				'</select>'+
	           			'</td>'+
   	           			'<td width="10%">' +
					        '<select name="day">' +
							    '<option value="월요일">월요일</option>' +
							    '<option value="화요일">화요일</option>' +
							    '<option value="수요일">수요일</option>' +
							    '<option value="목요일">목요일</option>' +
							    '<option value="금요일">금요일</option>' +
							'</select> ' +
							'<select name="starttime">' +
							    '<option value="1">1</option>' +
							    '<option value="2">2</option>' +
							    '<option value="3">3</option>' +
							    '<option value="4">4</option>' +
							    '<option value="5">5</option>' +
							    '<option value="6">6</option>' +
							    '<option value="7">7</option>' +							   
							'</select> '	 +	
							'<label>교시 - </label>'	 +	
							' <select name="endtime">' +
							   	'<option value="2">2</option>' +
							    '<option value="3">3</option>' +
							    '<option value="4">4</option>' +
							    '<option value="5">5</option>' +
							    '<option value="6">6</option>' +
							    '<option value="7">7</option>' +
							    '<option value="8">8</option>' +
							'</select> ' +
							'<label>교시</label>'	 +	
			        	'</td>' + 
	           			'<td width="5%" style="text-align:center;"><input type="text" name="professor" value="${professorName}" id="prof"/></td>'+
	           			'<input type="hidden" name="id" value="${id}">' +
	           			'<td width="5%"><input type="button" value="-" class="btn2"></td>'+
	           			'<td width="5%"><input type="button" value="등록" class="btn4"></td>'+
	           		'</tr>';
	           
					$('tbody').append(html);
		
				});   

				// '-' 버튼 클릭 시 해당 행 삭제
		        $(document).on("click", ".btn2", function () {
		            $(this).closest("tr").remove();
		        });
				
		        //과목 추가시 본인 아이디는 바꿀 수 없게끔 readOnly처리   
            	document.getElementById('prof').readOnly = true;              	           			
            	
            	
		        $(document).on("click", ".btn4", function (e) {

		        	//'등록' 버튼 클릭 시 해당 tr의 정보만 DB에 전송!
		            var trElement = $(e.target).closest("tr");
		            var cname = trElement.find("input[name=cname]");
		            var compdiv = trElement.find("select[name=compdiv]");
		            var compyear = trElement.find("select[name=compyear]");
		            var compsem = trElement.find("select[name=compsem]");
		            var grade = trElement.find("select[name=grade]");
		            var day = trElement.find("select[name=day]"); 
		            var starttime = trElement.find("select[name=starttime]"); 
		            var endtime = trElement.find("select[name=endtime]");		            
		            var professor = trElement.find("input[name=professor]");	
		            var id = "${id}";
		        	var target = $(e.target);		        	
		        	
		        	console.log("e.target.value: " + e.target.value);
		        	
		        	console.log("등록버튼을 클릭한 행의 과목 정보 : " + cname.val() + ", " + compdiv.val() + ", " + 
		        			    compyear.val() + ", " + compsem.val() + ", " + grade.val() + ", " + day.val() + ", " + 
		        			    starttime.val() + ", " + endtime.val() + ", " + professor.val() + ", " + id);
		        	
		        	$.ajax({
		        		
		        		url:'<%=request.getContextPath()%>/addCourse.do',
		        		type: 'post',
		        		data: {
			        			cname:cname.val(), 
			        			compdiv:compdiv.val(), 
			        			compyear:compyear.val(), 
			        			compsem:compsem.val(), grade:grade.val(), 
			        			day:day.val(), 
			        			starttime:starttime.val(), 
			        			endtime:endtime.val(), 
			        			professor:professor.val(), 
			        			id:id
		        			},		        				
		        		dataType:'text',
		        		success: function(data){
		        			
		        			if (data == '1') {
								alert("과목이 성공적으로 추가됐습니다.");								
		        				$(target).val('등록완료');
		        				$(target).attr('disabled', 'disabled');
		        				cname.attr('disabled', 'disabled');
		        				compdiv.attr('disabled', 'disabled');
		        				compyear.attr('disabled', 'disabled');
		        				compsem.attr('disabled', 'disabled');
		        				grade.attr('disabled', 'disabled');
		        				day.attr('disabled', 'disabled');
		        				starttime.attr('disabled', 'disabled');
		        				endtime.attr('disabled', 'disabled');
		        				professor.attr('disabled', 'disabled');
		        				id.attr('disabled', 'disabled');
							}else {
								alert("과목 추가 실패했습니다.");								
							}	        			
		        		}	        		
		        	});       	
		        });
		        	        
		</script>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>                  
    </body>
</html>

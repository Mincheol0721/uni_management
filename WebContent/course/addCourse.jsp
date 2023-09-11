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
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
        
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
		   (request.getParameterValues("professor") != null)){
			
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
			
			String[] professor = request.getParameterValues("professor");
 			System.out.print("담당교수 : " + professor.length);
 			
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
		 				boardBean.setProfessor(professor[i]);
		 				
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
	 				boardBean.setProfessor(professor[0]);
	 				
	 		       dao.insertSB(boardBean);
					
				}

		}					
	 			
		}catch(Exception e){
			e.printStackTrace();
		}
		
 		%> 
   
   
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
                    <div class="sb-sidenav-menu">
                        <jsp:include page="/inc/menu.jsp" />
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        
                    </div>
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
                   	           <table border="1" style="border-collapse: collapse; border-color: lightgrey;" class="lec" id="t"> 
                   	           		<tr bgcolor="lightgrey" align="center">
                   	           			<td width=5%>과목명</td>
                   	           			<td width=5%>이수구분</td>
                   	           			<td width=5%>이수학년</td>
                   	           			<td width=5%>이수학기</td>
                   	           			<td width=5%>학점</td>
                   	           			<td width=5%>담당교수</td>
                   	           			<td width=2%>삭제</td> 
                   	           			<td width=2%>등록</td>                  	           		                 	           			
                   	           		</tr>
                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
                   	  
                   	           			<td width=5%><input type="text" name="cname"/></td> 
                   	           			<td width=5%>
                   	           				<select name="compdiv">
                   	           					<option value="required">전공필수</option>
                   	           					<option value="optional">전공선택</option>
                   	           					<option value="subject">교양</option>                   	           					
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
                   	           			<td width=5% style="text-align:center;"><input type="text" name="professor" value="${id}"/></td>
                   	           			<td width=5%><input type="button" value="-" id="btn2"></td>
                   	           			<td width=5%><input type="submit" value="등록" id="btn3"></td>             	           			
                   	           		</tr>
                   	           </table>
                            </p>
                        </div>
                    </div>
                    </form>
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
				
        		// '+' 버튼을 누를때마다 한 행씩 추가
				$('#btn1').click(function(){
					var html = 
	           		'<tr align="center" style="border-bottom: 1px, solid, lightgrey;">'+
	           			'<td width="5%"><input type="text" name="cname"></td>'+
	           			'<td width="5%">'+
	           				'<select name="compdiv">'+
	           					'<option value="required">전공필수</option>'+
	           					'<option value="optional">전공선택</option>'+
	           					'<option value="subject">교양</option>'+                  	           					
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
	           			'<td width="5%" style="text-align:center;"><input type="text" name="professor" value="${id}"/></td>'+
	           			'<td width="5%"><input type="button" value="-" id="btn2"></td>'+
	           			'<td width="5%"><input type="submit" value="등록" id="btn3"></td>'+
	           		'</tr>';
	           
					$('tbody').append(html);
		
				});   

				// '-' 버튼 클릭 시 해당 행 삭제
		        $(document).on("click", "#btn2", function () {
		            $(this).closest("tr").remove();
		        });
				 
		</script>
        		
		
		<script type="text/javascript">
		
			$("#btn3").click(function(){
				
				//버튼 클릭시 이벤트 발생 
				//문자열을 담을 변수 str과 배열 선언
				//클릭 된 버튼을 checkBtn이란 변수에 담음				
				var str = ""
				var tdArr = new Array();
				var checkBtn = $(this);
				
				//parent()를 이용해 버튼 checkBtn의 부모를 찾음
				var tr = checkBtn.parent().parent();
				var td = tr.children();
				
				//tr.text()를 이용해 해당 행의 모든 값을 가져옴
				//td값을 각각 가져오려면 td.eq(인덱스) 이용하면됨
				
				console.log("등록한 행의 모든 데이터 : " + tr.text());
				
				var cname = td.eq(0).text();
				var compdiv = td.eq(1).text();
				var compyear = td.eq(2).text();
				var compsem = td.eq(3).text();
				var grade = td.eq(4).text();
				var professor = td.eq(5).text();
				
				//반복문을 이용해 배열에 값을 담아 사용할 수도 있음
				td.each(function(i){
					
					tdArr.push(td.eq(i).text());
					
				});
				
				console.log("배열에 담긴 값 : " + tdArr);
		
				str += cname + compdiv + compyear + compsem + grade + professor;
				
				$("#result1").html(str);
				
				
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

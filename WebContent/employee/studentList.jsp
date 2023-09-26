<%@page import="member.StudentDAO"%>
<%@page import="org.apache.tomcat.jni.Stdlib"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="member.ProfessorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>

<% request.setCharacterEncoding("UTF-8"); %>

<%!
	

	//[1].페이징 기능 처리를 위한 변수들 선언
	int totalRecord = 0;//게시판(board테이블)에 저장된 전체 글의 갯수저장  [2]가서 구함.----------
	int numPerPage = 5;//한 페이지당 보여질 글의 갯수를 저장 
	int pagePerBlock = 3; //한 블럭 당 묶여질 페이지 번호의 갯수
	/*
		pagePerBlock변수 설명
			게시판 하단 부분을 보면   이전 3개  ◀   1   2  3  4  5      ▶ 다음 3개   화면이 있는데...
			이전 3개  ◀ 영역 또는    ▶ 다음 3개 영역을 클릭 했을대   게시판에 글갯수가 많을경우   한페이지 번호단위로 이동해서 화면을 보여주는 것은 매우 갑갑할 것입니다.
			그럴때에는 여러페이지 번호를  하나로 묶어서 하나의 블럭단위로 이동해서 화면을 보여주는 메뉴도 있을수 있다.
			몇개의 페이지번호를 하나로 묶어서  이전 3개  ◀ 영역 또는    ▶ 다음 3개 영역을 클릭했을때   조금더 빠르게 그다음 블럭에 위치한 페이지번호의 화면을 보여주고 싶을때
			몇개의 페이지 번호를 하나의 블럭으로 만들것인가?에대한  한블럭당 묶여지는 페이지 갯수를 저장하는 변수 
	*/
	int totalPage = 0; //board테이블에 저장된 전체 글의 갯수에 따라 보여지는 - 전체 페이지 갯수 [4]가서 구함. -------------
	
	int totalBlock = 0; //전체페이지 번호갯수에 대한  - 전체 블럭갯수  [9] 가서 구함.----------------------------
	
	//[7] 가서 구함. ------------
    int nowPage = 0; //현재 보여지는 화면의  페이지 번호( 1  2  3 페이지번호 중  1페이지번호를 클릭했을때의 1페이지번호값을 구해서 저장) 
    
    //[8] 가서 구함. -------------
    int nowBlock = 0; //현재 보여지는 페이지번호가 속한 블럭위치값 저장 
    
    //[10] 가서 구함. --------------------
    int beginPerPage = 0; //각 페이지 번호 마다  가장 위쪽에 보여지는 글의 시작글번호 구해서 저장할 변수 
    //----------------------------------------------------------------------[1] 끝

%>	

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 학생정보게시판</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="../js/scripts.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
       
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
        $(function(){ 
        	
        	
        	
        	//-----------------------학생등록-------------------------------
        	$("#student_reg").click(function(){
        	   document.mainform.action = "student_reg.jsp";	
          	   document.mainform.submit();
     	      
     		});
        	
         	checked = $("input[name=checkbox]");
         	///학생수정
//          	$("#professor_mod").click(function(){
        		
//          	   document.mainform.action = "professor_mod.jsp";
//          	   document.mainform.submit();
//        		});
        	
        	
        	
        	
        //--------------------------------------------------------
        
        
            //체크박스 하나만 눌리게 하기
            
            
            
            $('input[type="checkbox"][name="check"]').click(function(){
            	 //만약에 체크박스가 클릭되어있으면,
            	  if($(this).prop('checked')){
            		  //checkbox 전체를 checked 해제 후, 
            	     $('input[type="checkbox"][name="check"]').prop('checked',false);
            	 	  //click한 요소만 true 지정
            	     $(this).prop('checked',true);
            	 	  
//             	     attr()는 html의 속성(attribute)을 다루고, .
//             	     prop()는 javascript의 속성(property)을 다루는 차이점이 있습니다.

//             	     예를 들어,
//             	     Attr(“checked”); 와 prop(“checked”); 가 있다면
//             	     Attr의 값은 checked
//             	     Prop는 true가 됩니다.
            	    }
            	  
       	   });

     	//       체크박스에체크된모든행(Row)의값가져오기
            $("#student_mod").click(function(){     
//            	먼저 2개의 배열을 선언하였다. 
//             	rowData는 행의 값을 모두 담을 배열이고, 
//             	tdArr은 각각 td의 값을 담을 배열이다. 
//             	다음으로 체크된 체크박스를 가져와 checkbox라는 변수에 담는다.
            	var rowData = new Array();
                var tdArr = new Array();
                var checkbox = $("input[name=check]:checked");
                var id;
                var name;
                var tel;
                var ssn;
                var email;
                var addr;
                var pwd;
                var professor;                
                var faculty;
                var dept;
                
                
                 //체크된 체크박스의 수만큼 반복문을 실행 하여 
                 //체크된 체크박스 값을 가져온다
                checkbox.each(function(i) {
        
                    // checkbox.parent() : checkbox의 부모는 <td>이다.
                    // checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
                    var tr = checkbox.parent().parent().eq(i);
                    var td = tr.children();
                    
                    // 체크된 row의 모든 값을 배열에 담는다.
                    rowData.push(tr.text());
                    
                    // td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
                    id = td.eq(1).text();
                    console.log("id : " + id);
                    
                    name = td.eq(2).text();
                    console.log("name : " + name);

                    tel = td.eq(3).text();
                    console.log("tel : " + tel);

                    ssn = td.eq(4).text();
                    console.log("ssn : " + ssn);

                    email = td.eq(5).text();
                    console.log("email : " + email);

                    addr = td.eq(6).text();
                    console.log("addr : " + addr);

                    pwd = td.eq(7).text();
                    console.log("pwd : " + pwd);
                    
                    professor = td.eq(8).text();
                    console.log("professor : " + professor);

                    faculty = td.eq(9).text();
                    console.log("faculty : " + faculty);

                    dept = td.eq(10).text();
                    console.log("dept : " + dept);
                    
                    
                    });//체크박스 클릭했을때
                 
                 
                 
                 
                 
                 //professor_mod에 보낼 값을 동적으로 만들어서 submit할 데이터
                var form = document.createElement("form");
                form.setAttribute("method", "post");  //Post 방식
                form.setAttribute("action", "student_mod.jsp"); //요청 보낼 주소
				//<form method="post" action="professor_mod.jsp"></form>

                var hiddenIdField = document.createElement("input");
	                hiddenIdField.setAttribute("type", "hidden");
	                hiddenIdField.setAttribute("name", "id");
	                hiddenIdField.setAttribute("value", id);
                //<input type="hidden" name="id" value="id">
              
                form.appendChild(hiddenIdField);
                
                 var hiddenNameField = document.createElement("input");
	                 hiddenNameField.setAttribute("type", "hidden");
	                 hiddenNameField.setAttribute("name", "name");
	                 hiddenNameField.setAttribute("value", name);
                //<input type="hidden" name="name" value="name">
              
                form.appendChild(hiddenNameField);
                
             
                 var hiddenTelField = document.createElement("input");
                 hiddenTelField.setAttribute("type", "hidden");
                 hiddenTelField.setAttribute("name", "tel");
                 hiddenTelField.setAttribute("value", tel);
                //<input type="hidden" name="tel" value="tel">
              
                form.appendChild(hiddenTelField);
                
                 var hiddenSsnField = document.createElement("input");
                 hiddenSsnField.setAttribute("type", "hidden");
                 hiddenSsnField.setAttribute("name", "ssn");
                 hiddenSsnField.setAttribute("value", ssn);
                //<input type="hidden" name="ssn" value="ssn">
              
                form.appendChild(hiddenSsnField);
              
                 var hiddenEmailField = document.createElement("input");
                 hiddenEmailField.setAttribute("type", "hidden");
                 hiddenEmailField.setAttribute("name", "email");
                 hiddenEmailField.setAttribute("value", email);
                //<input type="hidden" name="email" value="email">
              
                form.appendChild(hiddenEmailField);
                
//<form method="post" action="professor_mod.jsp">
	//<input type="hidden" name="id" value="id">
	//<input type="hidden" name="name" value="name">
	//<input type="hidden" name="tel" value="tel">
	//<input type="hidden" name="ssn" value="ssn">
  	//<input type="hidden" name="email" value="email">
  	
//</form> 

                 var hiddenAddrField = document.createElement("input");
                 hiddenAddrField.setAttribute("type", "hidden");
                 hiddenAddrField.setAttribute("name", "addr");
                 hiddenAddrField.setAttribute("value", addr);
                //<input type="hidden" name="addr" value="addr">
              
                form.appendChild(hiddenAddrField);
                
//<form method="post" action="professor_mod.jsp">
	//<input type="hidden" name="id" value="id">
	//<input type="hidden" name="name" value="name">
	//<input type="hidden" name="tel" value="tel">
	//<input type="hidden" name="ssn" value="ssn">
  	//<input type="hidden" name="email" value="email">
  	 //<input type="hidden" name="addr" value="addr">
  	
//</form> 

				var hiddenPwdField = document.createElement("input");
				hiddenPwdField.setAttribute("type", "hidden");
				hiddenPwdField.setAttribute("name", "pwd");
				hiddenPwdField.setAttribute("value", pwd);
				                //<input type="hidden" name="pwd" value="pwd">
				              
				form.appendChild(hiddenPwdField);
				                
				//<form method="post" action="professor_mod.jsp">
					//<input type="hidden" name="id" value="id">
					//<input type="hidden" name="name" value="name">
					//<input type="hidden" name="tel" value="tel">
					//<input type="hidden" name="ssn" value="ssn">
				  	//<input type="hidden" name="email" value="email">
				  	 //<input type="hidden" name="addr" value="addr">
				  	 //<input type="hidden" name="pwd" value="pwd">
				  	
				//</form>
				
				var hiddenProfessorField = document.createElement("input");
				hiddenProfessorField.setAttribute("type", "hidden");
				hiddenProfessorField.setAttribute("name", "professor");
				hiddenProfessorField.setAttribute("value", professor);
				                //<input type="hidden" name="professor" value="professor">
				              
				form.appendChild(hiddenProfessorField);
				                
				//<form method="post" action="professor_mod.jsp">
					//<input type="hidden" name="id" value="id">
					//<input type="hidden" name="name" value="name">
					//<input type="hidden" name="tel" value="tel">
					//<input type="hidden" name="ssn" value="ssn">
				  	//<input type="hidden" name="email" value="email">
				  	 //<input type="hidden" name="addr" value="addr">
				  	 //<input type="hidden" name="pwd" value="pwd">
				  	 //<input type="hidden" name="professor" value="professor">
				  	
				//</form>
				
				
				var hiddenFacultyField = document.createElement("input");
				hiddenFacultyField.setAttribute("type", "hidden");
				hiddenFacultyField.setAttribute("name", "faculty");
				hiddenFacultyField.setAttribute("value", faculty);
				                //<input type="hidden" name="faculty" value="faculty">
				              
				form.appendChild(hiddenFacultyField);
				                
				//<form method="post" action="professor_mod.jsp">
					//<input type="hidden" name="id" value="id">
					//<input type="hidden" name="name" value="name">
					//<input type="hidden" name="tel" value="tel">
					//<input type="hidden" name="ssn" value="ssn">
				  	//<input type="hidden" name="email" value="email">
				  	 //<input type="hidden" name="addr" value="addr">
				  	 //<input type="hidden" name="pwd" value="pwd">
				  	  //<input type="hidden" name="professor" value="professor">
				  	 //<input type="hidden" name="faculty" value="faculty">
				  	
				//</form>
				
				
				var hiddenDeptField = document.createElement("input");
				hiddenDeptField.setAttribute("type", "hidden");
				hiddenDeptField.setAttribute("name", "dept");
				hiddenDeptField.setAttribute("value", dept);
				                //<input type="hidden" name="dept" value="dept">
				              
				form.appendChild(hiddenDeptField);
				                
				//<form method="post" action="professor_mod.jsp">
					//<input type="hidden" name="id" value="id">
					//<input type="hidden" name="name" value="name">
					//<input type="hidden" name="tel" value="tel">
					//<input type="hidden" name="ssn" value="ssn">
				  	//<input type="hidden" name="email" value="email">
				  	 //<input type="hidden" name="addr" value="addr">
				  	 //<input type="hidden" name="pwd" value="pwd">
				  	  //<input type="hidden" name="professor" value="professor">
				  	 //<input type="hidden" name="faculty" value="faculty">
				  	  //<input type="hidden" name="dept" value="dept">	  	
				//</form>



                
              
                           


                document.body.appendChild(form);
              //<body> 
				//<form method="post" action="professor_mod.jsp">
				//<input type="hidden" name="id" value="id">
				//<input type="hidden" name="name" value="name">
				//<input type="hidden" name="tel" value="tel">
				//<input type="hidden" name="ssn" value="ssn">
			  	//<input type="hidden" name="email" value="email">
			  	 //<input type="hidden" name="addr" value="addr">
			  	 //<input type="hidden" name="pwd" value="pwd">
			  	  //<input type="hidden" name="professor" value="professor">
			  	 //<input type="hidden" name="faculty" value="faculty">
			  	  //<input type="hidden" name="dept" value="dept">	  	
				//</form>
			 //</body>

                form.submit();
                 
                 
            });
     		
          //-----------------------학생삭제-------------------------------
        	$("#student_del").click(function(){
//          	   document.mainform.action = "professor_del.jsp";	
//           	   document.mainform.submit();
				var rowData = new Array();
                var tdArr = new Array();
                var checkbox = $("input[name=check]:checked");
				var id;
				
				checkbox.each(function(i) {
			        
                    // checkbox.parent() : checkbox의 부모는 <td>이다.
                    // checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
                    var tr = checkbox.parent().parent().eq(i);
                    var td = tr.children();
                    
                    // 체크된 row의 모든 값을 배열에 담는다.
                    rowData.push(tr.text());
                    
                    // td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
                    id = td.eq(1).text();
                    console.log("id : " + id);
                    
				});
         	//student_del에 보낼 값을 동적으로 만들어서 submit할 데이터
               var form = document.createElement("form");
               from = document.body.appendChild(form);
               form.setAttribute("method", "post");  //Post 방식
               form.setAttribute("action", "student_del.jsp"); //요청 보낼 주소
				//<form method="post" action="professor_mod.jsp"></form>

               var hiddenIdField = document.createElement("input");
	                hiddenIdField.setAttribute("type", "hidden");
	                hiddenIdField.setAttribute("name", "id");
	                hiddenIdField.setAttribute("value", id);
               //<input type="hidden" name="id" value="id">
             
               form.appendChild(hiddenIdField);
               form.submit();
      	       
               alert("삭제 되었습니다");
      		});
        	
        	
        });
       	
			function check(){
 			
 			//검색어를 입력하지 않았다면?
 			if(document.search.keyWord.value == ""){
 				alert("검색어를 입력하세요");
 				document.search.keyWord.focus();
 				return;//check함수 벗어나기 
 			}
 			
 			//검색어를 입력했다면?
 			document.search.submit(); //form태그의 action속성에 작성한 notice.jsp로 검색요청시!
 									   //입력한  검색어 + 선택한 검색기준값  + hidden값 까지 모두 request에 담아서 전송합니다. 			
 		}
        
			
			//목록으로 부분
			function fnList() {
				document.list.action="studentList.jsp";
				document.list.submit();
				
			}
        
        
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
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">학생정보 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">studentList</li>
                        </ol>
                        <div class="row">
                        	<form id="mainform" action="" method="post" name="mainform">
                   	           <table id="main_tabel" border="1"  style="border-collapse: collapse; border-color: lightgrey;" class="lec"> 
                   	           		<tr bgcolor="lightgrey" align="center">
                   	           			<td width=5%></td>
                   	           			<td width=5%>학번</td>
                   	           			<td width=5%>이름</td>
                   	           			<td width=5%>연락처</td>
                   	           			<td width=5%>주민등록번호</td>
                   	           			<td width=5%>이메일</td>
                   	           			<td width=5%>주소</td>
                   	           			<td width=5%>비밀번호</td>
                   	           			<td width=5%>교수</td>
                   	           			<td width=5%>학부</td>
                   	           			<td width=5%>학과</td>
                   	           		</tr>
                   	           		<%!String keyWord, keyField;  %>
                   	       			<%
                   	       			
                   	     		  	//1. 한글처리 (입력한 검색어와 검색기준값에 한글문자 처리)
	                   	       		request.setCharacterEncoding("UTF-8");
	                   	       		
	                   	       	    //2. 조건    만약 검색어가 입력되어 있다면? 선택한 검색기준값과 입력한 검색어를 request에서 받아옵니다.
	                   	       	    //요약 : 요청한 값 얻기 
	                   	       	    if(request.getParameter("keyWord") != null){
	                   	       	    	//검색기준값(이름, 제목, 내용 중에 select option에서 선택한 하나의 값)
	                   	       	    	keyField = request.getParameter("keyField"); //이름 - name  또는   제목 - subject 또는  내용 - content중에 하나 
	                   	       	    	//입력한 검색어 얻기 
	                   	       	    	keyWord = request.getParameter("keyWord");
	                   	       	    }
	                   	       	    //목록으로 부분
	                   	       	   	if(request.getParameter("reload") != null){
	                   	       	   		if(request.getParameter("reload").equals("true")){
	                   	       	   			keyWord="";
	                   	       	   		}
	                   	       	   	}
	                   	       	    
                   	       			StudentDAO dao = new StudentDAO();
                   	       			
                   	       			
                   	       			List studMem = dao.listStudent(keyWord, keyField);
                   	       			
                   	    			MemberDTO Mem = null;
                   	    			
                   	    			//페이징 처리 
                   	       			//2교수정보에 저장된 전체갯수
                   	       			totalRecord = studMem.size();
                   	       			
                   	       			//4전체 페이지번호 갯수구하기 = 전체글의 갯수 / 한페이지당 보여질 글의 갯수
                   	       			totalPage =  (int)Math.ceil(  (double)totalRecord / numPerPage ); 
                   	       			
                   	       			//9전체 총 블럭위치값 갯수 구하기 = 전체페이지번호 갯수/ 한블럭당 묶여질 페이지번호갯수(3)
                   	       		    totalBlock =  (int)Math.ceil( (double)totalPage / pagePerBlock );
                   	       			
                   	       			//7현재 클릭한 페이지번호 구하기
                   	       			if(request.getParameter("nowPage") != null){
                   	       				
                   	       				nowPage = Integer.parseInt(request.getParameter("nowPage"));
                   	       			}
                   	       			//8현재클릭한 페이지가 속해있는 블록위치값구하기 >를 누르면 바뀌는 위치
                   	       			if(request.getParameter("nowBlock") != null){
                   	       				
                   	       				nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
                   	       			}
                   	       			
		                   	       	//[10] 각 페이지 번호 마다  가장 위에 보여지는 첫번째 시작글번호 구하기
		                   	       	//첫번째 시작 글번호  = 현재 보여지는 페이지번호 * 한페이지당 보여질 글의 갯수
		                   	       	beginPerPage = nowPage * numPerPage;
		                   	     for(int cnt = beginPerPage; cnt<(beginPerPage+numPerPage); cnt++){
                	       				
		                   	       		//만약 cnt변수에 저장된 데이터가 총글의 갯수와 같아지면.. 필요없는 반복을 하지 않기 위해 for문 빠져나가기 
		                   	     			if(cnt == totalRecord){
		                   	     				break;
		                   	     			}
                   	       			Mem = (MemberDTO)studMem.get(cnt);
                   	       			%>
                   	           		<tr align="center" style="border-bottom: 1px, solid, lightgrey;">
                   	           			<td><input type="checkbox" name="check" value="<%=Mem.getId() %>"></td>
                   	           			<td width=5%><%=Mem.getId() %></td>
                   	           			<td width=5%><%=Mem.getName() %></td>
                   	           			<td width=5%><%=Mem.getTel() %></td>
                   	           			<td width=5%><%=Mem.getSsn() %></td>
                   	           			<td width=5%><%=Mem.getEmail() %></td>
                   	           			<td width=5%><%=Mem.getAddr() %></td>
                   	           			<td width=5%><%=Mem.getPwd() %></td>
                   	           			<td width=5%><%=Mem.getProfessor() %></td>
                   	           			<td width=5%><%=Mem.getFaculty() %></td>
                   	           			<td width=5%><%=Mem.getDept() %></td>
                   	           			
                   	           			
                   	           		</tr>
                   	           		<%
                   	           		}//for 닫기
                   	       			%>
                   	 
                   	       			
                   	           </table>
                   	              <%--[3] 게시판에 저장된 전체 글수 출력 --%>			<%--[5] 전체 페이지번호 수 출력 --%>			   <%--[6] 현재페이지 번호 출력 --%>
                   	          		전체글수:<%=totalRecord %>&nbsp;&nbsp;&nbsp;전체페이지수:<%=totalPage %>&nbsp;&nbsp;&nbsp;현재페이지:<%=nowPage+1 %></h3>
                   	          		
                   	           		
                   	           		
                   	           	 <input style="float: right" type="button" id="student_del" name="student_del" value="삭제">
                   	           	 <input style="float: right" type="button" id="student_mod" name="student_mod" value="수정">
                   	           	 <input style="float: right" type="button" id="student_reg" name="student_reg" value="등록">
                   	         </form>
                   	         
                   	         
               <div id="table_search">
				<form action="studentList.jsp" name="search" method="post">
					<input type="hidden" name="page" value="0">
					<table border="0" align="center">
						<tr>
							<td align="center">
								<select name="keyField">
									<option value="name">이름</option>
									<option value="id">학번</option>

								</select>
								<!-- 검색어 입력하는 곳 -->
								<input type="text" name="keyWord" class="input_box"> 
								<!-- 검색(찾기) 버튼 -->
								<input type="button" value="찾기" class="btn" onclick="check();">	
								<!-- 목록으로 돌아가기 -->							
								<a href ="studentList.jsp" 
								   onclick="fnList(); return false;"
								   style="text-decoration: none;">목록으로</a>
								</td>
							</tr>
						</table>
					</form>	
				</div>
				
						<form name="list" method="post">
                   	         <!-- 목록으로 돌아가기 -->							
								<input type="hidden" name="reload" value="true">
                   	    </form>
	                   	         
                   	         <%--페이징처리 하는부분 --%>
                   	         <div id="page_control" align="center">
                   	          	<%
									//[15] 게시판에 글이 하나라도 존재하고, 현재 블럭의 위치가 적어도 0보다 크다면?(이전으로 이동할 블럭위치가 있다는 의미)
									//     <<<이전 <a>태그가 화면에 보이게 설정
									if(totalBlock > 0){
										if(nowBlock > 0){
								%>			
										<%--이전 을 누르면 이전블럭위치 값과 ,  이전블럭위치의 시작페이지번호를 notice.jsp로 요청시 전달합니다. --%>
										<a href="studentList.jsp?nowBlock=<%=nowBlock-1%>&nowPage=<%=(nowBlock-1)*pagePerBlock%>">   
											이전<%=pagePerBlock%>개<<< 
										</a>							
								<%			
										}
									}
								%>
                   	           	<%
                   	           	for(int cnt =0; cnt<pagePerBlock; cnt++){
                   	           	    //현재 보여질 페이지번호가  전체페이지갯수와 같아지면 3번반복하지 않고 for반복문 빠져나감
                   	           		if((nowBlock * pagePerBlock) + cnt == totalPage){
                   	           			break;
                   	           		}
                   	           	%>
                   	           	
                   	           	<a href= "studentList.jsp?nowPage=<%=(nowBlock * pagePerBlock) + cnt %>&nowBlock=<%=nowBlock%>" style="text-decoration: none;">
                   	           			<%--(0 nowBlock이 처음에 0임   *     3) +1  + 0  --%>
                   	           			<%=(nowBlock * pagePerBlock) + 1 + cnt %>
                   	           			
                   	           		
                   	           	</a>
                   	           	
                   	           	 <%
                   	           	 	//
                   	           		if( ((nowBlock * pagePerBlock) + 1 + cnt ) ==totalRecord){
                   	           			break;
                   	           		}
                   	          
                   	           	}//for 반복문
                   	           	
                   	       		//[13] 이동할 블럭이 있으면?  >>>다음 3개  <-<a>링크 화면에 표시
            					//조건식 : 전체블럭 위치 갯수가  현재블럭위치 값보다 더크면?(>>다음 이동할 블럭이 있다면?)
            					if(totalBlock > nowBlock + 1){
            					%>		
                          		<%--[14] >>>다음3개 링크를 클릭했을때 그다음블럭위치번호와, 그다음블럭의 시작페이지번호를 notice.jsp로 요청해서 전달  --%>
								<a href="studentList.jsp?nowBlock=<%=nowBlock+1%>&nowPage=<%=(nowBlock+1)*pagePerBlock%>">	
									>>>다음<%=pagePerBlock%>개
								</a>	
									
							<%		
								}
							%>
                          			
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
        
     
</body>
</html>

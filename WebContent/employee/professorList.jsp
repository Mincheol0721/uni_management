<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="member.ProfessorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>OO대학교 학사관리 시스템 - 교수정보게시판</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="../js/scripts.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
       
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
        $(function(){ 
        	
        	
        	
        	//-----------------------교수등록-------------------------------
        	$("#professor_reg").click(function(){
        	   document.mainform.action = "professor_reg.jsp";	
          	   document.mainform.submit();
     	      
     		});
        	
         	checked = $("input[name=checkbox]");
         	//교수수정
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
            $("#professor_mod").click(function(){     
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

                    faculty = td.eq(8).text();
                    console.log("faculty : " + faculty);

                    dept = td.eq(9).text();
                    console.log("dept : " + dept);
                    
                    
                    });//체크박스 클릭했을때
                 
                 
                 
                 
                 
                 //professor_mod에 보낼 값을 동적으로 만들어서 submit할 데이터
                var form = document.createElement("form");
                form.setAttribute("method", "post");  //Post 방식
                form.setAttribute("action", "professor_mod.jsp"); //요청 보낼 주소
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
			  	 //<input type="hidden" name="faculty" value="faculty">
			  	  //<input type="hidden" name="dept" value="dept">	  	
				//</form>
			 //</body>

                form.submit();
                 
                 
            });
     		
          //-----------------------교수삭제-------------------------------
        	$("#professor_del").click(function(){
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
         	//professor_del에 보낼 값을 동적으로 만들어서 submit할 데이터
               var form = document.createElement("form");
               from = document.body.appendChild(form);
               form.setAttribute("method", "post");  //Post 방식
               form.setAttribute("action", "professor_del.jsp"); //요청 보낼 주소
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
                        <h1 class="mt-4">교수정보 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">professorList</li>
                        </ol>
                        <div class="row">
                        	<form id="mainform" action="" method="post" name="mainform">
                   	           <table id="main_tabel" border="1"  style="border-collapse: collapse; border-color: lightgrey;" class="lec"> 
                   	           		<tr bgcolor="lightgrey" align="center">
                   	           			<td width=5%></td>
                   	           			<td width=5%>교번</td>
                   	           			<td width=5%>이름</td>
                   	           			<td width=5%>연락처</td>
                   	           			<td width=5%>주민등록번호</td>
                   	           			<td width=5%>이메일</td>
                   	           			<td width=5%>주소</td>
                   	           			<td width=5%>비밀번호</td>
                   	           			<td width=5%>학부</td>
                   	           			<td width=5%>학과</td>
                   	           		</tr>
                   	       			<%
                   	       			ProfessorDAO dao = new ProfessorDAO();
                   	       			
                   	       			
                   	       			List profMem = dao.listProfessor();
                   	       			
                   	    			MemberDTO Mem = null;
                   	    			
                   	    			
                   	       			
                   	       			for(int i=0; i < profMem.size(); i++){
                   	       			Mem = (MemberDTO)profMem.get(i);
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
                   	           			<td width=5%><%=Mem.getFaculty() %></td>
                   	           			<td width=5%><%=Mem.getDept() %></td>
                   	           			
                   	           			
                   	           		</tr>
                   	           		<%
                   	           		}
                   	       			%>
                   	 
                   	       			
                   	           </table>
                   	          		
                   	           		
                   	           		
                   	           	 <input style="float: right" type="button" id="professor_del" name="professor_del" value="삭제">
                   	           	 <input style="float: right" type="button" id="professor_mod" name="professor_mod" value="수정">
                   	           	 <input style="float: right" type="button" id="professor_reg" name="professor_reg" value="등록">
                   	         </form>
                   	          		
                   	           		
                          			
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

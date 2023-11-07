<%@page import="cHistory.CHistoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<%
	String data = request.getParameter("data");
	
	String userName = request.getParameter("userName");
	
	String id = (String)session.getAttribute("id");
%>
<title>교수에게 이메일 전송</title>
</head>
<body>
<h2>이메일</h2>
<form method="post" action="SendProcess.jsp">
<table border=1 style="border-collapse: collapse; border-color: lightgrey;" class="lec">

    <tr>    
        <td hidden="">
            보내는 사람 : <input  type="text" name="from" value="rrws12@naver.com" />
        </td>
    </tr>
    <tr>    
        <td>
            받는 사람 : <input type="text" name="to" value="<%=data%>" readonly="readonly">
        </td>
    </tr>
    <tr>    
        <td>
          학생이름 : <input type="text" name="subject" size="50" value="<%=userName%> (학번 : <%=id%>)" readonly="readonly">
        </td>
    </tr>
    <tr>    
        <td hidden="hidden">
            형식 :
            <input type="radio" name="format" value="text" checked />Text
            <input type="radio" name="format" value="html" />HTML
        </td>
    </tr>
    <tr>
        <td>
            <textarea name="content" cols="60" rows="10" maxlength="300"></textarea>
        </td>
    </tr>
    <tr>
        <td>
            <button type="submit">전송하기</button>
        </td>
    </tr>
</table>
</form>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
     <script src="js/scripts.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
     <script src="assets/demo/chart-area-demo.js"></script>
     <script src="assets/demo/chart-bar-demo.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
     <script src="js/datatables-simple-demo.js"></script>
     
     <script type="text/javascript">
     
 	//제한글자 판독

    $('#content').keyup(function(){
         if ($(this).val().length > $(this).attr('maxlength')) {
             
             $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
         }
     });
     
     </script>
</body>
</html>
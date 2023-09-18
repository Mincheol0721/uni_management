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
            받는 사람 : <input type="text" name="to" value="<%=data%>"/ readonly="readonly">
        </td>
    </tr>
    <tr>    
        <td>
            제목 : <input type="text" name="subject" size="50" value="" placeholder="학번또는 이름을 입력해 주세요"/>
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
            <textarea name="content" cols="60" rows="10" placeholder=""></textarea>
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
</body>
</html>
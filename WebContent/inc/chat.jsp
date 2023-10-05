<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			$(function() {
				var id = '<%=(String)session.getAttribute("id")%>';
				
				if(id == 'null') {
					$("#chat").hide();
				}
			});
			function chatWinOpen() {
		        var id = '<%=(String)session.getAttribute("id")%>';
		        var w = 320;
		        var h = 400;
		        var xPos = (document.body.offsetWidth) - 320;
		        xPos += window.screenLeft;
		        var yPos = (document.body.offsetHeight/2);
		        console.log('id값: ' + id);
		        window.open("<%=request.getContextPath()%>/inc/ChatWindow.jsp?chatId=" + id, "", "width=" + w + ", height=" + h + ", left=" + xPos +" , top=" + yPos);
		        id = "";
		    }
		</script>
		<style type="text/css">
			#chat {
			font-size: 30px;
			object-fit: scale-down;
			font-stretch: normal;
			color: white;
			border: none;
			background-color: #828282;
			border-radius: 30px;
			position: fixed;
			right: 30px;
			bottom: 30px;
			}
		</style>
	</head>
	<body>
		<div style="position: absolute; right: 30px; bottom: 80px;">
       		<button type="button" id="chat" onclick="javascript:chatWinOpen();"><i class="fa-solid fa-comments"></i></button>
		</div>
	</body>
</html>
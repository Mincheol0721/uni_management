<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<%-- Naver search API --%>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script>
		// [검색 요청] 버튼 클릭 시 실행할 메서드를 정의합니다.
		$(function() {
			var startNum = $('.startNum').val();
			var keyword = '<%=request.getParameter("keyword")%>';
			
			$.ajax({
		        url : "<%=request.getContextPath()%>/popup.jsp?keyword=" + keyword,  // 요청 URL
		        type : "get",                  // HTTP 메서드
		        data : {                       // 매개변수로 전달할 데이터
		            keyword : keyword,                   // 검색어
		            startNum : startNum// 검색 시작 위치
		        },
		        dataType : "json",      // 응답 데이터 형식
		        success : sucFuncJson,  // 요청 성공 시 호출할 메서드 설정
		        error : errFunc         // 요청 실패 시 호출할 메서드 설정
			});
			
			if($('.startNum').click()) {
				$('.startNum').click(function() {
					startNum = $(this).val();
					console.log(startNum);
					$.ajax({
				        url : "<%=request.getContextPath()%>/popup.jsp?keyword=" + keyword + "&startNum=" + startNum,  // 요청 URL
				        type : "get",                  // HTTP 메서드
				        data : {                       // 매개변수로 전달할 데이터
				            keyword : keyword,                   // 검색어
				            startNum : startNum// 검색 시작 위치
				        },
				        dataType : "json",      // 응답 데이터 형식
				        success : sucFuncJson,  // 요청 성공 시 호출할 메서드 설정
				        error : errFunc         // 요청 실패 시 호출할 메서드 설정
					});
				});
				
			} 
			
		});
			
			
		
		
			// 검색 성공 시 결과를 화면에 뿌려줍니다.
			function sucFuncJson(d) {
				
// 				console.log(d);
				
			    var str = "";
			    		
			    $.each(d.items, function(index, item) {
			        str += "<tr align='center'>";
			        str += "    <td>" + (index + 1) + "</td>";
			        str += "    <td>" + item.title + "</td>";
			        str += "    <td>" + item.description + "</td>";
			        str += "    <td>" + item.bloggername + "</td>";
			        str += "    <td>" + item.postdate + "</td>";
			        str += "    <td><input type='button' value='바로가기'><a href='" + item.link + "' target='_blank'></a></td>";
			        str += "</tr>";
			    });
			    $('#searchResult').html(str);
			}
			
			// 실패 시 경고창을 띄워줍니다.
			function errFunc(e) {
			    alert("실패: " + e.status);
			}
		</script>
		
		<style>
			table {
				border-collapse: collapse;
			}
			td {
				font-size: 14px;
				padding: 1px;
			}
			.startNum {
				text-align: right;
				margin-top: 6px;
				border: 0.5px solid grey;
				background: none;
				cursor: pointer;
			}
		</style>
	</head>
	<body>
		<h1>네이버 블로그 검색 결과</h1>
		<div>
		    <table class="row" border="1">
		    	<thead>
		    		<tr align="center" bgcolor="#A4FFA2">
		    			<th>No.</th>
		    			<th>제목</th>
		    			<th>요약</th>
		    			<th>블로그명</th>
		    			<th>작성일</th>
		    			<th>바로가기</th>
		    		</tr>
		    	</thead>
		    	<tbody id="searchResult"></tbody>
		    </table>
		    <nav align="right">
			    <input type="button" value="1" class="startNum">
			    <input type="button" value="2" class="startNum">
			    <input type="button" value="3" class="startNum">
			    <input type="button" value="4" class="startNum">
			    <input type="button" value="5" class="startNum"> 
			    <input type="button" value="6" class="startNum">
			    <input type="button" value="7" class="startNum">
			    <input type="button" value="8" class="startNum">
			    <input type="button" value="9" class="startNum">
			    <input type="button" value="10" class="startNum"> 
		    </nav>
		</div>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="path" value="${pageContext.request.contextPath }" />

<c:set var="job" value="${sessionScope.job}" />

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	</head>
	<body>
		<div class="nav">
			<div class="sb-sidenav-menu-heading">메뉴</div>
			<a class="nav-link menu" href="${path}/index.jsp">
				홈
			</a>
			<a class="nav-link menu" href="${path}/menu/lecture.jsp">
				수강신청
			</a>
			<a class="nav-link menu" href="${path}/menu/grade.jsp">
				성적
			</a>
			<a class="nav-link menu" href="${path}/menu/info.jsp">
				학사정보
			</a>
	<c:choose>
		<c:when test="${job eq '교수'}">
			<a class="nav-link menu" href="#">
				교수 전용메뉴
			</a>
		</c:when>
		<c:when test="${job eq '교직원'}">
			<a class="nav-link menu" href="${path}/menu/professorList.jsp">
				교수정보
			</a>
			<a class="nav-link menu" href="${path}/menu/professorList.jsp">
				학생정보
			</a>
		</c:when>
		<c:when test="${job eq '학생'}">
			<a class="nav-link menu" href="#">
				학생 전용메뉴
			</a>
		</c:when>
	</c:choose>
		</div>
		<script type="text/javascript">
			$('.menu').click(function(e) {
				$('.menu').css('color', 'rgba(255, 255, 255, 0.25)');
				$(this).css('color', 'white');
				
				var linkHref = $(this).attr('href');
				
				setTimeout(function() {
					window.location.href = linkHref;
				}, 500);
			});
		</script>
	</body>
</html>
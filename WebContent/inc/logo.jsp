<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript">
			function popup() {
				var keyword = document.getElementById('keyword').value;
				var url = "<%=request.getContextPath()%>/inc/popup.jsp?keyword=" + keyword;
				var name = "검색결과";
				var option = "width = 1280, height = 720, top = 100, left = 200, location = yes";
				window.open(url, name, option);
			}
		</script>
	</head>
	<body>
		<!-- 로고-->
	    <a class="navbar-brand ps-3" href="<%=request.getContextPath()%>/index.jsp">OO대학교</a>
	    <!-- 사이드바 열기닫기-->
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
        <!-- 상단검은색 바-->
        <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
            <div class="input-group">
            	<%-- 검색창인풋 --%>
                <input class="form-control" id="keyword" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" name="search" />
                <button class="btn btn-primary" id="searchBtn" type="button" onclick="javascript:popup()"><i class="fas fa-search"></i></button>
            </div>
        </form>
        <!-- 사이드바-->
        <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                <%--조회, 수정, 로그아웃--%>
                <jsp:include page="/inc/member.jsp" />
            </li>
        </ul>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="id" value="${sessionScope.id }" />

<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
<c:choose>
	<c:when test="${id eq null}">
    	<li><a class="dropdown-item" href="${path}/member/login.jsp">로그인</a></li>
	    <li><a class="dropdown-item" href="${path}/member/register.jsp">회원가입</a></li>
	</c:when>
	<c:otherwise>
		<li><a class="dropdown-item" href="${path}/member/memList.jsp">회원정보조회</a></li>
		<li><a class="dropdown-item" href="${path}/member/checkPwd.jsp">회원정보수정</a></li>
		<li><hr class="dropdown-divider" /></li>
		<li><a class="dropdown-item" href="${path}/member/logout.jsp">로그아웃</a></li>
	</c:otherwise>
</c:choose>
</ul>

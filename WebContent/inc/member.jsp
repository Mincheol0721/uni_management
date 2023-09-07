<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	//컨텍스트 주소 얻기	
	String path = request.getContextPath();
	
	//session객체 메모리 영역에 접근하여 로그인 인증값을 session에서 받아옴
 	String id = (String)session.getAttribute("id");
%>	
<header>
		<div id="login">
<%
	if(id == null) { //session객체 메모리에 로그인 인증값이 저장되어 있지 않으면
%>
			<a href="<%=path%>/member/login.jsp">login</a> | 
			<a href="<%=path%>/member/join.jsp">join</a>
		</div>
<%
	} else { //session객체 메모리에 로그인 인증값이 저장되어 있으면
%>
			<span style="color:red;"><%= id %>님, 로그인 중! 환영합니다! &nbsp;&nbsp;</span> | 
			<a href="<%=path%>/member/logout.jsp">logout</a>
		</div>
<%
	}
%>
	<div class="clear"></div>
	<!-- 로고들어가는 곳 -->
	<div id="logo">
		<img src="<%= path %>/images/logo.gif" width="265" height="62" alt="Fun Web">
	</div>
	<!-- 로고들어가는 곳 -->
	<nav id="top_menu">
		<ul>
			<li><a href="<%= path %>/index.jsp">HOME</a></li>
			<li><a href="<%= path %>/company/welcome.jsp">COMPANY</a></li>
			<li><a href="<%= path%>/solutions/search.jsp">SOLUTIONS</a></li>
			<li><a href="<%= path %>/center/notice.jsp">CUSTOMER CENTER</a></li>
			<li><a href="#">CONTACT US</a></li>
		</ul>
	</nav>
</header>

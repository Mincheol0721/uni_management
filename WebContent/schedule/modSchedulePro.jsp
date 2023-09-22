<%@page import="schedule.ScheduleDTO"%>
<%@page import="schedule.ScheduleDAO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//요청값 얻기
	int no = Integer.parseInt( request.getParameter("no") );
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String sclass = request.getParameter("sclass");
	
	//수정할 내용 ScheduleDTO객체에 저장
	ScheduleDTO dto = new ScheduleDTO();
	dto.setNo(no);
	dto.setTitle(title);
	dto.setContent(content);
	dto.setSclass(sclass);
	 
	//DB작업
	ScheduleDAO dao = new ScheduleDAO();
	dao.updateBoard(dto);
	
	//수정한 글 목록 조회해서 보여주기
%>
	<script type="text/javascript">
		alert('수정되었습니다.');
		location.href = '<%=request.getContextPath()%>/menu/schedule.jsp';
	</script>

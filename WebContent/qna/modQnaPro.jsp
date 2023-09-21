<%@page import="qna.QnaDAO"%>
<%@page import="qna.QnaDTO"%>
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
	
	System.out.println("pro no: " + no);
	System.out.println("pro title: " + title);
	System.out.println("pro content: " + content);
	
	//수정할 내용 NoticeDTO객체에 저장
	QnaDTO dto = new QnaDTO();
	dto.setNo(no);
	dto.setTitle(title); 
	dto.setContent(content); 
	
	//DB작업
	QnaDAO dao = new QnaDAO();
	dao.updateBoard(dto);
	
	//수정한 글 목록 조회해서 보여주기
%>
	<script type="text/javascript">
		alert('수정되었습니다.');
		location.href = 'viewQna.jsp?no=' + <%=no%>;
	</script>

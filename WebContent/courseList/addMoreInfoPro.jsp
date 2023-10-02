<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="courseList.MoreInfoBean" %>
<%@ page import="courseList.MoreInfoDAO" %>

<%

    // 폼에서 전송된 데이터 받기
    String cname = request.getParameter("cname");
    int week = Integer.parseInt(request.getParameter("week"));
    int ses = Integer.parseInt(request.getParameter("ses"));
    String topic = request.getParameter("topic");
    String way = request.getParameter("way");
    String day = request.getParameter("day");
    int starttime = Integer.parseInt(request.getParameter("starttime"));
    int endtime = Integer.parseInt(request.getParameter("endtime"));
    String homework = request.getParameter("homework");
    String id = (String)session.getAttribute("id");
    
    // MoreInfoBean 객체 생성
    MoreInfoBean bean = new MoreInfoBean(cname, week, ses, topic, way, day, starttime, endtime, homework, id);
	//System.out.println(bean);
    
    // MoreInfoDAO 객체 생성 및 데이터 추가
    MoreInfoDAO dao = new MoreInfoDAO();
    dao.insertMI(bean);

%>

<script>
	
	alert("세부정보가 추가되었습니다.");
	location.href = "moreInfo_professor.jsp?cname=" + encodeURIComponent("<%=bean.getCname()%>");

</script>

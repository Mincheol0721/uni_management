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
    String time = request.getParameter("time");
    String homework = request.getParameter("homework");

//     System.out.println(cname);
//     System.out.println(week);
//     System.out.println(ses);
//     System.out.println(topic);
//     System.out.println(way);
//     System.out.println(time);
//     System.out.println(homework);
    
    
    // MoreInfoBean 객체 생성
    MoreInfoBean bean = new MoreInfoBean(cname, week, ses, topic, way, time, homework);
	//System.out.println(bean);
    
    // MoreInfoDAO 객체 생성 및 데이터 추가
    MoreInfoDAO dao = new MoreInfoDAO();
    dao.insertMI(bean);

%>

<script>
	
	alert("세부정보가 추가되었습니다.");
	location.href = "moreInfo_professor.jsp?cname=" + encodeURIComponent("<%=bean.getCname()%>");

</script>

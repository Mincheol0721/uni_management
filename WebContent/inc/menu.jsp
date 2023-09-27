<%@page import="member.EmployeeDAO"%>
<%@page import="member.StudentDAO"%>
<%@page import="member.ProfessorDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%!
	String job;
	String id;
	
	MemberDTO dto;
	String cname;
%>

<% 
	request.setCharacterEncoding("UTF-8"); 
	
	job = (String)session.getAttribute("job");
	id = (String)session.getAttribute("id");

	cname = request.getParameter("cname");
	dto = new MemberDTO();
	
	if(id != null) {
		ProfessorDAO pdao = new ProfessorDAO();
		StudentDAO sdao = new StudentDAO();
		EmployeeDAO edao = new EmployeeDAO();
		
		System.out.println("직업: " + job);
		System.out.println("id: " + id);
		
		
		if(job.equals("교수")){
			dto = pdao.selectMember(id);
		} else if(job.equals("학생")){
			dto = sdao.selectMember(id);
		} else if(job.equals("교직원")){
			dto = edao.selectMember(id);
		}
	}

%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<c:set var="job" value="${sessionScope.job}" />
<c:set var="id" value="${sessionScope.id}" />

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	</head>
	<body>
		<div class="sb-sidenav-menu">
			<div class="nav">
				<div class="sb-sidenav-menu-heading">메뉴</div>
				<a class="nav-link menu" href="${path}/index.jsp">홈</a>
				<a class="nav-link menu" href="${path}/menu/notice.jsp">공지사항</a>
				<a class="nav-link menu" href="${path}/menu/qna.jsp">질의응답</a>
				<a class="nav-link menu" href="${path}/menu/schedule.jsp">학사일정</a>
				<a class="nav-link menu" href="${path}/courseList/courseList_student.jsp">강의 목록</a>
				
		<c:choose>
			<c:when test="${job eq '교수'}">
				<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
					교수 전용메뉴
	                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
	            </a>
	            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
	                <nav class="sb-sidenav-menu-nested nav">
	                    <a class="nav-link" href="${path}/course/listCourse.jsp">전체강의 수정</a>
	                    <a class="nav-link" href="${path}/courseList/courseList_professor.jsp">세부강의 수정</a>
	                    <a class="nav-link" href="${path}/grade_professor/listGrade.jsp?propId=${sessionScope.id}">성적 관리</a>	                    
	                </nav>
	            </div>
			</c:when>
			<c:when test="${job eq '교직원'}">
				<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
					교직원 전용메뉴
	                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
	            </a>
	            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
	                <nav class="sb-sidenav-menu-nested nav">
	                    <a class="nav-link" href="${path}/employee/professorList.jsp">교수정보 관리 게시판</a>
	                    <a class="nav-link" href="${path}/employee/studentList.jsp">학생정보 관리 게시판</a>
	                </nav>
	            </div>
			</c:when>
			<c:when test="${job eq '학생'}">
				<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
					학생 전용메뉴
	                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
	            </a>
	            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
	                <nav class="sb-sidenav-menu-nested nav">
	                	<a class="nav-link menu" href="${path}/student/lecture.jsp">수강신청</a>
<%-- 	                	<a class="nav-link menu" href="${path}/student/cHistory.jsp">수강 강좌</a> --%>
	                	<a class="nav-link" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="true" aria-controls="pagesCollapseAuth">
	                		수강강좌
                            <div class="sb-sidenav-collapse-arrow"><svg class="svg-inline--fa fa-angle-down" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" data-fa-i2svg=""><path fill="currentColor" d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"></path></svg><!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com --></div>
                        </a>
                        <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages" style="">
                            <nav class="sb-sidenav-menu-nested nav">
                                <jsp:include page="cPlanMenu.jsp" />
                            </nav>
                        </div>
                    	<a class="nav-link menu" href="${path}/student/grade.jsp">성적</a>
                    	<a class="nav-link menu" href="${path}/student/info.jsp">학사정보</a>
                    	<a class="nav-link menu" href="${path}/lectureBoard/lectureNotice.jsp">강의평가 게시판</a>
						<a class="nav-link menu" href="${path}/courseList/courseList_student.jsp">강의리스트</a>
	                </nav>
	            </div>
			</c:when>
		</c:choose>
			</div>
		</div>
        <div class="sb-sidenav-footer">
        	<c:if test="${id ne null}">
	            <div class="small"><b><%=dto.getName() %>님 반갑습니다.</b></div>
        	</c:if>
        	<c:if test="${id eq null}">
	            <div class="small"><b>로그인 상태가 아닙니다.</b></div>
        	</c:if>
            
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

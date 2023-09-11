<%@page import="member.EmployeeDAO"%>
<%@page import="member.StudentDAO"%>
<%@page import="member.ProfessorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
	request.setCharacterEncoding("UTF-8"); 

	String path = request.getContextPath();
	
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	String job = request.getParameter("job");
	
	session.setAttribute("job", job);
	
	//3. 요청한 값을 이용해 웹브라우저로 응답할 값을 마련 (DB에 입력한 아이디,비밀번호가 저장되어 있는지 조회후 결과값)
	//DB에 저장된 ID -> "master" ,   DB에저장된 비밀번호 -> "1111"  값이라고 가정하고 시작!
	int pCheck = new ProfessorDAO().userCheck(id, pwd); 
	int sCheck = new StudentDAO().userCheck(id, pwd); 
	int eCheck = new EmployeeDAO().userCheck(id, pwd); 
	
	//교수로 로그인 시도 시
	if(job.equals("교수")) {
		//check변수값 1일때: 아이디 비밀번호 모두 같으니 session내장객체 메모리 영역에 로그인 처리 상태값을 입력한 id(교번으)로 저장
		//					  index.jsp 포워딩시 인클루드 되어 있는 member.jsp로 session메모리 공유하여 판단
		if(pCheck == 1) {
			session.setAttribute("id", id);

%>			
			<script>
				alert("로그인하셨습니다");
				location.href = "../index.jsp";
			</script>
<%		
			
			//check변수값 0일때: 비밀번호가 다르니 경고창 띄운 후 login.jsp로 포워딩 시 다시 입력 받을 수 있도록 유도
		} else if(pCheck == 0) {
%>			
			<script>
				window.alert("비밀번호가 틀렸습니다.");
				location.href = "login.jsp";
				document.fr.pwd.focus();
			</script>
<%	
		} else {
%>			
			<script>
				window.alert("아이디가 틀렸습니다.");
				location.href = "login.jsp";
				document.fr.id.focus();
			</script>
<%
		}
	} else if(job.equals("학생")) {
		//check변수값 1일때: 아이디 비밀번호 모두 같으니 session내장객체 메모리 영역에 로그인 처리 상태값을 입력한 id(교번으)로 저장
		//					  index.jsp 포워딩시 인클루드 되어 있는 member.jsp로 session메모리 공유하여 판단
		if(sCheck == 1) {
			session.setAttribute("id", id);
%>			
			<script>
				alert("로그인하셨습니다");
				location.href = "../index.jsp";
			</script>
<%			
			//check변수값 0일때: 비밀번호가 다르니 경고창 띄운 후 login.jsp로 포워딩 시 다시 입력 받을 수 있도록 유도
		} else if(sCheck == 0) {
%>			
			<script>
				window.alert("비밀번호가 틀렸습니다.");
				location.href = "login.jsp";
				document.fr.pwd.focus();
			</script>
<%	
		} else {
%>			
			<script>
				window.alert("아이디가 틀렸습니다.");
				location.href = "login.jsp";
				document.fr.id.focus();
			</script>
<%
		}
	} else if(job.equals("교직원")) {
		//check변수값 1일때: 아이디 비밀번호 모두 같으니 session내장객체 메모리 영역에 로그인 처리 상태값을 입력한 id(교번으)로 저장
		//					  index.jsp 포워딩시 인클루드 되어 있는 member.jsp로 session메모리 공유하여 판단
		if(eCheck == 1) {
			session.setAttribute("id", id);
%>			
			<script>
				alert("로그인하셨습니다");
				location.href = "../index.jsp";
			</script>
<%			
			//check변수값 0일때: 비밀번호가 다르니 경고창 띄운 후 login.jsp로 포워딩 시 다시 입력 받을 수 있도록 유도
		} else if(eCheck == 0) {
%>			
			<script>
				window.alert("비밀번호가 틀렸습니다.");
				location.href = "login.jsp";
				document.fr.pwd.focus();
			</script>
<%	
		} else {
%>			
			<script>
				window.alert("아이디가 틀렸습니다.");
				location.href = "login.jsp";
				document.fr.id.focus();
			</script>
<%
		}
	}
		
		
		
%>


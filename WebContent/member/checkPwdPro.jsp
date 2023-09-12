<%@page import="java.sql.Timestamp"%>
<%@page import="member.MemberDTO"%>
<%@page import="member.ProfessorDAO"%>
<%@page import="member.EmployeeDAO"%>
<%@page import="member.StudentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>OO대학교 - 회원정보 수정</title>
	</head>
	<body>
		<%
			//1. 요청한 값들 중에서 한글문자가 있을수 있으므로
			//   request객체 메모리에 저장된 요청한 한글문자 처리 방식을 UTF-8방식으로 설정
			request.setCharacterEncoding("UTF-8");
				
			//2. 요청한 값 request객체 메모리에서 얻기
			String id = (String)session.getAttribute("id");
			String pwd = request.getParameter("pwd");
			String job = (String)session.getAttribute("job");
			
			
			//System.out.println("id: " + id);
			//System.out.println("pwd: " + pwd);
			
			
			//2.1 요청한 값을 DB에 insert를 위해  MemberBean객체단위로 DAO에 전달하기 위해
			//    요청해서 얻은 값들을 MemberBean객체의 각변수에 저장 시켜야 합니다.
			MemberDTO dto = new MemberDTO();
			MemberDTO edto = new MemberDTO();
			
			//3. 응답할값을 마련 하기 위한 비즈니스로직 처리 
			ProfessorDAO pdao = new ProfessorDAO();
			StudentDAO sdao = new StudentDAO();
			EmployeeDAO edao = new EmployeeDAO();
			
			//회원 추가에 성공하면 1을 반환 받고 실패하면 0을 반환 받기 
			if(job.equals("교수")){
				if(pwd.equals( pdao.checkPwd(id) )) {
					response.sendRedirect("modMember.jsp");
				} else{
%>		
					<script type="text/javascript">
						window.alert("비밀번호가 틀렸습니다. \r\n다시 입력해주세요.");
						history.back();
					</script>
<%		
				}
				
			} else if(job.equals("학생")) {
				if(pwd.equals( sdao.checkPwd(id) )) {
					response.sendRedirect("modMember.jsp");
				} else{
%>		
					<script type="text/javascript">
						window.alert("비밀번호가 틀렸습니다. \r\n다시 입력해주세요.");
						history.back();
					</script>
<%		
				}
				
			} else if(job.equals("교직원")) {
				if(pwd.equals( edao.checkPwd(id) )) {
					response.sendRedirect("modMember.jsp");
				} else{
%>		
					<script type="text/javascript">
						window.alert("비밀번호가 틀렸습니다. \r\n다시 입력해주세요.");
						history.back();
					</script>
<%
				}
			} 
%>
	
	</body>
</html>







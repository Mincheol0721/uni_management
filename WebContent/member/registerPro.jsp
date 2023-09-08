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
		<title>OO대학교 - 회원가입</title>
	</head>
	<body>
		<%
			//1. 요청한 값들 중에서 한글문자가 있을수 있으므로
			//   request객체 메모리에 저장된 요청한 한글문자 처리 방식을 UTF-8방식으로 설정
			request.setCharacterEncoding("UTF-8");
				
			//2. 요청한 값 request객체 메모리에서 얻기
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String tel = request.getParameter("tel");
			String ssn = request.getParameter("ssn");
			String email = request.getParameter("email");
			String addr = request.getParameter("addr");
			String faculty = request.getParameter("faculty");
			String dept = request.getParameter("dept");
			
			String job = request.getParameter("job");
			
			/* 
			System.out.println("id: " + id);
			System.out.println("pwd: " + pwd);
			System.out.println("name: " + name);
			System.out.println("tel: " + tel);
			System.out.println("ssn: " + ssn);
			System.out.println("email: " + email);
			System.out.println("addr: " + addr);
			System.out.println("faculty: " + faculty);
			System.out.println("dept: " + dept);
			System.out.println("job: " + job);
			 */
			
			int result = 0;
			
			//2.1 요청한 값을 DB에 insert를 위해  MemberBean객체단위로 DAO에 전달하기 위해
			//    요청해서 얻은 값들을 MemberBean객체의 각변수에 저장 시켜야 합니다.
			MemberDTO dto = new MemberDTO(id, pwd, name, email, addr, tel, ssn, dept, faculty);
			MemberDTO edto = new MemberDTO(id, pwd, name, email, addr, tel, ssn);
			
			//3. 응답할값을 마련 하기 위한 비즈니스로직 처리 
			//   jspbeginner데이터베이스내부의 member테이블에  입력한 가입할 정보를 추가(insert) 하기 위해
			//   MemberDAO객체를 생성하여  MemberDAO에 만들어 놓은 insertMember메소드 호출시 매개변수로 MemberBean객체의 주소를 전달해서 작업
			ProfessorDAO pdao = new ProfessorDAO();
			StudentDAO sdao = new StudentDAO();
			EmployeeDAO edao = new EmployeeDAO();
			
			//회원 추가에 성공하면 1을 반환 받고 실패하면 0을 반환 받기 
			if(job.equals("교수")){
				result = pdao.insertMember(dto);
			} else if(job.equals("학생")) {
				result = sdao.insertMember(dto);
			} else if(job.equals("교직원")) {
				result = edao.insertMember(edto);
			}
			
			
			//4. result변수에 저장된 값이 1 이면   login.jsp를 재요청해 로그인을 위해 아이디와 패스워드를 입력하러 갑니다.
			if(result == 1){
				response.sendRedirect("login.jsp");
			}else{
		%>		
				<script type="text/javascript">
					window.alert("회원가입실패");
					history.back();
				</script>
		<%		
			}
			
		%>
	
	</body>
</html>







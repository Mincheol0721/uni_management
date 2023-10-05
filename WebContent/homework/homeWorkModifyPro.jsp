<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="file.FileDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	FileDAO fileDAO = new FileDAO();
	
	String numb = request.getParameter("numb");
	
//참고. application내장객체는 하나의 프로젝트의 모든 서버페이지에 값을 공유할 영역이고
		//	   하나의 프로젝트의 자원(경로,로그정보,데이터)을 관리하는 객체 입니다.
		//    서버(톰캣)의 실제 프로젝트 경로에서 자원을 찾을 때 가장 많이 사용합니다.
	
		//1. 실제 업로드할 폴더 위치 얻기 
		//참고. application내장객체의 getRealPath메소드는  프로젝트내의 리소스(폴더 또는파일)경로를 얻는데 사용됩니다.
		//	   이메소드는 프로젝트내부에서 현재 웹프로젝트 폴더 파일의 경로를 얻어오는 기능을 제공합니다.
		
		//	 예를 들어 getRealPath("/"); -> 프로젝트의 루트 경로를 만들어서 반환 해줍니다.
		//							    C:\workspace_web\FileUploadDownload\WebContent\	
		
		//  예를 들어  getRealPath("/WEB-INF/lib/cos.jar"); -> cos.jar파일이 저장된 프로젝트 내부의 실제 경로를 문자열로 반환해줌
		
		String path = application.getRealPath("/upload/");
		out.print(path + "<br>");
	
		String name = fileDAO.deleteSearch(numb);
		File file = new File(path + name);
		if (file != null) {
		    file.delete();
		}
		//C:\workspace_web\FileUploadDownload\WebContent\ upload \       
		
		//2. 한번에 업로드할 파일의 최대 사이즈 설정  1GB = 1024MB
		int maxSize = 1024 * 1024 * 1024;
		
		//3. cos.jar파일 에서 제공해주는 MultiPartRequest클래스에 대한 객체를 생성해서 요청받은 파일을 upload폴더에 업로드 시킵니다.
		//요약. 요청한 파일정보를 이용해 파일업로드
		//객체 생성시 생성자로 전달할 정보들
		//1. fileupload.jsp의 form태그에 의해서 전달받은 업로드할파일 정보를 가지고 있는 request객체 메모리 전달
		//2. 업로드할 파일의 실제 서버 폴더 경로 (C:\workspace_web\FileUploadDownload\WebContent\ upload \ )  <- path변수
		//3. 한번에 업로드될 파일의 최대 크기 값 <- maxSize변수
		//4. 업로드될 파일명이 한글일 경우 깨진 파일명으로 업로드되는것을 방지 하기 위해 파일명 문자셋 방식(인코딩 방식) UTF-8로 설정하기위해 전달
		//5. 업로드되는 실제 서버 폴더경로에  똑같은 이름의 파일을 업로드시  파일명끝에 1을 자동으로 붙여저 만들어주는 역할을 하는
		//   new DefaultFileRenamePlolicy()객체를 생성해서 전달
		MultipartRequest multipartRequest = new MultipartRequest(request,
																 path,
																 maxSize,
																 "UTF-8", 
																 new DefaultFileRenamePolicy());
		
		//4. 실제 업로드 하기 전의  파일업로드를 하기 위해 fileUpload.jsp에서 선택했던 원본파일명 얻기
		//   <input type="file" name="file"> 은 파일 업로드하기 위해 선택하는 <input>입니다.
		//   아래의 메소드 호출시 name속성의 값을 매개변수로 전달하면  실제 업로드하기전의 선택했던 원본파일명을 문자열로 얻는다.
		String fileName = multipartRequest.getOriginalFileName("file");
		
		//5. 실제 upload업로드폴더(실제 서버 업로드폴더경로)에  업로드된 실제 파일명 얻기 
		String fileRealName = multipartRequest.getFilesystemName("file");
		//글의 제목
		String title = multipartRequest.getParameter("title");
		//글의 본문
		String content = multipartRequest.getParameter("content");
		
		String cname = multipartRequest.getParameter("cname");
		
		String num = multipartRequest.getParameter("num");
		
		fileDAO.updateFile(title, content, fileName, fileRealName,num);
%>
	<script type="text/javascript">

		location.href = "homeWorkModify.jsp?num=<%=num%>&cname=<%=cname%>"
		alert("과제 수정 되었습니다.");
		</script>

<%@page import="file.FileDAO"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일다운로드 처리하는 서버페이지</title>
</head>
<body>
	<%
		//1. 한글처리
		request.setCharacterEncoding("UTF-8");
	
		//2. fileDownloadList.jsp페이지에서 다운로드할 파일명 <a>링크를 클릭했을때..
		//   전달받은  다운로드할 실제 파일명과  실제 업로드된 폴더명  upload얻기
		String fileRealName = request.getParameter("fileRealName");
		//   다운로드(업로드)파일이 저장된 다운로드할 실제 폴더 uload 경로 얻기
		String directory = application.getRealPath(request.getParameter("directory"));
		// C:\workspace_web\FileUploadDownload\WebContent\ upload
		
		//3. 물리적으로 존재하는 다운로드할 파일에 접근하기 위한 File객체 생성
		File file = new File(directory + "/" + fileRealName);
		
		//4. 클라이언트의 웹브라우저에 응답할 데이터를 파일데이터로 설정하기 위해 작성
		String mimeType= getServletContext().getMimeType(file.toString());
		
		if(mimeType == null){
			//이진 데이터 형식의 파일 관련 데이터를 웹브라우저 전달(응답)하기 위해 MIME-TYPE을 octet-stream 유형으로 설정
			response.setContentType("application/octet-stream"); //파일 다운로드 하기 위해 무조건 설정
		}
			
		//5. 한글 파일명을 가진 파일을 다운로드시 파일명이 깨져서 다운로드되는 현상을 피하기 위해 
		//   웹브라우저 종류 별로 서로 다른 대응이 필요합니다.
		
		//웹브라우저 종류별로 다운로드시킬 파일명에  대한 인코딩 설정 후 다시 저장할 파일명 변수
		String downloadName = null;
		
		//사용자가 어떤 웹브라우저를 사용해 파일 다운로드를 요청하는지 사용하고 있는 다운로드 요청시 사용하고 있는 웹브라우저 정보 얻기
		String header = request.getHeader("User-Agent");
		
		//인터넷잇스플로러, 엣지 (MSIE, Trident) 웹브라우저를 사용하는 사용자라면?
		if( header.contains("MSIE")  ||  header.contains("Trident") ){
			
			//다운로드시킬 파일명을 UTF-8로 변경하여 웹브라우저로 전달하게 되면
			//다운로드시킬 한글파일명이 깨지지 않고  웹브라우저로 전다로디어 다운로드되게 된다.
			//브라우저가 IE일 경우 다운로드될 파일 이름에 공백이 '+'로 인코딩된것을  다시 공백"%20"으로 바꿔준다.
			downloadName = URLEncoder.encode(fileRealName, "UTF-8").replaceAll("\\+", "%20");
			
			
		//인터넷잇스플로러, 엣지 (MSIE, Trident) 웹브라우저를 제외한 다른 모든 웹라우저를 사용해서 다운로드 요청한 사용자라면?
		}else{
			
			//브라우저가 엣지가 아닐경우 다운로드될 파일이름을 설정하는 부분
			
			//fileName.getBytes("UTF-8") 부분 설명
				//다운로드할 파일이름! 즉! 문자열이름을 전세계 거의 모든 문자를 포함한 체계(UTF-8)의 데이터로 사용하기 위해
				//문자열들을 바이트크기의 데이터들로 모두변환 하여 새로운 byte[]배열에 저장해 byte[]배열 자체를 반환 해 옵니다.
				//요약 : 다운로드 시킬 파일명을 인코딩 방식 UTF-8체계로 설정
			//new String( fileName.getBytes("UTF-8") , "8859_1"); 부분 설명
				//fileName.getBytes("UTF-8")코드 부분에서 다운로드할 파일명 문자열은 바이트 데이터들로 변환되어 byte[]배열에 저장되어 있기떄문에
				//byte[]배열에 저장된 다운로드할 파일명을 다시 웹브라우저로 전달 하여 다운로드 시킬때...
				//웹브라우저가 인식할수 있는 기본 인코딩 방식 8859_1쳬계로 변경 후 다운로드할 파일명을 변수에 저장시킨다.
			downloadName = new String( fileRealName.getBytes("UTF-8") , "8859_1");
			
			//참고
			//컴퓨터는 문자를 사람이 보듯이 컴퓨터에 저장 하는게 아니라
			//01010101 이런식으로 이진수로 변환해서 비트 단위로 저장합니다.
			//이것을 사람이 읽을수 있도록 문자로 표현 및 저장하는 규칙이 필요한데 이러한 것을 캐릭터 셋(문자를 처리하는 방식)이라고 부릅니다.
			//한국인 끼리 쓰는 시스템방식은 EUC-KR 캐릭터셋으로 문자를 사용하면 되지만
			//외국인에게도 서비스를 하려면 더많은 문자를 지원 해야할떄 UTF-8캐릭터 셋을 사용해 줍니다.
			
		}
		
		//6. 웹브라우저로 응답할 데이터(다운로드시킬 파일)을 response객체의 헤더영역에 설정하는 부분
			//1.다운로드 시킬 파일명 설정 
			//2.Content-Disposition속성을 명시하여 브라우저로 전송(응답)된 파일을 디스크에 직접 다운로드 받게 할것인지 혹은  브라우저로 바로 보여줄것인지 설정할수 있다.
			//  Content-Disposition :  inline  <--- 브라우저에서 응답을 받으면 브라우저에서 바로 보여 준다.
			//  Content-Disposition :  attachment <--- 다운로드하시겠습니까?라고 물어보는 창이 뜨게 된다.
		
		response.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName + "\";");
		
		//7. 다운로드할 파일에서 데이터를 읽어와 버퍼메모리 공간에 저장하고
		//  버퍼 메모리공간에 저장된 데이터를 웹브라우저로 출력할 스트림 통로 객체들 생성
		
		//다운로드할 파일을 바이트 단위로 읽어들일 new FileInputStream(file객체전달); 버퍼 메모리 공간 입력스트림 통로 생성
		FileInputStream fileInputStream = new FileInputStream( file );
		
		
		//읽어들인 다운로드할 파일의 데이터들을 new FileInputStream(file객체전달); 버퍼 메모리 공간에서 꺼내어서
		//바이트 단위로 웹브라우저에 출력(응답,다운로드)할 출력 스트림 통로 생성
		ServletOutputStream servletOutputStream = response.getOutputStream();
		
		/*
			일반적으로 화면은 JSP에 구현하고  기능은 JAVA파일에 구현한다.
			하지만 종종 JSP에 자바코드를 입력하여 구현하는 경우가 있다.
			만약 이때 다운로드 로직을 구현한다면 주의 할점
			
			클라이언트의 웹브라우저에 write 전에 로직을 추가해줘야 하는데
			만약 아래와 같은 로직 out.clear();  out= pageContext.pushBody();이 추가되지 않으면 다운로드에 영향을 미칠수 있습니다.
			그리고 Servlet.service() for servlet JSP throw exception
			     java.lang.IllegalStateException : getOutputStream() has already beean called for thos reponse
			위와 같은 에러 메세지를 받게 될것이다.
			
			이유는 JSP페이지에서 다른 JSP페이지를 호출해서 다운로드 로직을 실행하는 경우
			이미 출력스트림통로(out내장객체메모리)가 열려 있는 상태입니다.
			따라서 추가적으로 출력스트림을 열려고 하면 위와 같은 에러메세지를 생성하는 것입니다.
			그렇다면 out내장객체 사용하기 전에  출력스트림통로의 데이터를 한번비우고 깔끔하게 웹브라우저 전송해야 겠죠!
			out.clear(); <- 실행하면  스트림통로에 데이터들을 깔끔하게 비운다.
			그럼통로를 비웠으니 그통로를 지나갈 탈것이 필요하겠죠?
	        out = pageContext.pushBoay();  <- jsp페이지에 대한 정보를 저장하는 기능을 한다.
			여기서 말하는 jsp페이제 대한 정보라면 다운로드할 파일의 정보를 말하는 거겠죠?
			따라서 저기 두줄 의 정보를 작성하는 부분을 out출력스트림통로를 초기화시키는 작업을 한다고 생각하면 됩니다.
		*/
		out.clear();
		out = pageContext.pushBody();
		
		//8. 파일의 정보를 읽어들이고 웹브라우저로 내보내는 부분(다운로드할 파일 입출력)
		//다운로드할 파일에서 데이터를 1048576byte(1MB)단위로 읽어와 저장할 byte배열 생성
		byte[] b = new byte[1048576];
		
		while(true){
			//다운로드할 파일의 내용을 약1MB단위로 한번 ~~ 읽어와 변수에 저장
			int count = fileInputStream.read(b);
			
			if(count == -1){//다운로드할 파일에서 더이상 읽어 들일 데이터가 없으면(read메소드의 반환값이 -1이라면?)
				break; //더이상 읽어들이지 않고 whiel반복문을 빠져나감 
			}
			
			//다운로드할 파일에서 읽어들인 데이터가 있으면
			//한번씩 읽어들인 1048576byte(약1MB)전체를 출력스트림 통로를 통해 웹브라우저로 응답(내보내기)
			servletOutputStream.write(b, 0, count);	
		}
		
		//웹브라우저로 다운로드된 파일에 관하여 DB내부의  파일 다운로드 횟수 1증가 시키기 (UPDATE)
// 		new FileDAO().hit(fileRealName); 
		
		//출력 스트림 통로에 다운로드시킬 파일에서 읽어들인 데이터가 남아 있다면 완전히 웹브라우저로 내보내기
		servletOutputStream.flush();
	
		//자원해제 (입력, 출력 스트림통로)
		servletOutputStream.close();
		fileInputStream.close();
	%>




</body>
</html>





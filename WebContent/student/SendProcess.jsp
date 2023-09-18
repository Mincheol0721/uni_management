<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="smtp.NaverSMTP"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

//한글처리 
request.setCharacterEncoding("UTF-8");


// 폼값(이메일 내용) 저장
//Map<String, String> emailInfo: 이메일 관련 정보를 저장하는 HashMap 객체를 생성합니다.
Map<String, String> emailInfo = new HashMap<String, String>();

//폼에서 전달된 "from" 파라미터 값을 이메일 정보에 저장합니다. "from"은 보내는 사람의 이메일 주소입니다.
emailInfo.put("from", request.getParameter("from"));  // 보내는 사람의 이메일 주소

//폼에서 전달된 "to" 파라미터 값을 이메일 정보에 저장합니다. "to"는 받는 사람의 이메일 주소입니다
emailInfo.put("to", request.getParameter("to"));      // 받는 사람

//폼에서 전달된 "subject" 파라미터 값을 이메일 정보에 저장합니다. "subject"는 이메일의 제목입니다.
emailInfo.put("subject", request.getParameter("subject"));  // 제목


//폼에서 전달된 "content" 파라미터 값을 가져옵니다. 이것은 이메일 내용입니다.
String content = request.getParameter("content");  // 내용

// 폼에서 전달된 "format" 파라미터 값을 가져옵니다. 이것은 이메일의 포맷을 나타냅니다 (text 혹은 html).
String format = request.getParameter("format");    // 메일 포맷(text 혹은 html)

//전달받은 포맷에 따라 내용을 다르게 처리합니다.
if (format.equals("text")) {
    // 텍스트 포맷일 때는 그대로 저장
    emailInfo.put("content", content);
    emailInfo.put("format", "text/plain;charset=UTF-8");
}
else if (format.equals("html")) {
    // HTML 포맷일 때는 HTML 형태로 변환해 저장
    content = content.replace("\r\n", "<br/>");  // 줄바꿈을 HTML 형태로 수정

    String htmlContent = ""; //HTML 형식으로 변환된 내용을 담을 변수를 초기화합니다.
    try {
        //HTML 메일용 템플릿 파일의 경로를 얻어옵니다.
        String templatePath = application.getRealPath("/EmailSend/MailForm.html");
        
        //템플릿 파일을 읽기 위한 BufferedReader 객체를 생성합니다.
        BufferedReader br = new BufferedReader(new FileReader(templatePath));

        //이 변수는 파일에서 한 줄씩 읽은 내용을 저장할 용도로 사용됩니다.. 
        String oneLine;
        
        // while 루프를 통해 파일을 끝까지 읽는 작업을 수행합니다. 
        // br.readLine() 메서드를 호출하여 파일에서 한 줄을 읽어옵니다. 
        //  readLine()은 파일의 다음 줄을 읽고, 파일 끝에 도달하면 null을 반환합니다. 
        // 따라서 루프는 파일 끝에 도달할 때까지 실행됩니다.
        while ((oneLine = br.readLine()) != null) {
        	//현재 읽은 한 줄을 htmlContent 변수에 추가합니다. 
        	//+= 연산자를 사용하여 이전에 읽은 내용에 새로운 줄을 추가합니다. 
        	//oneLine은 현재 읽은 한 줄의 내용을 담고 있습니다. 
           //"\n"은 줄바꿈 문자를 나타내며, 각 줄을 읽을 때마다 새로운 줄로 추가됩니다.
            htmlContent += oneLine + "\n";
        }
        br.close();
    }
    catch (Exception e) {
        e.printStackTrace();
    }

    //템플릿 내의 __CONTENT__ 부분을 실제 이메일 내용으로 대체합니다.
    htmlContent = htmlContent.replace("__CONTENT__", content);
    // 변환된 내용을 저장
    //이메일의 내용을 설정하는 부분입니다. 위에서 HTML 형식의 내용을 htmlContent 변수에 저장하였습니다. 이렇게 저장한 HTML 형식의 내용을 emailInfo Map 객체의 "content" 키에 매핑하여 저장합니다. 
    //이렇게 저장된 내용은 이메일의 실제 내용으로 사용됩니다.
    emailInfo.put("content", htmlContent);
    //이메일 내용의 형식을 설정하는 부분입니다. 여기서는 HTML 형식으로 이메일을 보내기 위해 "format" 키에 "text/html;charset=UTF-8"을 설정합니다. 이렇게 설정된 형식은 이메일을 수신하는 측에서 이메일 내용을 HTML 형식으로 해석하도록 지시합니다. 
    //"text/html"은 HTML 형식을 나타내며, "charset=UTF-8"은 문자 인코딩을 UTF-8로 설정하는 것을 의미합니다.
    emailInfo.put("format", "text/html;charset=UTF-8");
}

try {
    NaverSMTP smtpServer = new NaverSMTP();  // 메일 전송 클래스 생성
    smtpServer.emailSending(emailInfo);      // 생성한 이메일 정보를 NaverSMTP 클래스의 emailSending 메서드로 전달하여 이메일을 전송합니다.
%>
	<script type="text/javascript">
		window.close();
		alert("이메일을 보냈습니다.")
	</script>
<%   
}
catch (Exception e) { //이메일 전송 시 예외가 발생하면 실패를 처리하고, 에러 메시지를 출력합니다.
%>
	<script type="text/javascript">
		window.close();
		alert("이메일을 보내는데 실패했습니다.");
	</script>
<%
    e.printStackTrace();
}
%>

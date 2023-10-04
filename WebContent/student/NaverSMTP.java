package smtp;

import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

// 네이버 SMTP 서버를 통해 이메일을 전송하는 클래스
public class NaverSMTP {
	
	//Properties serverInfo: 네이버 SMTP 서버 접속 정보를 담는 Properties 객체입니다. 
	//이 객체에는 SMTP 서버의 호스트, 포트, 보안 설정 등이 저장됩니다.
    private final Properties serverInfo; // 서버 정보
    
    //Authenticator auth: 사용자 인증 정보를 처리하는 Authenticator 클래스입니다. 
    //네이버 아이디와 패스워드를 사용하여 사용자 인증을 수행합니다.
    private final Authenticator auth;    // 인증 정보

    //NaverSMTP(): 생성자 메서드로, 네이버 SMTP 서버 접속 정보와 사용자 인증 정보를 설정합니다.
    public NaverSMTP() {
        // 네이버 SMTP 서버 접속 정보 설정
        serverInfo = new Properties();
        serverInfo.put("mail.smtp.host", "smtp.naver.com"); // SMTP 서버 호스트
        serverInfo.put("mail.smtp.port", "465"); // SMTP 서버 포트
        serverInfo.put("mail.smtp.starttls.enable", "true"); // STARTTLS 사용 여부
        serverInfo.put("mail.smtp.auth", "true"); // 인증 사용 여부
        serverInfo.put("mail.smtp.debug", "true"); // 디버그 모드 활성화
        serverInfo.put("mail.smtp.socketFactory.port", "465"); // 소켓 팩토리 포트
        serverInfo.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); // 소켓 팩토리 클래스
        serverInfo.put("mail.smtp.socketFactory.fallback", "false"); // 소켓 팩토리 실패 시 후속 조치

        // 사용자 인증 정보 설정
        auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("ID","Password");
            }
        };
    }

    //void emailSending(Map<String, String> mailInfo): 주어진 메일 내용을 네이버 SMTP 서버를 통해 전송하는 메서드입니다.
    public void emailSending(Map<String, String> mailInfo) throws MessagingException {
        // 1. 세션 생성
    	//serverInfo와 auth를 기반으로 세션을 설정하고, 디버그 모드를 활성화합니다.
        Session session = Session.getInstance(serverInfo, auth);
        session.setDebug(true); // 디버그 모드 활성화

        // 2. 메시지 작성
        //MimeMessage msg: Mime 형식의 메시지를 생성합니다. 보내는 사람, 받는 사람, 제목, 내용 등을 설정합니다.
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(mailInfo.get("from")),"fromName"); // 보내는 사람 설정
        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(mailInfo.get("to"))); // 받는 사람 설정
        msg.setSubject(mailInfo.get("subject")); // 제목 설정
        msg.setContent(mailInfo.get("content"), mailInfo.get("format")); // 내용과 포맷 설정

        // 3. 메시지 전송
//        Transport.send(msg): 생성한 메시지를 전송합니다. SMTP 서버를 통해 이메일이 전송됩니다.
        Transport.send(msg);
    }
}

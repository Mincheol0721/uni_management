package websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

//@ServerEndpoint 에너테이션으로 웹 소켓 서버의 요청명을 지정하여, 해당 요청명으로 접속하는 클라이언트를
//이 서블릿 서버페이지가 처리하게 합니다.
//요청 주소명이 /ChatingServer이므로 이 웹소켓에 접속하기 위한 전체 URL은 다음과 같습니다.
//->  ws://호스트:포트번호/컨텍스트루트/ChatingServer
//참고 - 웹 소켓은 http프로토콜이 아닌 ws프로트콜을 사용합니다.
@ServerEndpoint("/ChatingServer")
public class ChatServer {
	
    private static Set<Session> clients
            = Collections.synchronizedSet(new HashSet<Session>());

    @OnOpen  // 클라이언트 접속 시 실행
    public void onOpen(Session session) {
        clients.add(session);  // 세션 추가
        System.out.println("웹소켓 연결:" + session.getId());
    }

    @OnMessage  // 메시지를 받으면 실행
    public void onMessage(String message, Session session) throws IOException {
        System.out.println("메시지 전송 : " + session.getId() + ":" + message);
        synchronized (clients) {
            for (Session client : clients) {  // 모든 클라이언트에 메시지 전달
                if (!client.equals(session)) {  // 단, 메시지를 보낸 클라이언트는 제외
                    client.getBasicRemote().sendText(message);
                }
            }
        }
    }

    @OnClose  // 클라이언트와의 연결이 끊기면 실행
    public void onClose(Session session) {
        clients.remove(session); 
        System.out.println("웹소켓 종료 : " + session.getId());
    }

    @OnError  // 에러 발생 시 실행
    public void onError(Throwable e) {
        System.out.println("에러 발생");
        e.printStackTrace();
    }
}

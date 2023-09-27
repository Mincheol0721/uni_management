package NaverSearchAPI;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//네이버 검색 API 예제 - 블로그 검색
import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;


//http:localhost:8090/FunWeb/NaverSearchAPI.do?keyword=강남역맛집&startNum=1

@WebServlet("/popup.jsp")
public class SearchAPI extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			//1. 인증 정보 설정 
		    String clientId = "MfMQAZncqE32IkwIFr_5"; //애플리케이션 클라이언트 아이디
	        String clientSecret = "cKnhod7gPI"; //애플리케이션 클라이언트 시크릿
	        
	        
	        //2. 검색 조건 설정 
	        int startNum = 0; //검색 시작 위치 
	        
	        String text = null;//입력하는 검색어가 저장될 변수 
	        
	        try {
	        	System.out.println("받아오는 시작값: " + request.getParameter("startNum"));
	        	
	        	//검색 시작위치(startNum)와 입력한 검색(keyWord)어를 request에서 꺼내옵니다.
        		startNum = Integer.parseInt(request.getParameter("startNum"));
	        	String searchText = request.getParameter("keyword");
	        	System.out.println("searchText: " + searchText);
	        	System.out.println("startNum: " + startNum);
	        	//검색어는 한글 깨짐을 방지 하기 위해 UTF-8로 인코딩후 반환 받은 문자열을 저장시킵니다.
	        	text = URLEncoder.encode(searchText,"UTF-8");
	        	
	        	
	        } catch (UnsupportedEncodingException e) {
	            throw new RuntimeException("검색어 인코딩 실패",e);
	        }

	        //3. 요청하는 API URL조합 
//검색 결과 데이터를 JSON데이터로 받기 위한 요청할 API 주소작성
//검색어(query=text)쿼리 스트링으로 보낼수 있는데, 여기에 display파라미터와  start파라미터도 추가 했습니다.
//display파라미터는 한번에 가져올 검색결과의 개수 5을 설정 했으며,
//start파라미터는 검색 시작 위치 1로 설정 했습니다.	        
String apiURL = "https://openapi.naver.com/v1/search/blog?query=" + text + "&display=20&start=" + startNum;    // JSON 결과
//String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // XML 결과


			//4. API 호출 
			//클라이언트 아이디와 시크릿을 요청 헤더로 전달해 
	        Map<String, String> requestHeaders = new HashMap<>();
	        requestHeaders.put("X-Naver-Client-Id", clientId);
	        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
	        //API를 호출합니다.
	        String responseBody = get(apiURL,requestHeaders);


	        //5.검색된 결과를 출력하는 부분 
	        System.out.println(responseBody);
	        //검색된 결과 데이터들을 서블릿에서 웹브라우저로 출력(응답)
	        response.setContentType("text/html; charset=utf-8");
	        response.getWriter().write(responseBody);
		
		
	}//doHandle메소드 끝
	
	
  //get메소드 (doHandle메소드 안에서 호출하는 메소드)
   private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }


            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 오류 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }//get메소드 끝
	
   //get메소드 안에서 호출하는 메소드 
   private static HttpURLConnection connect(String apiUrl){
       try {
           URL url = new URL(apiUrl);
           return (HttpURLConnection)url.openConnection();
       } catch (MalformedURLException e) {
           throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
       } catch (IOException e) {
           throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
       }
   }

   //get메소드 안에서 호출하는 메소드 
   private static String readBody(InputStream body){
       InputStreamReader streamReader = new InputStreamReader(body);


       try (BufferedReader lineReader = new BufferedReader(streamReader)) {
           StringBuilder responseBody = new StringBuilder();


           String line;
           while ((line = lineReader.readLine()) != null) {
               responseBody.append(line);
           }


           return responseBody.toString();
       } catch (IOException e) {
           throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
       }
   }
	

}





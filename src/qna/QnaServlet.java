package qna;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/*
	JSON객체를 ajax로 요청받아 전달할 때, 날짜(Date)데이터는 문자열이 아닌것으로 간주되어
	JSONArray를 넘길 때 parsererror(파서에러)가 발생
	이 때, 날짜 데이터에 .toString()메소드를 호출하여 문자열로 변환해주거나 
	""안에 넣어주어 문자열로 변환하여 전달하면 parsererror를 피할 수 있음
*/

@WebServlet("/qnas/*")
public class QnaServlet extends HttpServlet {
	
    public QnaServlet() {}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
	    // JSON 응답 설정
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    PrintWriter out = response.getWriter();
	    
	    //요청한 값 얻기
	    
	    
	    QnaDAO dao = new QnaDAO();
	    
	    String nextPage = "";
	    
	    
		String action = request.getPathInfo();
		System.out.println("2단계 요청 주소: " + action);
		
		
        JSONArray jsonArray = new JSONArray(); // [ ]
        
        
        try {
			if(action == null) {
				int startRow = Integer.parseInt( request.getParameter("startRow") );
				int pageSize = Integer.parseInt( request.getParameter("pageSize") );
			    
//				System.out.println("startRow: " + startRow);
//				System.out.println("pageSize: " + pageSize);
//			    System.out.println("keyField: " + keyField);
//			    System.out.println("searchText: " + searchText);
				
				List<QnaDTO> list = dao.getBoardList(startRow, pageSize);
					
				for( QnaDTO dto : list ) {
					
					JSONObject jsonObject = new JSONObject();
					
					jsonObject.put("no", dto.getNo());
					jsonObject.put("title", dto.getTitle());
					jsonObject.put("content", dto.getContent());
					jsonObject.put("writeDate", dto.getWriteDate().toString());
					jsonObject.put("id", dto.getId());
					jsonObject.put("readCount", dto.getReadCount());
					
					jsonArray.add(jsonObject);
					
				} //for
				
			} else if(action.equals("/search.do")) {
				int startRow = Integer.parseInt( request.getParameter("startRow") );
				int pageSize = Integer.parseInt( request.getParameter("pageSize") );
				String keyField = request.getParameter("keyField");
			    String searchText = request.getParameter("searchText");
			    
//				System.out.println("startRow: " + startRow);
//				System.out.println("pageSize: " + pageSize);
//			    System.out.println("keyField: " + keyField);
//			    System.out.println("searchText: " + searchText);
				
				List<QnaDTO> list = dao.getBoardList(keyField, searchText, startRow, pageSize);
					
				for( QnaDTO dto : list ) {
					
					JSONObject jsonObject = new JSONObject();
					
					jsonObject.put("no", dto.getNo());
					jsonObject.put("title", dto.getTitle());
					jsonObject.put("content", dto.getContent());
					jsonObject.put("writeDate", dto.getWriteDate().toString());
					jsonObject.put("id", dto.getId());
					jsonObject.put("readCount", dto.getReadCount());
					
					jsonArray.add(jsonObject);
					
				} //for
				
			} 
				
			// 다음 페이지로 포워드하기 위한 디스패처 객체 생성
			//RequestDispatcher dispatch = request.getRequestDispatcher(nextPage); 
			//dispatch.forward(request, response); // 다음 페이지로 요청과 응답 객체를 포워드
			
			// JSON 데이터 전송  ( index.jsp의  $ajax메소드 구문의  succecc:function(data){} 의  data매개변수로 out.print호출시 전달한 JSONArray배열 )
			out.print(jsonArray.toString()); 
//				System.out.println("jsonArray: " + jsonArray.toString());
				
			// 다음 페이지로 포워드하기 위한 디스패처 객체 생성
//			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage); 
//			dispatch.forward(request, response); // 다음 페이지로 요청과 응답 객체를 포워드
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        
	}

}

package schedule;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import notice.NoticeDTO;

@WebServlet("/sched/*")
public class ScheduleServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//응답할 값 타입 및 문자처리방식 설정
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		//출력 스트림통로 객체 생성
		PrintWriter out = response.getWriter();
		
		String nextPage = "";
		//2단계 요청주소 얻기
		String action = request.getPathInfo();
		System.out.println("action: " + action);
		
		JSONArray jsonArray = new JSONArray();
		
		try {
			
			ScheduleDAO dao = new ScheduleDAO();
			
			if(action.equals("/selclass")) {
				List<ScheduleDTO> list = dao.getSClass();
//				System.out.println("list: " + list.size());
				
				for( ScheduleDTO dto : list ) {
					
					JSONObject jsonObject = new JSONObject();
					
					jsonObject.put("sclass", dto.getSclass());
					
					jsonArray.add(jsonObject);
				}
//				System.out.println("sclass: " + jsonArray.toString());
			}
			
			out.print(jsonArray.toString());
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}

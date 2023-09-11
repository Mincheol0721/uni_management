

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

import board_course.BoardBean;
import board_course.BoardDAO;



@WebServlet("/search.do")
public class SearchServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		response.setContentType("application/json");
		
		PrintWriter out = response.getWriter();
		
		//요청한 값 얻기
		String search = request.getParameter("search"); //선택한 검색 기준값
		String searchText = request.getParameter("searchText"); //입력한 검색어
		
		//SawonDao 객체를 생성해서 검색하는 메소드 호출
		List<BoardBean> list = new BoardDAO().getList();
		
		JSONArray jsonArray = new JSONArray();
	
		for (BoardBean bb : list) {
			
			JSONObject jsonObject = new JSONObject();
			
			jsonObject.put("ccode", bb.getCcode());
			jsonObject.put("cname", bb.getCname());
			jsonObject.put("compdiv", bb.getCompdiv());
			jsonObject.put("compyear", bb.getCompyear());
			jsonObject.put("compsem", bb.getCompsem());			
			jsonObject.put("grade", bb.getGrade());
			jsonObject.put("professor", bb.getProfessor());
			
			jsonArray.add(jsonObject);			
			
		}	
		
	}

}

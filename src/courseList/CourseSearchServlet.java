package courseList;


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
public class CourseSearchServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("search메소드 타고 있음");
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//JSON응답 설정
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		//요청한 값 얻기
		String search = request.getParameter("search"); //선택한 검색 기준값
		String searchText = request.getParameter("searchText"); //입력한 검색어
		int startRow = Integer.parseInt(request.getParameter("startRow"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		
		System.out.println("search : " + search);
		System.out.println("searchText : " + searchText);
		
		//CourseDAO 객체를 생성해서 검색하는 메소드 호출
		List<CourseBean> list = new CourseDAO().getList(search, searchText, startRow, pageSize);
		
		System.out.println(list.size());
		
		JSONArray jsonArray = new JSONArray();
	
		for (CourseBean bean : list) {
			
			JSONObject jsonObject = new JSONObject();
			
			jsonObject.put("grade", bean.getGrade());
			jsonObject.put("compyear", bean.getCompyear());
			jsonObject.put("compsem", bean.getCompsem());			
			jsonObject.put("cname", bean.getCname());
			jsonObject.put("professor", bean.getProfessor());
			jsonObject.put("compdiv", bean.getCompdiv());

			jsonArray.add(jsonObject);			
			
		}			
		//JSON 데이터 전송
		out.print(jsonArray.toString());
	}
}

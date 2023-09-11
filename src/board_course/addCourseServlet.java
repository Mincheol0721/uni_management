package board_course;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addCourseServlet")
public class addCourseServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("doPost타고있음");
		request.setCharacterEncoding("UTF-8");
		
		response.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = response.getWriter();

		//요청한 값 얻기
		String cname = request.getParameter("cname");
		String compdiv = request.getParameter("compdiv");
		String compyear = request.getParameter("compyear");	
		String compsem = request.getParameter("compsem");
		String grade = request.getParameter("grade");
		String professor = request.getParameter("professor");

		BoardBean bean = new BoardBean();
		
		bean.setCname(cname);
		bean.setCompdiv(compdiv);
		bean.setCompsem(Integer.parseInt(compsem));
		bean.setCompyear(Integer.parseInt(compyear));
		bean.setGrade(Integer.parseInt(grade));
		bean.setProfessor(professor);
		
		int result = new BoardDAO().insertSB(bean); 
		if (result == 1) {
			out.print("1");
		}else {
			out.print("0");
		}
		
	}
	
	
	
}

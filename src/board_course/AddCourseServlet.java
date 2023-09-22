package board_course;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addCourse.do")
public class AddCourseServlet extends HttpServlet{

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("add메소드 타고 있음");
		request.setCharacterEncoding("UTF-8");
		
		response.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = response.getWriter();

		String cname = request.getParameter("cname");
		String compdiv = request.getParameter("compdiv");
		String compyear = request.getParameter("compyear");	
		String compsem = request.getParameter("compsem");
		String grade = request.getParameter("grade");
		String ctime = request.getParameter("ctime");
		String professor = request.getParameter("professor");
		String id = request.getParameter("id");
		
		BoardBean bean = new BoardBean();
		
		bean.setCname(cname);
		bean.setCompdiv(compdiv);
		bean.setCompsem(Integer.parseInt(compsem));
		bean.setCompyear(Integer.parseInt(compyear));
		bean.setGrade(Integer.parseInt(grade));
		bean.setCtime(ctime);
		bean.setProfessor(professor);
		bean.setId(id);
		
		int result = new BoardDAO().insertSB(bean); 
		if (result == 1) {
			out.print("1");
		}else {
			out.print("0");
		}		
	}
}



import java.io.BufferedReader;
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

import com.mysql.cj.xdevapi.JsonParser;

import faculty.DeptDAO;
import faculty.DeptDTO;
import faculty.FacultyDAO;
import faculty.FacultyDTO;


@WebServlet("/register.do")
public class AjaxServlet extends HttpServlet {
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글처리
		request.setCharacterEncoding("UTF-8");
	     // JSON 응답 설정
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        DeptDAO dao = new DeptDAO();
        
        //요청한 값 얻기
        String fname = request.getParameter("fname");
        int fcode = dao.getFcode(fname);
        
        System.out.println("fname: " + fname);
        System.out.println("fcode: " + fcode);
		
		//SawonDao객체를 생성해서 검색하는 메소드 호출
		List<DeptDTO>  list = new DeptDAO().dList();
		List<DeptDTO>  list2 = new DeptDAO().dList(fcode);

		// JSON 배열을 생성하고 SawonDto 객체들을 JSON 객체로 변환하여 배열에 추가
        JSONArray jsonArray = new JSONArray(); // [ ]
        JSONArray jsonArray2 = new JSONArray(); // [ ]
        
        for (DeptDTO dto : list) {
        	
        	JSONObject jsonObject = new JSONObject(); 
        	    	
        	jsonObject.put("fcode", dto.getFcode());
        	jsonObject.put("fname", dto.getFname());
        	jsonObject.put("dcode", dto.getDcode());
        	jsonObject.put("dname", dto.getDname());
        	
        	jsonArray.add(jsonObject);
        }
        
        for (DeptDTO dto : list2) {
        	
        	JSONObject jsonObject = new JSONObject(); 
        	
        	jsonObject.put("fcode", dto.getFcode());
        	jsonObject.put("fname", dto.getFname());
        	jsonObject.put("dcode", dto.getDcode());
        	jsonObject.put("dname", dto.getDname());
        	
        	jsonArray2.add(jsonObject);
        }
		
        // JSON 데이터 전송  ( index.jsp의  $ajax메소드 구문의  succecc:function(data){} 의  data매개변수로 out.print호출시 전달한 JSONArray배열 )
        out.print(jsonArray.toString());
        out.print(jsonArray2.toString());
	}

}








package member;


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

import faculty.DeptDAO;
import faculty.DeptDTO;
import faculty.FacultyDAO;
import faculty.FacultyDTO;

@WebServlet("/register/*")
public class RegisterServlet extends HttpServlet {

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
        String id = request.getParameter("id");
        String job = request.getParameter("job");
        
        ProfessorDAO pDao = null;
        StudentDAO sDao = null;
        EmployeeDAO eDao = null;
        MemberDTO mDto = null;
        
        String fname = request.getParameter("fname");
        int fcode = new DeptDAO().getFcode(fname); 
        
        List<FacultyDTO> flist = new FacultyDAO().fList();
  		List<DeptDTO>  dlist = new DeptDAO().dList(fcode);

  		String nextPage = "";
		
		String action = request.getPathInfo();
		//System.out.println("2단계 요청 주소: " + action);
		
        JSONArray jsonArray = new JSONArray(); // [ ]
        
		if(action.equals("/faculty.do")) {
			FacultyDAO dao = new FacultyDAO();
			
	        for (FacultyDTO dto : flist) {
	        	JSONObject jsonObject = new JSONObject(); 
	        	
	        	jsonObject.put("fname", dto.getFname());
	        	jsonObject.put("fcode", dto.getFcode());
	        	
	        	jsonArray.add(jsonObject);
	        } //for
	        
		} else if(action.equals("/dept.do")) {
			for (DeptDTO dto : dlist) {
				JSONObject jsonObject = new JSONObject();   
				
				
	        	jsonObject.put("fcode", dto.getFcode());
	        	jsonObject.put("fname", dto.getFname());
	        	jsonObject.put("dcode", dto.getDcode());
	        	jsonObject.put("dname", dto.getDname());
	        	
	        	jsonArray.add(jsonObject);
	        } //for
			
		} else if(action.equals("/checkPid.do")) {
			
			response.setContentType("text/html");
			
			//System.out.println("job: " + job);
			
			if(job.equals("교수")) {
				JSONObject jsonObject = new JSONObject(); 
				
				pDao = new ProfessorDAO();
				int check = pDao.idCheck(id);
				
				if(check == 1) {
					jsonObject.put("cnt", 1);
		        	
		        	jsonArray.add(jsonObject);
				} else {
					jsonObject.put("cnt", 0);
		        	
		        	jsonArray.add(jsonObject);
				}
				
			}
        	
        } else if(action.equals("/checkSid.do")) {
        	JSONObject jsonObject = new JSONObject(); 
        	
        	if(job.equals("학생")) {
            	sDao = new StudentDAO();
            	int check = sDao.idCheck(id);
    			
            	if(check == 1) {
					jsonObject.put("cnt", 1);
		        	
		        	jsonArray.add(jsonObject);
				} else {
					jsonObject.put("cnt", 0);
		        	
		        	jsonArray.add(jsonObject);
				}
    			
    		}
        	
        } else if(action.equals("/checkEid.do")) {
        	JSONObject jsonObject = new JSONObject(); 
        	
			if(job.equals("교직원")) {
				eDao = new EmployeeDAO();
				
	        	int check = eDao.idCheck(id);
	        	
	        	if(check == 1) {
					jsonObject.put("cnt", 1);
		        	
		        	jsonArray.add(jsonObject);
				} else {
					jsonObject.put("cnt", 0);
		        	
		        	jsonArray.add(jsonObject);
				}
				
			}
        	
        }
		
    	//System.out.println(job);
		//System.out.println(jsonArray.toString());
		
		// JSON 데이터 전송  ( index.jsp의  $ajax메소드 구문의  succecc:function(data){} 의  data매개변수로 out.print호출시 전달한 JSONArray배열 )
		out.print(jsonArray.toString()); 
        
        
	}
}

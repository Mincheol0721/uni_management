package file;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/*
	파일 업로드를 처리하는 서블릿인 FileUpload 클래스 입니다.
	라이브러리에서 제공하는 DiskGileItemFactory 클래스를 이용해
	저장 위치와 업로드 가능한 최대 파일 크기를 설정 합니다.
	그리고 ServletFileUpload클래스를 이용해 파일 업로드 창에서 업로드된 파일과 매개변수에 대한 정보를 가져와 파일을 업로드하고
	매개변수 값을 출력 합니다.
*/
@WebServlet("/upload.do")
public class FileUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String encoding = "utf-8";
		
		//업로드할 파일 경로와 연결된 File객체 생성
		File currentDirPath = new File("C:\\file_repo");
		
		//업로드 할 파일 데이터를 임시로 저장할 객체 메모리 생성
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		factory.setSizeThreshold(1024 * 1024 * 1); //파일 업로드시 ~ 사용할 임시 메모리 최대 크기 1메가 바이트로 지정
		factory.setRepository(currentDirPath); //임시 메모리에 파일 업로드시~ 지정한 1메가 바이트 크기를 넘길 경우 업로드될 파일 경로를 지정함.
		
		//참고
		//DiskFileitemFactory 클래스는 업로드 파일의 크기가 지정한 크기를 넘기 전까지는
		// 업로드 한 파일 데이터를 메모리를 저장하고 지정한 크기를 넘길 경우 임시 디렉터리에 파일로 저장한다.
		
		//파일을 업로드할 메모리를 생성자쪽으로 전달받아 저장한!!!! 파일업로드를 처리할 객체 생성
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		try {
			//업로드할 파일에 대한 요청 정보를 가지고 있는 request객체를 parseRequest()메소드 호출시 인자로 전달 하면
			//request객체에 저장되어 있는 업로드할 파일의 정보들을 파싱해서 DiskFileItem객체에 저장후
			//DiskFileItem객체를 ArrayList에 추가 합니다. 그후  ArrayList를 반환 받습니다.
			List items = upload.parseRequest(request);
			
			//ArrayList 크기만큼(DiskFileItem객체(업로드할 아이템 하나의 정보)의 갯수만큼) 반복
			for (int i = 0; i < items.size(); i++) {
				//ArrayList 가변 배열에서..DiskFileItem객체(업로드할 아이템 하나의 정보를 말함)를 얻는다.
				FileItem fileItem = (FileItem)items.get(i);
				
				//DiskFileItem객체(업로드할 아이템 하나의 정보)가 파일 아이템이 아닐 경우
				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
				}else {// DiskFileItem객체(업로드할 아이템 하나의 정보)가 파일 아이템 일 경우 업로드 진행!!
					System.out.println("파라미터명:" + fileItem.getFieldName());
					System.out.println("파일명:" + fileItem.getName());
					System.out.println("파일크기:" + fileItem.getSize() + "bytes");
					
					//파일크기가 0보다 크다면(업로드할 파일이 있다면)
					if (fileItem.getSize() > 0) {
						//업로드할 파일명을 얻어 파일명의 뒤에서 부터 \\ 문자열이 들어 있는지 인덱스 위치를 알려주는데.. 없으면 -1을 반환함.
						int idx = fileItem.getName().lastIndexOf("\\"); //위에서 부터 문자가 들어있는 인덱스를 알려준다.
						
						System.out.println(idx);
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/"); //-1얻기
							System.out.println("안녕: " + idx);
						}
						//업로드할 파일 명 얻기
						String fileName = fileItem.getName().substring(idx + 1);
						//업로드할 파일 경로 + 파일명에 대한 객체 생성
						File uploadFile = new File(currentDirPath + "\\" + fileName);
						//실제 파일 업로드
						fileItem.write(uploadFile);
					}// end if
				}// end if
			}// end for
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("FileUpload클래스에서 오류 발생");
		}
	}
}

package board_course;

public class BoardPage {
	
//	   totalCount  전체 게시물의 개수,
//	   pageSize 한페이지에 출력할 게시물의 개수,
//	   blockPage 한 화면(블록)에 출력할 페이지 번호의 개수,
//	   pageNum  현재 보여지는(현재 클릭한) 페이지 번호,
//	   reqUrl  실행된 목록 파일명
	     
    public static String pagingStr(int totalCount, int pageSize, int blockPage, int pageNum, String reqUrl) {
    	System.out.println("pageSize : " + pageSize);
    	System.out.println("totalCount : " + totalCount);
    	System.out.println("blockPage : " + blockPage);
    	System.out.println("pageNum : " + pageNum);
    	System.out.println("reqUrl : " + reqUrl);
    	
    	String pagingStr = "";

    	//단계3. 전체 페이지 수를 계산 합니다.
    	//계산식 : Math.ceil(전체 게시물 수 / 한페이지에 출력할 게시물의 개수)
    	//       Math.ceil(totalCount / pageSize)
    	//계산 예:
    	//- 게시물 수가 총 105개 이면?
    	//  전체 페이지 수는?   Math.ceil(105/10)   ->  Math.ceil(10.5)  =   전체 페이지 수는  11 이다.
        int totalPages = (int) (Math.ceil(((double) totalCount / pageSize)));

        // 단계 4 : '이전 페이지 블록 바로가기' 출력
        //계산식 : (((현재 클릭한 페이지번호 - 1) / 한 화면(블록)에 출력할 페이지 번호의 개수 * 한 화면(블록)에 출력할 페이지 번호의 개수)) + 1;
        //계산 예:
        //       현재 클릭한 페이지번호가 1페이지번호 일때..	
        //       (((pageNum - 1) / blockPage) * blockPage) + 1;
        //       (((1       - 1) /         5) *     5   ) + 1;   
        //       (               0           *     5   ) + 1;
        //                                   0            + 1;
        //                                            1
        
        //계산 예:
        //       현재 클릭한 페이지번호가 5페이지번호 일때..	
        //       (((pageNum - 1) / blockPage) * blockPage) + 1;
        //       (((5       - 1) /         5) *     5   ) + 1;   
        //       (               0           *     5   ) + 1;
        //                                   0            + 1;
        // 												1
        //참고. pageTemp변수가 1이라 함은 첫 번째 페이지 블록을 뜻하므로  [이전 블록] 바로가기 <a>태그를 출력하지 않습니다.
        
        //계산 예:
        //       현재 클릭한 페이지번호가 6페이지번호 일때..	
        //       (((pageNum - 1) / blockPage) * blockPage) + 1;
        //       (((6       - 1) /         5) *     5   ) + 1;   
        //       (               1           *     5   ) + 1;
        //                                   5            + 1;
        // 												6
        
        //계산 예:
        //       현재 클릭한 페이지번호가 10페이지번호 일때..	
        //       (((pageNum - 1) / blockPage) * blockPage) + 1;
        //       (((10       - 1) /         5) *     5   ) + 1;   
        //       (               1           *     5   ) + 1;
        //                                   5            + 1;
        // 												6
        //참고. pageTemp변수에는   1 , 2 , 3, 4 , 5 페이지 번호! 즉! 각 페이지 번호를 클릭했을때 페이지번호가 위치한 블럭 위치를 계산해서 저장합니다.
        int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1;
        
        //참고. pageTemp변수가 1이 아닌 6 또는 다른 값일때는  (pageTemp-1) 계산결과로  [이전블록] 바로가기 <a>를 출력합니다.
        //     즉, 이전 페이지 블록은  5가 됩니다.
        if (pageTemp != 1) {
            pagingStr += "<a href='" + reqUrl + "?pageNum=1' class='page-link'>첫 페이지</a>";
            pagingStr += "&nbsp;";
            pagingStr += "<li class='page-item'><a href='" + reqUrl + "?pageNum=" + (pageTemp - 1) + "' class='page-link'>  <  </a></li>";
        }

        // 단계 5 : 각 페이지 번호 출력를 출력합니다.
        // 		   단계4에서 계산한 pageTemp(현재 클릭한 페이지 번호가 위치한 블럭 위치)를   
        //        blockPage 한 화면(블록)에 출력할 페이지 번호의 개수 만큼 반복하면서 + 1연산후 출력합니다.
        //계산 예 :  
        // pageTemp가 1일때  : "1 2 3 4 5"페이지 번호를 하단에 반복해서 출력합니다.
        // pageTemp가 6일때  : "6 7 8 9 10"페이지 번호를 하단에 반복해서 출력합니다.
        
        int blockCount = 1; // 페이지 번호를 5번 반복해서 보여 주기 위한 조건값 
        
        //  blockCount변수 값이   blockPage 한 화면(블록)에 출력할 페이지 번호의 개수보다 작거나 같고!!! 
        //  각 페이지 번호를 클릭했을때 페이지번호가 위치한 블럭 위치 pageTemp값이 전체 페이지 수보다 작거나 같으면  반복 합니다. 
        while (blockCount <= blockPage && pageTemp <= totalPages) {
//        		 1        <=    5      &&    1     <=   11
//               2        <=    5      &&    2     <=   11
//        		 3        <=    5      &&    3     <=   11
//        		 4        <=    5      &&    4     <=   11                         
//        		 5        <=    5      &&    5     <=   11      
//        		 6        <=    5      &&    6     <=   11      
                		                
        	//현재 페이지에서는 링크를 걸지 않기 위해 조건식을 사용했습니다. 
            if (pageTemp == pageNum) {
                // 현재 페이지는 링크를 걸지 않음
                pagingStr += "&nbsp;<a class='page-link'>" + pageTemp + "</a>&nbsp;";
            } else {
                pagingStr += "&nbsp;<a href='" + reqUrl + "?pageNum=" + pageTemp + "' class='page-link'>" + pageTemp + "</a>&nbsp;"; //1  2  3  4  5
            }
            pageTemp++; //pageTemp를 1씩 증가 시키면서  페이지번호를 만듭니다.         2  3  4  5  6
            blockCount++; //   2  3  4  5  6
        }

        // 단계 6 : '다음 페이지 블록 바로가기' 출력      
        //pageTemp변수에 저장된 값이 전체 페이지 수 이하일때 
        if (pageTemp <= totalPages) {
            // 각 페이지 번호를 출력한 후  pageTemp + 1 하여  [다음 블록] 바로가기 <a>를 설정합니다.
            // 즉, 마지막 페이지 번호가 5라면  다음페이지6의  블록은  6이 됩니다.
            pagingStr += "<li class='page-item'><a href='" + reqUrl + "?pageNum=" + pageTemp+ "' class='page-link'>  >  </a></li>";  
            pagingStr += "&nbsp;";
            //[마지막 페이지] 링크를 출력합니다.(마지막 페이지가 포함된 블록으로 이동하면 이영역은 출력되지 않습니다) 
            //마지막 페이지로 바로라기 링크는 pageNum값으로 전체 페이지 수를 사용합니다. 
            pagingStr += "<a href='" + reqUrl + "?pageNum=" + totalPages + "' class='page-link'>마지막 페이지</a>";
        }

        return pagingStr;
    }
}

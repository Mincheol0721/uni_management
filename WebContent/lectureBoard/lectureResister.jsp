<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//요청한값 얻기
	String professorName =request.getParameter("professorName");
	String lectureName = request.getParameter("lectureName");
	String lectureDivide =request.getParameter("lectureDivide");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
				</div>
				<div class="modal-body">
					<form action="lecturePro.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>강의명</label>
								<input type="text" name="lectureName" class="form-control" maxlength="20" value="<%=lectureName%>" readonly="readonly"/>
							</div>
							<div class="form-group col-sm-6">
								<label>교수명</label>
								<input type="text" name="professorName" class="form-control" maxlength="20" value="<%=professorName%>" readonly="readonly"/>
							</div>
							<div class="form-group col-sm-6">
								<label>학생이름</label>
								<input type="text" name="name" class="form-control" maxlength="20"/>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>수강 연도</label>
								<select name="lectureYear" class="form-control">
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
									<option value="2023" selected>2023</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>수강 학기</label>
								<select name="semesterDivide" class="form-control">
									<option value="1학기" selected>1학기</option>
									<option value="2학기">2학기</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>강의 구분</label>
								<select name="lectureDivide" class="form-control">
									<option value="전공필수" selected>전공필수</option>
									<option value="전공선택">전공선택</option>
									<option value="교양">교양</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" class="form-control" aria-describedby="basic-addon1" name="title">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" style="height: 100px" name="mainText"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>강의</label>
								<select name="rate" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" onclick="window.close()">취소</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
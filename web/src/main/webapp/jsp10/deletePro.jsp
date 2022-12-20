<%@page import="web.jsp10.model.ImgSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePro</title>
</head>
<%
	String id = (String)session.getAttribute("memId"); // session에서 꺼내기 (안넘어옴)
	String pw = request.getParameter("pw"); // 사용자가 입력한 pw 꺼내기 (넘어옴) 
	
	ImgSignupDAO dao = new ImgSignupDAO(); 
	int check = dao.idPwCheck(id, pw);
	if(check == 1) { // id,pw 맞다 
		
		// (save폴더에 남아있는 회원 사진 삭제)
		// db에서 회원사진파일명가져오기 (default_image.png 아닌것 확인하고 지우기)
		// save실제 파일경로 찾아서 뒤에 회원사진파일명 붙히고 
		// 최종 경로로 File 객체 만들어 file.delete() 로 실제 파일 삭제 
		
		dao.deleteMember(id);  // db에서 삭제 
		session.invalidate(); // 탈퇴시 로그아웃 처리 
		response.sendRedirect("main.jsp"); // 탈퇴후 main으로 이동 
		
	}else{ // pw 안맞다 %>
		<script>
			alert("비밀번호가 맞지 않습니다... 다시 시도해주세요...");
			history.go(-1);
		</script>	
<%	}
%>

<body>

</body>
</html>
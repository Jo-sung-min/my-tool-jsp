<%@page import="web.jsp10.model.ImgSignupDTO"%>
<%@page import="web.jsp10.model.ImgSignupDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입 처리</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	ImgSignupDTO member = new ImgSignupDTO();
%>

<%
	// 파일업로드처리시 <jsp:setProperty > 사용불가 
	String path = request.getRealPath("save"); // 서버상의 save 폴더 경로 찾기
	System.out.println(path);
	int max = 1024*1024*5; // 파일 최대 크기 
	String enc = "UTF-8"; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp); // 실제 파일은 저장
	
	member.setId(mr.getParameter("id"));
	member.setPw(mr.getParameter("pw"));
	member.setName(mr.getParameter("name"));
	member.setGender(mr.getParameter("gender"));
	//System.out.println("email : " + mr.getParameter("email"));
	if(mr.getParameter("email") == null || mr.getParameter("email").equals("")){ // 사용자가 이메일 작성 안했을경우 
		//System.out.println("email == null");
		member.setEmail("none");
	}else{ // 사용자가 이메일을 작성했을경우 
		//System.out.println("email != null");
		member.setEmail(mr.getParameter("email"));
	}
	// 실제 save 폴더에 저장된 파일명을 dto에 담기 (파일명 중복처리되서 저장되므로, 원본이름X)
	if(mr.getFilesystemName("photo") != null){ // 파일을 업로드했을 경우 
		member.setPhoto(mr.getFilesystemName("photo"));
	}else { // 파일 업로드를 안했을 경우 
		member.setPhoto("default_image.png");
	}
	
	// DB가서 저장해~~ 
	ImgSignupDAO dao = new ImgSignupDAO(); 
	dao.insertMember(member);   
	
	// 처리 후 main 페이지로 이동 
	response.sendRedirect("main.jsp");
%>

<body>

</body>
</html>




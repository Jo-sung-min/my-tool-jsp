<%@page import="web.jsp10.model.ImgSignupDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="web.jsp10.model.ImgSignupDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modifyPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	ImgSignupDTO member = new ImgSignupDTO();
	
	// MultipartRequest 생성 
	String path = request.getRealPath("save");
	System.out.println(path);
	int max = 1024*1024*5; 
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp); 
	
	// DB에 수정 반영 (넘어온 데이터 dto에 체우고 dao에 전달해서 반영시키기)
	// update imgSignup set pw=?, email=?, photo=? where id=?;
	// 넘어오는 데이터 : pw, email, photo, exPhoto
	String id = (String)session.getAttribute("memId");
	member.setId(id); // modify폼에서 id 안넘어와 세션에서 꺼내서 체우기 
	member.setPw(mr.getParameter("pw")); 
	member.setEmail(mr.getParameter("email"));
	if(mr.getFilesystemName("photo") != null){ // 사용자가 파일 업로드 태그에 뭔가 올렸을때 
		member.setPhoto(mr.getFilesystemName("photo")); // 사용자가 이미지 수정했을경우
	}else { // 파일업로드 태그 사용X 
		// 기존에 사진 없고, 지금도 안올렸고 (default_image.png)
		// 기존에 사진 있고, 지금은 안올렸고 (기존 이미지 파일명)
		member.setPhoto(mr.getParameter("exPhoto"));    
	}
	
	ImgSignupDAO dao = new ImgSignupDAO(); 
	int check = dao.updateMember(member); // 위에서 수정할정보 체운 dto 보내서 수정처리 
	// 수정 잘됐으면 1, 잘 안됐으면 0  
	
%>
<body>
	<%	if(check == 1) { %>
		<script>
			alert("수정 완료!!!!");
			window.location.href = "mypage.jsp";
		</script>
	<%	}else{  %>
		<script>
			alert("수정 실패... 다시 시도해주세요...");
			history.go(-1);
		</script>
	<%	} %>

</body>
</html>
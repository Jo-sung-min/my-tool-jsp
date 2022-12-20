<%@page import="web.jsp09.model.UploadDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>upload Pro</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");

	/*
			 MultipartRequest 객체 생성시, 필요한 인자들.
			1. request 내장 객체
			2. 업로드 될 파일 저장 경로
			3. 업로드 할 파일 최대 크기
			4. 인코딩 타입 : UTF-8
			5. 업로드된 파일 이름이 같을경우에 덮어씌우기 방지객체 필요
	*/




	// 2 브라우저에서 보낸 파일을 저장할 서버측에 저장 경로
	// 2-1. PC에 저장 : (서버쪽 x, 서버가있는 내 PC 에 저장)-
	//				업로드된 이미지를 다시 서비스(사용자가 볼수있게) 해줄수 없다.
	
	//	String path = "c:\\tmp\\"; 이게 문제가 되는것
	//	2-2 서버상에 경로로 파일 저장해야 사용자가 볼 수 있다.
		String path = request.getRealPath("save"); // 서버상의 savd 폴더의 실제 경로 찾기
		System.out.println(path);	
	
	//3. 업로드 할 파일 최대 크키
		int max =1024*1024*5; // 5M(메가)
	//4. 인코딩
		String enc = "UTF-8";
	// 5. 덮어씌우기 방지 객체 이걸 설정하면 업로드파일이름이 중복되면 이름을 바꿔서 올려줌
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	
	// MultipartRequest 객체 생성
		MultipartRequest mr = new MultipartRequest(request, path , max , enc , dp);
		
	// 파라미터 받기
		String writer = mr.getParameter("writer");
		String sysName = mr.getFilesystemName("upload"); // 업로드된 파일 이름
		String orgName=mr.getOriginalFileName("upload");//파일의 원본이름
		String contentType = mr.getContentType("upload"); //파일의 종류를 알려줌 : 사진 , 글...
	
		
	// DB에 저장	
		UploadDAO dao = new UploadDAO();
		dao.insertData(writer,sysName);
		

%>

<body>
	<h1>upload page</h1>
	<h2>작성자 : <%=writer %></h2>
	<h2>업로드 파일명: <%=sysName %></h2>
	<h2>파일 원본이름 : <%=orgName %></h2>
	<h2>컨텐트 타입(파일종류) : <%=contentType %></h2>
	
	<img src="/web/save/<%=sysName%>" width="300px"/>


</body>
</html>
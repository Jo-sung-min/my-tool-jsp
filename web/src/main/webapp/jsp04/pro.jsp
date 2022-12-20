
<%@page import="web.jsp04.test.TestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pro</title>
</head>
<%
		request.setCharacterEncoding("UTF-8");
		// 넘어온 데이터 다 꺼내기
		String id =request.getParameter("id");
		String pw =request.getParameter("pw");
		int age = Integer.parseInt(request.getParameter("age"));
		
		// DB 접속해서 테이블에 레코드 하나 추가 
			TestDAO dao = new TestDAO();
			dao.insertMember(id, pw, age);

%>

<body>

 <h1>pro pro</h1>


</body>
</html>
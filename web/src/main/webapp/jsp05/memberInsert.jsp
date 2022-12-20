<%@page import="web.jsp05.test.MemberDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>완료</h1>

<%
		request.setCharacterEncoding("UTF-8");
		String id =request.getParameter("id");
		String pw =request.getParameter("pw");
		String name =request.getParameter("name");
		String tel =request.getParameter("tel");
		String addr =request.getParameter("addr");
		String favorite =request.getParameter("favorite");
		
			MemberDAO dao = new MemberDAO();
			dao.Memberinsert(id, pw, name, tel, addr, favorite);

%>

<body>



</body>
</html>
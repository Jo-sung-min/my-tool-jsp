<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<%
	
	request.setCharacterEncoding("UTF-8");
	String pw=request.getParameter("pw");
	String username =request.getParameter("username");
	String test = request.getParameter("test");
	
	System.out.println(username);
	System.out.println(pw);
	System.out.println(test);
	
%>
<body>

	<h2>pro page</h2>
	<h4>username : <%=username %></h4>
	<h4>pw : <%=pw %></h4>
	<h4>test : <%=test %></h4>






</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
</head>
<body>

	<h1>home jsp</h1>
	<h1>MVC 패턴을 적용해봤습니다.</h1>
 
	<h3><%=request.getAttribute("num") %> ${requestScope.num}</h3>
	<h3><%=request.getAttribute("name") %> ${requestScope.name} </h3>
	<h3><%=session.getAttribute("memId") %> ${sessionScope.memId}</h3>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>main</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<br />
	<h1 align="center"> Main page </h1>
	
	<% if(session.getAttribute("memId") == null){ %>
	<table>
		<tr>
			<td><button onclick="window.location='loginForm.jsp'">로그인</button></td>
		</tr>
		<tr>
			<td><button onclick="window.location='signupForm.jsp'">회원가입</button></td>
		</tr>
	</table>
	<%}else{ %>
	<table>
		<tr>
			<td><button onclick="window.location='logout.jsp'">로그아웃</button></td>
		</tr>
		<tr>
			<td><button onclick="window.location='mypage.jsp'">마이페이지</button></td>
		</tr>
	</table>
	<%} %>
	
	<br /><br />
	<div align="center">
		<img src="img/img30.png" width="600" />
	</div>
	<br /><br />


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

	//로그인/ 비로그인 인지 확인하기위해 sid 꺼내서 담아놓기
	String sid = (String)session.getAttribute("sid");
	// 비로그인시 sid: null
	// 로그인시 sid : 사용자 id 값

%>
	<h2> Main </h2>
			<%
		if(sid==null){// 비로그인 > 로그인 버튼이 보여야함
			%>			
	<button onclick="window.location.href='form.jsp'">로그인</button>
			
			
	<% }else{%>	
	
	<button onclick="window.location.href='logout.jsp'">로그아웃</button>
	
	
	<% }%>
	



</body>
</html>
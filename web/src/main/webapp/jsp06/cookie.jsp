<%@page import="java.net.URLEncoder"%>
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
		// 쿠키 객체 생성
		Cookie c = new Cookie("id","java");
		// 쿠키 유효기간 설정
		c.setMaxAge(60);
		//클라이언트에게 쿠키도 전달되도록 response에 쿠키 추가
		response.addCookie(c);
	
		//Cookie coo = new Cookie("name",URLEncoder.encode("피카츄")); 
		Cookie coo = new Cookie("name","피카츄"); 
		coo.setMaxAge(60);
		response.addCookie(coo);
	
	%>
	






</body>
</html>
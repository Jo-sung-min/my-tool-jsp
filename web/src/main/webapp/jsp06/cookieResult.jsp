<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<h1>쿠키목록</h1>
	<%
		// 쿠키 확인	
		Cookie[] coos = request.getCookies();//request 에서 쿠키들 모두꺼내기
		for(int i = 0 ;i<coos.length;i++){// 배열 크기만큼 반복해서 쿠키 이름값 꺼내기
			Cookie c = coos[i];
			out.println(c.getName()+"="+c.getValue()+"<br/>");
		}
	
	%>
	



</body>
</html>
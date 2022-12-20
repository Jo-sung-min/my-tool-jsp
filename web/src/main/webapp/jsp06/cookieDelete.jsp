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
		// 쿠키에는 삭제 메서드가 없다. 유효기간을 0으로 지정해서 다시 응답해
		// 유효기간 만료로 사용자 브라우저에서 없어지게 유도해야함.
		
 		Cookie[] coos =  request.getCookies();

		for(Cookie c:coos){
			if(c.getName().equals("id")){ // 지금 c 에 담긴 쿠키객체의 이름이 id 와 동일하면
				c.setMaxAge(0);// 그 c 객체의 유효기간 0으로 지정하고
				response.addCookie(c);// 응답객체에 추가해서 사용자 브라우저로 전달> 소멸되게 함.
			}
			if(c.getName().equals("name")){
				c.setMaxAge(0);// 그 c 객체의 유효기간 0으로 지정하고
				response.addCookie(c);// 응답객체에 추가해서 사용자 브라우저로 전달> 소멸되게 함.
			}
			
		}


%>





</body>
</html>
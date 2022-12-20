<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>lohout.jsp</title>
</head>

<%
	// session 에서 속성삭제전에 사용자 id 가져와 변수에 담아두기
	String id =(String)session.getAttribute("sid");
	// 일반 로그인 > 로그아웃 : session 에서 sid 속성 삭제
	session.invalidate();
	
	// 자동 로그인 > 쿠키도 삭제
	Cookie[] coos= request.getCookies();
	for(Cookie c : coos){
		if(c.getName().equals("cid")||c.getName().equals("cpw")||c.getName().equals("cauto")){
			c.setMaxAge(0);
			response.addCookie(c);// 이거 쫌 햇갈리네
		}
		
		
	}
	
	
%>


<body>

<h1>로그 아웃</h1>
<h3><%=id %>님, 로그아웃 처리되었습니다.</h3>

<button onclick="window.location.href='main.jsp'">메인</button>



</body>
</html>
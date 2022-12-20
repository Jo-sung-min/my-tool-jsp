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
		//로그아웃 처리
		session.invalidate();
		// 쿠키 있으면쿠키도 삭제
		Cookie[] cs=request.getCookies();
		if(cs!=null){// 쿠키가 있으면 실행
			for(Cookie c: cs){
				if(c.getName().equals("autoId")||
						c.getName().equals("autoPw")||
							c.getName().equals("autoCh")){
								c.setMaxAge(0);
								response.addCookie(c);
				}
			}	
		}
	
		
		//메인이동
		response.sendRedirect("main.jsp");
	%>




</body>
</html>
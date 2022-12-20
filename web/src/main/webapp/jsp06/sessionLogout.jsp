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

// 로그아웃 처리 페이지
//#1. 로그인 유지해주는 속성만 삭제(로그인 이외에 유지되어야 할 속성이 있을경우)
	session.removeAttribute("sid");

//#2. 세션에 있는 모든속성삭제(다 지워도 될 경우)
	//session.invalidate();


// 로그아웃 처리 다했으면, 메인으로 이동시키기
	response.sendRedirect("sessionMain.jsp"); // 자바 활용해서 이동시키기
%>



</body>
</html>
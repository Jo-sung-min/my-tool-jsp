<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>Main Page</h1>
	
	세션 ID : <%=session.getId() %><br/>
	<% SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
	세션 생성시간 : <%= sdf.format(session.getCreationTime())%> <br/>	
	최근 접속시간 : <%=sdf.format(session.getLastAccessedTime()) %><br/>
	
	sid: <%= session.getAttribute("sid") %> <br/>
	
	<%-- 세션에 있는 속성들 이름 목록 --%>
	session 목록 : <br/>
	<%
	Enumeration<String> enu =session.getAttributeNames();
	while(enu.hasMoreElements()){
		String name = enu.nextElement().toString();
		String val = session.getAttribute(name).toString();
		out.println(name+" = "); // 브라우저에 출력
		out.println(val+"<br/>");
		
	}
	
	%>
	
		
	<%
	// 로그인 했는지 안했는지에 따라 페이지 다르게 보이도록 처리
	// 로그인상태 > 로그아웃 버튼으로 보이게
	// 비로그인 상태 > 로그인 버튼이 보이게
	// 로그인 했는지 안했는지 체크가 필요하다 => session sid 라는 이름의 값을 꺼내보기
	String sidVal= (String)session.getAttribute("sid");
	System.out.println(sidVal);
	if(sidVal != null){// 로그인된상태%>
	<h1>로그아웃</h1>
	<button onclick="window.location.href ='sessionLogout.jsp'"> 로그아웃</button>
		
	<% }else{// 비로그인된 상태%>
		
	<h1>로그인ㅇ</h1>
	<button onclick="window.location.href ='sessionForm.jsp'"> 로그인</button>
	<%}%>
	
	
	
	<% 
	// 내부객체 session 을 꺼낼 수  없는 곳에서는
	// request 에서 session 객체 얻어올 수 있다.
	HttpSession session2 = request.getSession();
	System.out.println(session); // 내부객체 session
	System.out.println(session2); // request 에서 얻어온 session
	
	
	%>
	
	
	
	
	
</body>
</html>
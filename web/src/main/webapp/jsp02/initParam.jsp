<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>initParam page</title>
</head>


<body>
	<h2>초기화 파라미터 목록</h2>
	<ul>
	<% 
	
		// 이름 목록 가져오고, 
		Enumeration<String> enu =	application.getInitParameterNames();
		while(enu.hasMoreElements()){
		// 이름 통해서 값도 꺼내오고
		String name=enu.nextElement();%>
		
		<li><%= name %>= <%=application.getInitParameter(name) %></li>		
				
	<% 	}
	
	%>
	</ul>



</body>
</html>
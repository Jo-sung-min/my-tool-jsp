<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% 
String name= request.getParameter("name");
String age= request.getParameter("age");
String addr= request.getParameter("addr");
request.setCharacterEncoding("UTF-8");

//파라미터 이름 목록
Enumeration<String> enu = request.getParameterNames();
while(enu.hasMoreElements()){// 이터레이터랑 같음
	String paraName =  enu.nextElement();
	out.println(paraName);
}


%>
<body>



<h2> 이름 : <%=name%></h2>
<h2> 나이 : <%=age%></h2>
<h2> 주소 : <%=addr%></h2>


</body>
</html>
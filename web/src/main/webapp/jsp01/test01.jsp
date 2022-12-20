<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="java.util.Date" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		for(int i = 0 ;i<100 ;i++){%>
			hello
			
		<%}
	
	%>
	<h1> test01 page</h1>
	
	<%--버전확인  --%>
	서버 :	 <%= application.getServerInfo() %> <br/> 
	서블릿 : <%= application.getMajorVersion()  %> . <%=application.getMinorVersion()  %>  <br/>
	JSP :    <%=JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion()  %>
		
	

</body>
</html>
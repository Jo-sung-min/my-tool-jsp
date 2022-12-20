<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pro</title>
</head>




<%-- request 객체에서 넘어온 데이터 꺼내기 --%>
<%	

		//post 방식 인코딩 처리 : post 방식으로 요청되어 넘어오는 파라미터값이
		//				한글일경우 인코딩 처리가 필요함
		//				파라미터를 꺼내기 전에 미리 한번 아래와 같이 인코딩 세팅을 먼저해줘야한다.	
		 request.setCharacterEncoding("UTF-8");
		
		
		
		String id= request.getParameter("id");
		String pw = request.getParameter("pw");
		out.println(id)	;
		out.println(pw)	;
		String [] pets = request.getParameterValues("pet");
		out.println(pets[0])	;
		out.println(pets[1])	;


%>
<body>


	<h1> pro page</h1>
	<h3>id : <%=id %> </h3>
	<h3>pw : <%=pw %> </h3>
	<% for(int i = 0 ;i<pets.length ;i++){%>
	
	<h2>pet : <%=pets[i] %>  </h2>
	
	<%}%>




</body>
</html>
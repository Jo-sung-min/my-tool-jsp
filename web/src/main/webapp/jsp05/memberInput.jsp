<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입 page</h1>
	<form action="memberInsert.jsp" method="post"> <br/>
		id: <input type= "text" name="id"/><br/>
		pw: <input type= "password" name="pw"/><br/>
		name: <input type= "text" name="name"/><br/>
		tel: <input type= "text" name="tel"/><br/>
		addr: <input type= "text" name="addr"/><br/>
		favorite: <input type= "text" name="favorite"/><br/>
		
			 <input type= "submit" value="가입"/>
	</form>

</body>
</html>
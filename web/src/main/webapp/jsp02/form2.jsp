<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>form2</title>
</head>



<body>

	<h2>form</h2>
	
	<%-- 폼태그로 전송할때!!!
		method="get" 은 action 값에 ? 로 파라미터 전송 불가
		method= "post" 일 경우 action 값에 ? 파라미터 전송 가능 ,내부 input태그는
		post 로 전달	
	 --%>	
	<form action="pro2.jsp?test=10" method="post">
	username : <input type="text" name="username"  /><br/>
	password : <input type="password" name="pw"  /><br/>
	 <input type="submit" value = "전송"  /><br/>
	
	</form>





</body>
</html>
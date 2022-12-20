<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>
	<%
		if(session.getAttribute("memID")==null){// 로그인 안했다는것
		%>
			<script>			
			
			alert("로그인후 사용가능한 페이지 입니다.");
			window.location.href="loginForm.jsp";
			</script>
			
		<%}else{// 로그인했다. 위에 sendRedirect 로 보내지않는건 자바로 
		//실행해 버리면 페이지가 열리기도전에 보내버릴수 있어서 스크립트로 보냈음%>
			
			
<body>
	<br/>
	<h2 align="center">My page</h2>
	<table>
		<tr>
			<td> <a href="modifyForm.jsp">회원정보 수정</a>  </td> 
		</tr>
		<tr>
			<td> <a href="deleteForm.jsp">회원탈퇴</a>  </td> 
		</tr>
		<tr>
			<td> <a href="main.jsp">메인으로</a>  </td> 
		</tr>
	
	
	</table>

</body>
		<%}%>
	
	


</html>
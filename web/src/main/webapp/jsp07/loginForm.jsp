<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
	<script >
	//유효성 검사
		function checkField(){
		let inputs =document.loginForm;
		if(!inputs.id.value){
			alert("아이디를 입력해주세요");			
			return false;
		}
		if(!inputs.pw.value){
			alert("비밀번호를 입력해주세요");			
			return false;
		}
	}
	
	</script>
</head>




<body>
	<br/>
	<h2 align="center">로그인</h2>
	<form action="loginPro.jsp" method="post" name="loginForm" onsubmit="return checkField()">;
	<table>
		<tr>
			<td>아이디</td>
			<td> <input type="text" name="id"> </td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td> <input type="password" name="pw"> </td>
		</tr>
		<tr>
			<td colspan="2"> <input type="checkbox" name="auto" value="1">자동로그인</td>
		</tr>
		<tr>
			<td colspan="2">
			 	<input type="submit" value="로그인"/>로그인
			 	<input type="button" value="회원가입" onclick="window.location='signupForm.jsp'"/>회원가입
			 </td>
		</tr>
	
	</table>
	</form>



</body>

</html>
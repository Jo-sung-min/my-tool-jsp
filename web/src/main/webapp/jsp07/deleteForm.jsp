<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css"/>

<script >
	function checkField(){
		let inputs = document.deleteForm;
		if(!inputs.pw.value){
		alert("비밀번호를 입력해주세요");
		return false
		}
	}
</script>



</head>
<body>
	<br/>
	<h2 align="center">회원탈퇴</h2>
	<form action="deletePro.jsp" method="post" name="deleteForm" onsubmit="return checkField()">
		<table>
		
			<tr>
				<td> <input type="password" name="pw"/ > </td>
			</tr>
			<tr>
				<td> 
				<input type="submit" value="탈퇴"/ > 
				<input type="button" value="취소" onclick="window.location='main.jsp'"/ > 
				</td>
			</tr>
			
		</table>
	</form>

</body>
</html>
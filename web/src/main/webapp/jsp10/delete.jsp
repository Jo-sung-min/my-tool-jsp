<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>delete form</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<br />
	<h1 align="center"> 회원 탈퇴 </h1>
	<form action="deletePro.jsp" method="post">
		<table>
			<tr>
				<td> 탈퇴를 원하시면 비밀번호를 입력하세요 <br />
					<input type="password" name="pw" />
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="탈퇴" />
					<input type="button" value="취소" onclick="window.location='mypage.jsp'" />
				</td>
			</tr>
		</table>
	</form>


</body>
</html>
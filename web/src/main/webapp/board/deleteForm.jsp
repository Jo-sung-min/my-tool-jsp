<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>delete form</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	int bno = Integer.parseInt(request.getParameter("bno"));
	String pageNum = request.getParameter("pageNum");
%>

<body>
	<br />
	<h1 align="center"> 글 삭제 </h1>
	<form action="deletePro.jsp?pageNum=<%=pageNum%>" method="post">
	<table>
		<tr>
			<td> 삭제를 원하시면 비밀번호를 입력하세요 <br />
				<input type="password" name="bpw" /> 
				<input type="hidden" name="bno" value="<%=bno%>" />
			</td>
		</tr>	
		<tr>
			<td>
				<input type="submit" value="삭제" />
				<input type="button" value="취소" onclick="window.location='content.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>'" />
			</td>
		</tr>
	
	</table>
	</form>

</body>
</html>
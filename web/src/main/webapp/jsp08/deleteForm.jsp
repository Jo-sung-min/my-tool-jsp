<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>
<% int num = Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
%>

<body>
	<br/>
	<h1 align="center">Delete Form</h1>
	<form action="deletePro.jsp?pageNum=<%=pageNum%>" method="post">
	<%--글 고유번호 숨겨서 넘기기 --%>
		<input type="hidden" name="num" value="<%=num%>"/>
		<table>
			<tr>
				<td>삭제를 원하시면 비밀번호를 입력하세요</td>
			</tr>
			<tr>
				<td> <input type="password" name="pw" /> </td>
			</tr>
			<tr>
				<td> 
					<input type="submit" value="삭제" /> 
					<input type="button" value="취소"  onclick="history.go(-1)" /> 
				</td>
			</tr>
		
		
		</table>
	
	
	
	</form>


</body>
</html>
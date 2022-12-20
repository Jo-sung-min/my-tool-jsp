<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>reply write form</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	int bno = Integer.parseInt(request.getParameter("bno"));
	String pageNum = request.getParameter("pageNum");
	
	// 새 댓글 
	int rno = 0, replyGrp = 1, replyStep = 0, replyLevel = 0; 
	
	// 댓글의 댓글 
	if(request.getParameter("rno") != null) {
		rno = Integer.parseInt(request.getParameter("rno"));
		replyGrp = Integer.parseInt(request.getParameter("replyGrp"));
		replyStep = Integer.parseInt(request.getParameter("replyStep"));
		replyLevel = Integer.parseInt(request.getParameter("replyLevel"));
	}

%>

<body>
	<br />
	<h1 align="center"> Reply Form </h1>
	<form action="replyPro.jsp?pageNum=<%=pageNum%>" method="post">
		<input type="hidden" name="bno" value="<%=bno%>"/>
		<input type="hidden" name="rno" value="<%=rno%>"/>
		<input type="hidden" name="replyGrp" value="<%=replyGrp%>"/>
		<input type="hidden" name="replyStep" value="<%=replyStep%>"/>
		<input type="hidden" name="replyLevel" value="<%=replyLevel%>"/>
		<table>
			<tr>
				<td>내 용</td>
				<td><textarea rows="3" cols="40" name="reply"></textarea>  </td>
			</tr>
			<tr>
				<td>작성자</td>
				<td align="left"><input type="text" name="replyer" /> </td>
			</tr>
			<tr>
				<td colspan="2" align="left">
					<input type="submit" value="댓글저장" /> 
					<input type="button" value="취소" onclick="window.location='content.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>'" />
				</td>
			</tr>
		</table>
	</form>


</body>
</html>
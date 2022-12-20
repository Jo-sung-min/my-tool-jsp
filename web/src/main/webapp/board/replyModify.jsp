<%@page import="web.board.model.ImgReplyDTO"%>
<%@page import="web.board.model.ImgReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>reply modify form</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	int rno = Integer.parseInt(request.getParameter("rno"));
	int bno = Integer.parseInt(request.getParameter("bno"));
	String pageNum = request.getParameter("pageNum");
	
	ImgReplyDAO dao = new ImgReplyDAO(); 
	ImgReplyDTO reply = dao.getOneReply(rno);  
	
%>

<body>
	<br />
	<h1 align="center"> Reply Modify </h1>
	<form action="replyModifyPro.jsp?pageNum=<%=pageNum%>" method="post">
		<input type="hidden" name="bno" value="<%=bno%>"/>
		<input type="hidden" name="rno" value="<%=rno%>"/>
		<table>
			<tr>
				<td>내 용</td>
				<td><textarea rows="3" cols="40" name="reply"></textarea>  </td>
			</tr>
			<tr>
				<td>작성자</td>
				<td align="left"><%=reply.getReplyer()%></td>
			</tr>
			<tr>
				<td colspan="2" align="left">
					<input type="submit" value="댓글수정" /> 
					<input type="button" value="취소" onclick="window.location='content.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>'" />
				</td>
			</tr>
		</table>
	</form>

</body>
</html>
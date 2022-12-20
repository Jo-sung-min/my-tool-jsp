<%@page import="web.board.model.ImgReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>replyPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
%>
<jsp:useBean id="replyDTO" class="web.board.model.ImgReplyDTO" />
<jsp:setProperty property="*" name="replyDTO"/>
<%
	ImgReplyDAO dao = new ImgReplyDAO(); 
	dao.insertReply(replyDTO); 
 
	response.sendRedirect("content.jsp?bno=" + replyDTO.getBno() + "&pageNum=" + pageNum);
%>

<body>

</body>
</html>
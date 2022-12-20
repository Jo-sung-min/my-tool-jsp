<%@page import="web.board.model.ImgReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>reply delete</title>
</head>
<%
	int rno = Integer.parseInt(request.getParameter("rno"));
	int bno = Integer.parseInt(request.getParameter("bno"));
	String pageNum = request.getParameter("pageNum");
	
	ImgReplyDAO dao = new ImgReplyDAO(); 
	dao.deleteReply(rno);  
	
	response.sendRedirect("content.jsp?bno=" + bno + "&pageNum=" + pageNum);
	
%>


<body>

</body>
</html>
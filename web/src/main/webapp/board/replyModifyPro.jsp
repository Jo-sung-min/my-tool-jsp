<%@page import="web.board.model.ImgReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>reply modify pro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	int bno = Integer.parseInt(request.getParameter("bno"));
	int rno = Integer.parseInt(request.getParameter("rno"));
	String reply = request.getParameter("reply");
	
	ImgReplyDAO dao = new ImgReplyDAO();
	dao.updateReply(rno, reply);   
	
	response.sendRedirect("content.jsp?bno=" + bno + "&pageNum=" + pageNum);
%>

<body>

</body>
</html>
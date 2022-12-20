<%@page import="web.jsp08.model.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 삭제 처리</title>
</head>


<%
	//DB 에서 삭제
	int replyNum= Integer.parseInt(request.getParameter("replyNum"));// 삭제할떄 필요
	int boardNum= Integer.parseInt(request.getParameter("boardNum"));//content 로 돌아갈떄 필요

	String replyPageNum = request.getParameter("replyPageNum");
	String pageNum =request.getParameter("pageNum");	
	ReplyDAO dao = new ReplyDAO();
	dao.deleteReply(replyNum);
	//처리 후 content 로 돌아가기
	response.sendRedirect("content.jsp?num="+boardNum+"&replyPageNum="+replyPageNum+"&pageNum="+pageNum);
%>



<body>





</body>
</html>
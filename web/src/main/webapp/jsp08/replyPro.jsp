<%@page import="web.jsp08.model.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>replyPro 댓글 작성 처리</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");
	String replyPageNum = request.getParameter("replyPageNum");
	String pageNum =request.getParameter("pageNum");
%>
<jsp:useBean id="reply" class="web.jsp08.model.ReplyDTO"/>
<jsp:setProperty property="*" name="reply"/>


<%
	ReplyDAO dao = new ReplyDAO();
	dao.insertReply(reply);	//DB replyBoard 테이블에 댓글 저장
	//이전에 보던 content 페이지 요청, 이때 어떤 글번호의 본문 페이지인지 값 파라미터로 전달
	response.sendRedirect("content.jsp?num="+reply.getBoardNum()+"&replyPageNum="+replyPageNum+"&pageNum="+pageNum);
%>



<body>

</body>
</html>
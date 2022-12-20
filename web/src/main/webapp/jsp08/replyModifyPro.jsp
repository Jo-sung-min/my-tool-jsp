<%@page import="web.jsp08.model.ReplyDTO"%>
<%@page import="web.jsp08.model.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");
	String replyPageNum = request.getParameter("replyPageNum");
	String pageNum =request.getParameter("pageNum");
%>
<jsp:useBean id="replyDTO" class="web.jsp08.model.ReplyDTO"/>
<jsp:setProperty property="*" name="replyDTO"/>
<%
	//DB 가서 수정처리
	ReplyDAO dao = new ReplyDAO();
	dao.updateReply(replyDTO);
	
	//수정 처리 후 content 로 돌아가기
	
	response.sendRedirect("content.jsp?num="+replyDTO.getBoardNum()+"&replyPageNum="+replyPageNum+"&pageNum="+pageNum);
	
%>


<body>



</body>
</html>
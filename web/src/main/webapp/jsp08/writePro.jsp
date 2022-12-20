<%@page import="web.jsp08.model.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>writePro</title>
	
</head>
<%
	request.setCharacterEncoding("UTF-8");

%>
<jsp:useBean id="article" class="web.jsp08.model.BoardDTO"/>
<jsp:setProperty property="*" name="article"/>


<%
	//넘어오는 데이터를 제외한 나머지 채울부분 채우기
	article.setReg(new Timestamp(System.currentTimeMillis()));
	// 시스템상 현재 시간으로 reg 값 채우기
	article.setReadcount(0);
	//DB에 데이터(article) 저장
	BoardDAO dao = new BoardDAO();  
	dao.insertArticle(article);
	
	//게시판 목록으로 이동
	response.sendRedirect("list.jsp");



%>


<body>

</body>
</html>
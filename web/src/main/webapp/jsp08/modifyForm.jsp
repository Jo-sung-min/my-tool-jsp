<%@page import="web.jsp08.model.BoardDTO"%>
<%@page import="web.jsp08.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 페이지</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>

<%
	//content.jsp 를 통해 현재페이지로 이동해왔고, 이떄 글 고유번호도 파라미터로 가져옴
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	
	
	BoardDAO dao = new BoardDAO();
	BoardDTO article = dao.getArticle(num);
	
%>


<body>
<br/>
	<h1 align="center">Write Article</h1>
	<form action="modifyPro.jsp?&pageNum<%=pageNum%>"method="post">
	<%-- 글 고유번호 숨겨서 넘기기 : form태그안에 작성해야 넘어감 --%>
	<input type="hidden" name="num" value="<%=num%>"/>
	
	<table>
		<tr>
		 	<td>제	목</td>
		 	<td> <input type="text" name="subject" value="<%=article.getSubject()%>"> </td>
		</tr>
		<tr>
		 	<td>작성자</td>
		 	<td> <input type="text" name="writer" value="<%=article.getWriter()%>"> </td>
		</tr>
		<tr>
		 	<td>내	용</td>
		 	<td> <textarea rows="20" cols="50" name="content"><%=article.getContent()%></textarea> </td>
		</tr>
		<tr>
		 	<td>email</td>
		 	<td> <input type="text" name="email" value="<%=article.getEmail()%>"> </td>
		</tr>
		<tr>
		 	<td>비밀번호</td>
		 	<td> <input type="password" name="pw"> </td>
		</tr>
		<tr>
		 	<td colspan="2">
				<input type="submit" value="저장"/> 	
				<input type="reset" value="재작성"/> 	
				<input type="button" value="취소" onclick="history.go(-1)"/> 	
			</td>
		 	
		</tr>
		
	</table>
	</form>

	update board set subject=?,writer=?,content=?,email=? where num=?;


</body>
</html>
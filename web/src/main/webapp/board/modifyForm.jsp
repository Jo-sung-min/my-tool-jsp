<%@page import="web.board.model.ImgBoardDTO"%>
<%@page import="web.board.model.ImgBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	int bno = Integer.parseInt(request.getParameter("bno")); 	
	String pageNum = request.getParameter("pageNum");
	
	ImgBoardDAO dao = new ImgBoardDAO();
	ImgBoardDTO article = dao.getOneArticle(bno); 

%>


<body>
	<br /> 
	<h1 align="center"> 글 수정 폼 </h1>
	<form action="modifyPro.jsp?pageNum=<%=pageNum%>" method="post" enctype="multipart/form-data">
		<input type="hidden" name="bno" value="<%=bno%>" />
		<table>
			<tr>
				<td>제  목</td>
				<td><input type="text" name="subject" value="<%=article.getSubject()%>" /></td>
			</tr>		
			<tr>
				<td>작성자</td>
				<td><%=article.getWriter()%></td>
			</tr>		
			<tr>
				<td>내  용</td>
				<td><textarea rows="15" cols="50" name="content"><%=article.getContent()%></textarea></td>
			</tr>		
			<tr>
				<td>이미지</td>
				<td>
					<img src="/web/save/<%=article.getImg()%>" width="300" /> <br /> 
					<input type="file" name="img" />
					<input type="hidden" name="exImg" value="<%=article.getImg()%>" />
				</td>
			</tr>
			<tr>
				<td>email</td>
				<td>
					<%if(article.getEmail() == null){ %>
						<input type="text" name="email" />
					<%}else{ %>
						<input type="text" name="email" value="<%=article.getEmail()%>"/>
					<%} %>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="bpw" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정" />
					<input type="reset" value="재작성" />
					<input type="button" value="취소"  onclick="window.location='content.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>'" />
				</td>
			</tr>
		</table>
	</form>


</body>
</html>
<%@page import="web.board.model.ImgBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>delete pro</title>
</head>
<%
	String pageNum = request.getParameter("pageNum");
	int bno = Integer.parseInt(request.getParameter("bno"));
	String bpw = request.getParameter("bpw");
	
	ImgBoardDAO dao = new ImgBoardDAO(); 
	int result = dao.deleteArticle(bno, bpw);  
	
	if(result == 1) {  // 사진삭제 %>
		<script>
			alert("삭제 완료!!!");
			window.location.href="list.jsp?pageNum=" + <%=pageNum%>;
		</script>
	<%}else{%>
		<script>
			alert("비밀번호가 맞지 않습니다....");
			history.go(-1);
		</script>	
	<%}%>

<body>

</body>
</html>
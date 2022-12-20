<%@page import="web.jsp08.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePro</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pw = request.getParameter("pw");
	String pageNum=request.getParameter("pageNum");
	
	//db 가서 비번 맞는지 확인하고 삭제
	BoardDAO dao = new BoardDAO();
	int result = dao.deleteArticle(num,pw);// 3번째
	
	if(result==1){
		response.sendRedirect("list.jsp?pageNum="+pageNum);
	}else{%>
		<script >
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
		</script>		
		
<%	}
%>




</body>
</html>
<%@page import="web.jsp08.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ModifyPro</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");
	String pageNum=request.getParameter("pageNum");

%>
<jsp:useBean id="article" class="web.jsp08.model.BoardDTO"/>
<jsp:setProperty property="*" name="article"/>




<%
	// DB에 접속해서 데이터 수정
	BoardDAO dao = new BoardDAO();
	//2 번째 메서드
	int result =dao.updateArticle(article);// 수정처리 (pw 맞는지 )결과 돌려받기
	//1= 수정잘됨, 0= 비번틀림, -1= 가능성은 없게
	
	
	if(result==1){
		String uri="content.jsp?num="+article.getNum()+"&pageNum"+pageNum;
		response.sendRedirect(uri);
	}else{%>
		<script >
			alert("비밀번호가 맞지 않습니다. 다시 시도해 주세요...");
			history.go(-1);
		</script>	
		
	<%}
	
%>

<body>

</body>
</html>
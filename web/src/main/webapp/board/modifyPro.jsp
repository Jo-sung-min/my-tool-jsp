<%@page import="web.board.model.ImgBoardDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="web.board.model.ImgBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modifyPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	ImgBoardDTO article = new ImgBoardDTO(); 
	
	String path = request.getRealPath("save");
	System.out.println(path);
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	// 비번 검사하고 맞으면 수정 : bpw 
	// update imgBoard set subject=?, content=?, email=?, img=? where bno=?; 
	article.setBno(Integer.parseInt(mr.getParameter("bno"))); 
	article.setSubject(mr.getParameter("subject"));
	article.setContent(mr.getParameter("content"));
	article.setEmail(mr.getParameter("email"));
	article.setBpw(mr.getParameter("bpw"));
	if(mr.getFilesystemName("img") != null){
		article.setImg(mr.getFilesystemName("img"));
	}else{
		article.setImg(mr.getParameter("exImg"));
	}
	
	String pageNum = mr.getParameter("pageNum");
	System.out.println("modifyPro pageNum : " + pageNum);
	
	ImgBoardDAO dao = new ImgBoardDAO(); 
	int result = dao.updateArticle(article); // 비번 틀리면 0, 수정완료 1   
	if(result == 0) { %>
		<script>
			alert("비밀번호가 맞지 않습니다....");
			history.go(-1);
		</script>
	<%}else{%>
		<script>
			alert("수정 완료!!!");
			window.location.href = "content.jsp?bno=" + <%=article.getBno()%> + "&pageNum=" + <%=pageNum%>; 
		</script>
	<%} %>


<body>

</body>
</html>
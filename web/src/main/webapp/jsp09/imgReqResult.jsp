<%@page import="web.jsp09.model.UploadDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.jsp09.model.UploadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>imgRegResult.jsp</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");
	String writer = request.getParameter("writer");
	UploadDAO dao = new UploadDAO();
	List<UploadDTO> imgs  =dao.getImgs(writer);
	
		
		
	
	


%>
<body>
<%
	if(imgs==null){// DB 에 검색한 작성자로 등록된 레코드가 없을 경우%>
		<script >
			alert("검색하신 내용이 없습니다.");
			history.go(-1);
		</script>
	<% }else{// 검색 결과가 있을 경우%>
		<h2>검색 결과</h2>
		<%
			for(int i = 0 ;i<imgs.size() ;i++){
				UploadDTO dto = imgs.get(i);%>
				
				<img src="/web/save/<%=dto.getUpload()%>" width="300"/> <br/>	
				<h5><%=dto.getWriter() %></h5>
				<br/>
			<%}
		%>
		



		
	<%}
	%>
</body>
</html>
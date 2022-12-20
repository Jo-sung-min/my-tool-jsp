<%@page import="web.jsp08.model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%--변수 선언 --%>
	<c:set var="id" value="java"></c:set> 
	<c:set var="name" value="성민"/>
	<c:set var="name1" >송민</c:set>
	 
	<h3>id : ${id}</h3> 
	<h3>name : ${name}</h3>
	<h3>name : ${name1}</h3>

	<%-- 프로퍼티 설정 : target 지정 할 때 ** 주의
			#1.스크립트릿 = 표현식<%=
			#2.액션태그 = EL 사용 --%>
	<%BoardDTO dto = new BoardDTO();%>
	<c:set target="<%=dto%>" property="writer" value="hahah"></c:set>
	<h3>dto.writer: <%=dto.getWriter()%></h3>
	
	
	<jsp:useBean id="vo" class="web.jsp08.model.BoardDTO"/>
	<c:set target="${vo}" property="writer">hohoho</c:set>
	<h3>dto.writer:${vo.writer}</h3>

</body>
</html>
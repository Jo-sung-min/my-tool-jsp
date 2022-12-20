<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%
			request.setCharacterEncoding("UTF-8");
		%>

	<jsp:useBean id="dto" class="web.jsp07.model.MemberDTO"/> <%--dto 객체생성 --%>
	<jsp:setProperty property="*" name="dto"/><%--넘어온 파라미터 dto 에 담기 --%>
<%	
	MemberDAO dao = new MemberDAO();
	dao.addMember(dto); // 회원가입 처리 메서드 호출
	
	
	response.sendRedirect("main.jsp");
%>


</body>
</html>
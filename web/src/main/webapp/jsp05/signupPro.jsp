
<%@page import="web.jsp05.model.SignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signupPro</title>
</head>
<%
// 넘어온 데이터 추출

	request.setCharacterEncoding("UTF-8");


%>

<jsp:useBean id="dto" class="web.jsp05.model.SignupDTO"/>
<jsp:setProperty property="*" name="dto"/>


<%
	//DB 접속해서 레코드 한줄 insert -> DAO 
	SignupDAO dao = new SignupDAO();
	dao.insertMember(dto);


%>




<body>

	<h3>pro</h3>

</body>
</html>
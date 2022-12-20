<%@page import="web.jsp10.model.ImgSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>mypage</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	// 회원이 가입시 업로드한 이미지를 띄워주기 위해 
	// DB가서 해당 로그인한 사람의 아이디를 주고, 이미지 파일명 가져오기
	
	// session에서 사용자 id값 꺼내기
	String id = (String)session.getAttribute("memId"); 
	// DB접근위해 DAO 객체 생성 
	ImgSignupDAO dao = new ImgSignupDAO(); 
	// 사용자 id를 주면, 그 사용자가 업로드한 이미지 파일 돌려주기 
	String photo = dao.getPhoto(id); 

%>
<body>
	<br />
	<h1 align="center"> MyPage </h1>
	<table>
		<tr>
			<td>
				<img src="/web/save/<%=photo%>"  width="150" />
			</td>
		</tr>
		<tr>
			<td><a href="modify.jsp">회원 정보 수정</a></td>
		</tr>
		<tr>
			<td><a href="delete.jsp">회원 탈퇴</a></td>
		</tr>
		<tr>
			<td><a href="main.jsp">메인으로</a></td>
		</tr>
	</table>
</body>
</html>
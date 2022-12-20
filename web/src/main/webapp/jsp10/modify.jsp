<%@page import="web.jsp10.model.ImgSignupDTO"%>
<%@page import="web.jsp10.model.ImgSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modifyForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	// 로그인했을때만 접근가능한 페이지 
	String id = (String)session.getAttribute("memId");

	ImgSignupDAO dao = new ImgSignupDAO(); 
	ImgSignupDTO member = dao.getMember(id);  
%>
<body>
	<br />
	<h1 align="center"> 회원정보 수정 </h1>
	<form action="modifyPro.jsp" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>아이디 *</td>
				<td> <%= id %> </td>
			</tr>
			<tr>
				<td></td>
				<td><input type="button" value="아이디 중복 확인" /></td>
			</tr>
			<tr>
				<td>비밀번호 *</td>
				<td><input type="password" name="pw" value="<%=member.getPw()%>" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인 *</td>
				<td><input type="password" name="pwch" /></td>
			</tr>
			<tr>
				<td>이름 *</td>
				<td><%=member.getName()%></td>
			</tr>
			<tr>
				<td>성별 </td>
				<td>
					<%=member.getGender()%>
				</td>
			</tr>
			<tr>
				<td>email</td>
				<td>
				<%	if(member.getEmail().equals("none")){ // db에 사용자 email 없는 경우 %>
						<input type="text" name="email"  />						
				<%	}else{ // db에 사용자 email이 있는 상태 %>
						<input type="text" name="email" value="<%=member.getEmail()%>" />						
				<%	} %>
				</td>
			</tr>
			<tr>
				<td>photo</td>
				<td>
					<%-- 사용자 저장유무를 떠나 DB에 들어가있는 파일명으로 화면에 띄워주기 --%>
					<img src="/web/save/<%=member.getPhoto()%>" width="150" />
					<br />
					<%-- 사용자가 등록/수정 파일버튼 --%>
					<input type="file" name="photo" /> 
					<%-- 히든으로는 기존에 사용자가 등록했던 이미지 파일명 숨겨서 보내기 --%>
					<input type="hidden" name="exPhoto" value="<%=member.getPhoto()%>" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정" />
					<input type="reset" value="재작성" />
					<input type="button" value="취소" onclick="window.location='mypage.jsp'" />
				</td>
			</tr>
		</table>
	</form>
	<br />

</body>
</html>


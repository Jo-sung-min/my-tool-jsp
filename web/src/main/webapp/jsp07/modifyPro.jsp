<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>
	


<%
		request.setCharacterEncoding("UTF-8");
		if(session.getAttribute("memID")==null || request.getParameter("pw")==null){// 로그인 안했다는것
		%>
			<script>			
			alert("로그인후 사용가능한 페이지 입니다.");
			window.location.href="loginForm.jsp";
			</script>
			
		<%}else{	%>
	
	<jsp:useBean id="member" class="web.jsp07.model.MemberDTO"></jsp:useBean>
	<jsp:setProperty property="*" name="member"/>
	
	
	<%
		//pw, name,email, 세개 데이터
		//id는 modigyForm 에서 넘어오지 못했기때문에
		//session 에서 꺼내서 직접 채워주자
		String id=(String)session.getAttribute("memID");
		member.setId(id);
		
		//쿼리문 생각 update db에 member 주고 업데이트 해라
		MemberDAO dao = new MemberDAO();
		dao.updateMember(member);
	
	%>
	
<body>
	<br/>
	<h1 align="center">회원 정보 수정</h1>
		<table>
			<tr>
				<td> <b>회원정보가 수정되었습니다.</b> </td>
			</tr>
			<tr>
				<td> <button onclick="window.location='main.jsp'">메인으로</button> </td>
			</tr>
		</table>
	


</body>
		<%} %>
</html>
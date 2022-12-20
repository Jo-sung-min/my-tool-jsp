<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePro</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>

	<%
		String id =(String)session.getAttribute("memID");
		String pw = request.getParameter("pw");
		
		MemberDAO dao = new MemberDAO();
		int check= dao.deleteMember(id,pw);
		
		if(check ==1){// 회원 탈퇴 성공
			//로그아웃 처리
			session.invalidate();
			Cookie[] coos=request.getCookies();
			if(coos != null){
				for(Cookie c : coos){
					if(c.getName().equals("autoId") ||
							c.getName().equals("autoPw") ||
								c.getName().equals("autoCh")){
									c.setMaxAge(0);
									response.addCookie(c);
					}
				}
			}%>
<body>
	<br/>
	
	<table>
		<tr>
			<td>회원정보가 삭제 되었습니다.</td>
		</tr>
		<tr>
			<td> <button onclick="window.location='main.jsp'">메인으로</button> </td>
		</tr>
	
	</table>
	
		<%}else{//버빈 틀렸을때%>
			<script >
				alert("비밀번호를 잘못 입력하셨습니다.");
				history.go(-1);
			</script>
			
		<%}%>


</body>
</html>
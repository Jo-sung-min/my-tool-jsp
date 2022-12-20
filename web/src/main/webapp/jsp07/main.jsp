<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>
<body>

	<h1 align="center">메인 페이지</h1>
	<h3>memId: <%=session.getAttribute("memID") %></h3>
	
	<%
		
		
	if(session.getAttribute("memID")==null){// 로그인 안했을때
			
			// 쿠키가 있는지 검사
			String id=null , pw=null, auto=null;
			Cookie[] coos = request.getCookies();
			if(coos !=null){
				for(Cookie c: coos){
					// 쿠키가 있다면 쿠키에 저장된 값 꺼내 변수에 담기
					if(c.getName().equals("autoId")) id = c.getValue();
					if(c.getName().equals("autoPw")) pw = c.getValue();
					if(c.getName().equals("autoCh")) auto = c.getValue();
				}
			}
	
			if(auto !=null && pw !=null && id !=null){
				//로그인 처리되도록 loginPro.jsp 처리 페이지로 이동시키기
				response.sendRedirect("loginPro.jsp");
				
			}	
				// 위 코드 다 지나치면,
				//session 에 memId 속성도 없고, 쿠키도 없으니 로그인 버튼 보여주기
	%>
	<table>
			<tr>
				<td>로그인을 원하시면 버튼을 누르세요</td>		
			</tr>
			<tr>
				<td><button onclick="window.location='loginForm.jsp'">로그인</button></td> 	
			</tr>
			<tr>
				<td>
				  <a href="signupForm.jsp" >회원가입</a>
				</td>		
			</tr>
	</table>
		
	<%}else{%>
	<table>
			<tr>
				<td><%=session.getAttribute("memID") %> 님 환영합니다.</td>		
			</tr>
			<tr>
				<td><button onclick="window.location='loginout.jsp'">로그아웃</button><br/> 	
				<button onclick="window.location='mypage.jsp'">마이페이지</button></td> 	
			</tr>
			<tr>
				<td>
				  <a href="signupForm.jsp" >회원가입</a>
				</td>		
			</tr>
	</table>
	<%}%>
	<br/><br/>
	<div align="center">
		<img src="img/zzang.png" width="400px">	
	</div>


</body>
</html>
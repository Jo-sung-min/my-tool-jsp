<%@page import="web.jsp10.model.ImgSignupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginPro</title>
</head>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto");
	
	// DB에 id,pw 전달해서 DB상 데이터와 일치하는지 결과를 받아와야함. 
	ImgSignupDAO dao = new ImgSignupDAO(); 
	int result = dao.idPwCheck(id, pw); // result : 1 ok, 0 비번틀림, -1 아이디없다
	System.out.println("loginPro result : " + result);
	
	if(result == -1) { %>
		<script>
			alert("존재하지 않는 id 입니다..."); 
			history.go(-1); 
		</script>
<%	}else if(result == 0) { %>
		<script>
			alert("비밀번호가 맞지 않습니다.. 다시 시도해주세요...");
			history.go(-1);
		</script>
<%	}else { 
		// 로그인 처리!! 
		session.setAttribute("memId", id);
%>
		<script>
			alert("로그인 성공!!!!");
			window.location="main.jsp";
		</script>
<%	}%>
<body>

</body>
</html>






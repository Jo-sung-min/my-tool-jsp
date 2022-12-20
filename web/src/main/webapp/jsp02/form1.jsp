<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>form1</title>
</head>
<body>

	<h2>form1</h2>
	
	<%-- 이름 , 나이 , 주소 입력하는 폼 작성하고,
		pro1.jsp 페이지로 데이터 넘겨 , 넘어간 데이터 화면에 출력해 보세요.
	 --%>
	<form action="pro1.jsp" method="get">
		<input type="text" name="name"/>이름
		<input type="text" name="age"/>나이
		<input type="text" name="addr"/>주소
		<input type="submit" value="제출"/>
		
	
	</form>


</body>
</html>
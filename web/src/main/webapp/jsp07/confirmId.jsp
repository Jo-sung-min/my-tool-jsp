<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>id 중복확인</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>
	<%  
		//open(url...) : confirmId.jsp?id=값 이렇게 넘어오니까
		String id = request.getParameter("id");	
		// DB 연결해서 사용자가 작성한 id 값이 db테이블에 존재하는지 검사
		MemberDAO dao  =new MemberDAO();
		boolean result =dao.confirmId(id);
	
		%>
		
<body>
	<%	
		if(result){//true값이 존재%>
		<br/>
		<table>
			<tr>
				<td><%=id %> 은 / 이미 사용중인 아이디 입니다.</td>
			</tr>
			
		</table>
		<form action="confirmId.jsp" method="post">
			<table>
				<tr>
					<td>다른 아이디를 선택하세요.<br/>
						<input type="text" name="id"/>
						<input type="submit" value="ID 중복확인"/>
					</td>
				</tr>
			</table>
		
		</form>
			
		<%}else{//값이 없음 아이디 만들기 가능%>
			<table>
				<tr>
					<td>입력하신 <%=id %>은/는 사용할 수 있습니다.<br/>
						<input type="button" value="닫기" onclick="setId()"/>
					</td>
				</tr>			
			
			</table>
			
		<%}%>
			<script >
				function setId(){
						// 팝업을 열어준 원래 페이지의 id input태그의 value 를
						// 최종 사용할 id 로 변경.
						opener.document.inputForm.id.value = "<%=id%>";
						//현재 팝업은 닫기
						self.close();
				}
			</script>
	
</body>
</html>
<%@page import="web.jsp07.model.MemberDAO"%>
<%@page import="web.jsp07.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyForm.jsp</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>
	<%
		if(session.getAttribute("memID")==null){// 로그인 안했다는것
		%>
			<script>			
			alert("로그인후 사용가능한 페이지 입니다.");
			window.location.href="loginForm.jsp";
			</script>
			
		<%}else{%>	



	<script >
	//유효성 검사
		function checkField(){
		let inputs =document.modifyForm;

		if(!inputs.pw.value){
			alert("비밀번호를 입력해주세요");			
			return false;
		}
		if(!inputs.pwch.value){
			alert("비밀번호확인를 입력해주세요");			
			return false;
		}
		if(inputs.pw.value!=inputs.pwch.value){
			alert("비밀번호를 확인해주세요");			
			return false;
		}
	}
	</script>




<%
	//(로그인이 된 상태로 이 페이지에 접근했다는 가정하에....)
	// 로그인한 회원 정보를 모두 가져와서
	// > DB 접근 id 를 주고 레코드 한줄 다 가져오기 프라이머리키 사용.
	//id 꺼내기
	String id = (String)session.getAttribute("memID");
	
	MemberDAO dao = new MemberDAO();
	MemberDTO member= dao.getMember(id); // id를 주고 해당 회원의 정보 받아오기
	
	// 아래 폼 양식에 뿌려주기


%>


<body>
		<br/>
		<h2 align="center">회원 정보수정</h2>
		<form action="modifyPro.jsp" method="post" name="modifyForm" onsubmit="return checkField()">
		
		<table>
		<tr>
			<td>아이디*</td>
			<td><%=member.getId() %></td>
		</tr>
		<tr>
			<td>비밀번호*</td>
			<td><input type="password" name="pw" value="<%=member.getPw() %>" /></td>
		</tr>
		<tr>
			<td>비밀번호 확인*</td>
			<td><input type="password" name="pwch"/></td>
		</tr>
		<tr>
			<td>이름 *</td>
			<td><input type="text" name="name" value="<%=member.getName() %>"/></td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
			<%=member.getGender() %> 
			</td>
		</tr>
		<tr>
			<td>email</td>
			<td>
			<%if(member.getEmail()==null){%> 
				<input type="text" name = "email"/>
			<%}else{%>
				<input type="text" name = "email" value="<%=member.getEmail()%>" />
			<%}%>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<input type="submit" value="회원정보수정"/>
			<input type="reset" value="재작성"/>
			<input type="button" value="취소" onclick="window.location='mypage.jsp'"/>
			</td>
		</tr>
	</table>	
	</form>



</body>
		<%} %>
</html>
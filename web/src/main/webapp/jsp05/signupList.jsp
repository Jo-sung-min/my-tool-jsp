
<%@page import="web.jsp05.model.SignupDTO"%>
<%@page import="web.jsp05.model.SignupDAO"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signupList.jsp</title>
</head>
<%
	//DB에서 회원목록 가져오기 : select * from signup;
	SignupDAO dao = new SignupDAO(); // DAO 사용위해 객체생성
	// 회원목록 가져오는 메서드 호출해서 결과받기
	List<SignupDTO> list =  dao.getAllMembers();

%>


<body>
	<h2> 회원 목록 페이지 </h2>
	<table border="1">
		<tr>
			<td>Id</td>
			<td>Pw</td>
			<td>Name</td>
			<td>Email</td>
			<td>Gender</td>
			<td>Hobbies</td>
			<td>job</td>
			<td>Bio</td>
			<td>Reg</td>
		</tr>
<%
	if(list == null){ %>
		<tr>
		<td colspan ="9">회원목록이 없습니다. </td>
			
		</tr>
	
		
	<%}else{ // list 가 null이 아닌경우 ==회원 목록이 하나라도 있을때
		
	

	for(int i = 0 ;i<list.size() ;i++){
		SignupDTO dto =list.get(i); //list 에서 데이터 하나 꺼내기 > dto (레코드 하나)
	%>
		
		
		<tr>
			<td><%=dto.getId() %></td>
			<td><%=dto.getPw() %></td>
			<td><%=dto.getName() %></td>
			<td><%=dto.getEmail() %></td>
			<td><%=dto.getGender() %></td>
			<td><%=dto.getMovies() %>
			<%=dto.getMusic() %>
			<%=dto.getSports() %>
			<%=dto.getTravel() %></td>
			<td><%=dto.getJob() %></td>
			<td><%=dto.getBio() %></td>
			<td><%=dto.getReg() %></td>
		</tr>
		
		
		
<% 	}
	}
%>
		
	</table>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signupPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String gender = request.getParameter("gender");
	
	String[] hobb= request.getParameterValues("hobbies");
	
	String job = request.getParameter("job");
	String bio = request.getParameter("bio");
	// 넘어온 데이터 출력확인
	System.out.println(id);
	System.out.println(pw);
	System.out.println(name);
	System.out.println(email);
	System.out.println(gender);
	for(String s : hobb){
		System.out.println(s);
	}
	System.out.println(job);
	System.out.println(bio);
	




%>






<body>




<h1>회원가입 완료</h1>
<table>
			<tr>
				<td> ID </td>			
				<td ><%=id%>  </td>			
			</tr>
			<tr>
				<td> Password * </td>			
				<td ><%=pw%></td>			
			</tr>
			<tr>
				<td> Name * </td>			
				<td ><%=name%></td>			
			</tr>
			<tr>
				<td> Email </td>			
				<td ><%=email%></td>			
			</tr>
			<tr>
				<td> Gender </td>			
				<td ><%=gender%> </td>			
			</tr>
			    <tr>
            <td>Job</td>
            <td>
               <%=job%>
            </td>
         </tr>
			
			<tr>
				<td> Hobbies </td>			
				<td >
					<% if(hobb !=null){
						for(int i = 0 ;i<hobb.length ; i++){%>
						<%=hobb[i]%>			
		
				<%	}
						
					}%>
				</td>			
			</tr>
			
			<tr>
				<td> Bio </td>			
				<td >
					<textarea rows="5" cols="22" name="bio"><%= bio%></textarea>  
				</td>			
			</tr>
	
		</table>




</body>
</html>
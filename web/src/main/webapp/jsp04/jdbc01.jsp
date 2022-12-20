<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.Time"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jdbc01.jsp</title>
</head>
<%
	//1 : JDBC 드라이버 로딩 : Class 의forNAME 메서드를 사용하여
	//				드라이버 클래스를 한번 로딩,
	//				JDBC 드라이버가 로딩되면 자동으로 객체 생성되고,
	//				Drivermanager 클래스에 등록됨.
		Class.forName("oracle.jdbc.driver.OracleDriver");

	//2 : DB접속을 위한 Connection 객체생성 (사용자계정명,비번,db,url정보)
		String username= "java14" , pw="java14" ;
		String url = "jdbc:oracle:thin:@192.168.100.250:1521:ORCL";
		Connection conn= DriverManager.getConnection(url, username, pw);
		
	//3 : 쿼리 실행을 위한 Statement 객체 생성, 쿼리문 작성
		String sql = "select * from test" ;
		PreparedStatement pstmt = conn.prepareStatement(sql); // 쿼리문 실행하기위해
	
	//4 : 쿼리 실행 
		ResultSet rs= pstmt.executeQuery();
	//5 : 가져오는 결과물이 있으면 사용
		while(rs.next()){ // 컬럼명
			String id = rs.getString("id");
			String passwd =rs.getString("pw");
			int age = rs.getInt("age");
			Timestamp reg =rs.getTimestamp("reg"); %>
			
			
			<p> id : <%=id %>/ pw <%=passwd %>/ age <%=age %>/reg: <%= reg%></p>
				
	<% 	}
	rs.close();
	pstmt.close();
	conn.close();
	//6 : 사용된 객체 (ResultSet , Statement, Connection 등 ) 종료


%>

<body>

	<h1>jdbc page</h1>


</body>
</html>
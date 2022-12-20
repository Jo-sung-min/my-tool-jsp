<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%	// 회원 가입 처리 process 페이지
	request.setCharacterEncoding("UTF-8");// 한글깨짐방지
	//form 에서 넘어온 데이터 꺼내서 변수에 담아주기
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	int age = Integer.parseInt(request.getParameter("age"));
	
	// DB 접속
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String user= "java14" , passwd="java14";
	String url = "jdbc:oracle:thin:@192.168.100.250:1521:ORCL";
	Connection conn =DriverManager.getConnection(url, user, passwd);
	
//	String sql ="insert into test values("+id+","+pw+","+age+" ,sysdate)";
//		잘 사용하지 않는 방법 보안에 취약!!
	String sql ="insert into test values(?,?,?,sysdate)"; 
	// 값을 채워야하는부분을? (placeholder) 로 대체하고 , pstmt 객체 얻어 이후에 채워준다!
		PreparedStatement pstmt =conn.prepareStatement(sql);
	// 물음표 채우기 (위 쿼리문 작성상 1 부터 시작하는 물음표의 번호, 채워줄 값);
	// 이때 setXxx() Xxx의 타입은 테이블상의 데이터타입을 기준으로 (채우는 데이터도 형변환 필요.) 
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setInt(3, age);
	

	
	// 쿼리문 실행 사용자 데이터 DB 테이블에 INSERT 하기
	
	int result=	pstmt.executeUpdate();
	System.out.println(result);
	
	// 자원해제
	pstmt.close();
	conn.close();

%>

<body>



</body>
</html>
<%@page import="web.jsp05.test.MemberDTO"%>
<%@page import="web.jsp05.test.MemberDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
   // DB 접속해서 
   MemberDAO dao = new MemberDAO(); 
   List list = dao.selectAll(); 
   // test 테이블의 전체 목록을 가져와 
   // 아래 html로 브라우저에 출력 
%>

<body>
    <%-- test테이블의 전체 목록을 보여주는 jsp페이지  --%>
   <%
      for(int i = 0; i < list.size(); i++){
    	  MemberDTO dto = (MemberDTO)list.get(i); %>
      
      <p> id : <%=dto.getId()%>, pw : <%= dto.getPw() %>, name : <%= dto.getName() %>, <%= dto.getTel() %>
      , addr: <%=dto.getAddr()%> ,favorite : <%=dto.getFavorite()%> </p>   
         
   <%   }
   %>



</body>
</html>
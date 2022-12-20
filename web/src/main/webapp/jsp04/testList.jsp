
<%@page import="web.jsp04.test.TestDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.jsp04.test.TestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>testList.jsp</title>
</head>
<%
   // DB 접속해서 
   TestDAO dao = new TestDAO(); 
   List list = dao.selectAll(); 
   // test 테이블의 전체 목록을 가져와 
   // 아래 html로 브라우저에 출력 
%>

<body>
    <%-- test테이블의 전체 목록을 보여주는 jsp페이지  --%>
   <%
      for(int i = 0; i < list.size(); i++){
         TestDTO dto = (TestDTO)list.get(i); %>
      
      <p> id : <%=dto.getId()%>, pw : <%= dto.getPw() %>, age : <%= dto.getAge() %>, <%= dto.getReg() %> </p>   
         
   <%   }
   %>



</body>
</html>
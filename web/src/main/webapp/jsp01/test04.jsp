<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <h1>test04 page</h1>
    
    <%-- #1. 선언부 --%>
    <%!// 이렇게 열면 자바 사용가능
       // 선언부 : 클래스영역
       // 클래스변수 , 인스턴스변수, 메서드
       static int num = 10;
    	int num2 = 200;
    	public int mul (int a , int b){
    		return a*b;
    	}
    	// 리턴 있는 메서드들은 아래처럼 호출 가능함
    
    %>
    
    <%-- #2. 출력문 : 세미콜론 ; 안적음. 변수명, 
    리턴있는 메서드 호출하면 값 화면에 출력 --%>
    <%=num %><br/>
    <%=num2 %><br/>
    10 * 20 = <%=mul(10,20) %>		
    
    <%-- #3. 스크립트릿 가장많이 사용--%>
    <%
    	// 스크립트릿 : 메서드 영역
    	for(int i = 0 ;i<num ; i++){
    		out.println("java server pages"+i+"<br/>");
    		
    	}
    	String col = "yellow";
    	
    
    %>
    <ul>
    	<%// 자바와 html 동시 사용해보기  
    	for(int i = 0 ;i<10 ;i++){ %>
    	<li> hello jsp </li>
    <%}// for 닫힘 %>
    </ul>
    
    
    <body bgcolor="<%= col%>">
    
    
    </body> 
    
    
<%@page import="web.jsp07.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
		//여기로 올 가능성
		//loginForm > Pro (파라미터 들고옴)
		//main > 쿠키 있다고 pro(파라미터 x)

		request.setCharacterEncoding("UTF-8"); // 한글꺠짐 방지
		// 넘어온 파리머터 꺼내기 (main에서 바로 왔으면 아래 변수 null)
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String auto = request.getParameter("auto");
		
		//쿠키를 꺼내서 정보가 나오면 위변수에 저장
		Cookie[] coos= request.getCookies();
		if(coos !=null){
			for(Cookie c : coos){
				if(c.getName().equals("autoId")) id =c.getValue();
				if(c.getName().equals("autoPw")) pw =c.getValue();
				if(c.getName().equals("autoCh")) auto =c.getValue();
				
			}
		}




	MemberDAO dao = new MemberDAO();
    boolean result = dao.idPwCheck(id, pw);
	
    
    if(result){//일치할때 : 로그인 상태로 만들기
    	//자동 로그인이면 쿠키도 생성
    	if(auto!=null){	// 자동로그인 체크했다.
    		Cookie c1 = new Cookie("autoId",id);
    		Cookie c2 = new Cookie("autoPw",pw);
    		Cookie c3 = new Cookie("autoCh",auto);
    		
    		c1.setMaxAge(60*60*24);
    		c2.setMaxAge(60*60*24);
    		c3.setMaxAge(60*60*24);
    		
    		response.addCookie(c1);
    		response.addCookie(c2);
    		response.addCookie(c3);
    	}
    
    
     session.setAttribute("memID", id);
     response.sendRedirect("main.jsp");
     
     
     %>
		    	
   <% }else{//불일치할떄%>
		<script >
			alert("아이디또는 비밀번호가 맞지 않습니다...");
			history.go(-1);
		</script>
   <% }%>






</body>
</html>